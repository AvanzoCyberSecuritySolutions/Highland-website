# # -------------------
# # Stage 1: Build Flutter Web
# # -------------------
# FROM debian:latest AS build-env

# # Install dependencies
# RUN apt-get update && \
#     apt-get install -y \
#         curl git wget unzip libgconf-2-4 gdb libglu1-mesa fonts-droid-fallback python3 && \
#     apt-get clean

# # Clone Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# # Set Flutter paths
# ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# # Enable web support
# RUN flutter doctor -v && \
#     flutter channel stable && \
#     flutter upgrade && \
#     flutter config --enable-web

# # Copy project files
# WORKDIR /app
# COPY . .



# # Clean default html directory
# RUN rm -rf /usr/share/nginx/html/*

# # Copy web build to NGINX html directory
# COPY --from=build-env /app/build/web /usr/share/nginx/html

# # Expose port
# EXPOSE 80

# # Start NGINX
# CMD ["nginx", "-g", "daemon off;"]
# -------------------
# Stage 1: Build Flutter Web
# -------------------
# Use a specific Flutter version for more consistent builds
FROM cirrusci/flutter:3.19.6 AS build-env

# Copy only the dependency file first to leverage Docker cache
WORKDIR /app
COPY pubspec.yaml ./
RUN flutter pub get

# Now copy the rest of the project files
COPY . .

# Build the web application
# The --no-wasm-dry-run flag is added to avoid warnings that don't stop the build
RUN flutter build web --release --no-wasm-dry-run

# -------------------
# Stage 2: Serve via NGINX
# -------------------
FROM nginx:1.21.1-alpine

# Clean default html directory
RUN rm -rf /usr/share/nginx/html/*

# Copy web build from the build stage to NGINX html directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
