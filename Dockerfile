# -------------------
# Stage 1: Build Flutter Web
# -------------------
FROM debian:latest AS build-env

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        curl git wget unzip gdb libglu1-mesa fonts-droid-fallback python3 && \
    apt-get clean


# Clone Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter paths
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable web support
RUN flutter doctor -v && \
    flutter channel stable && \
    flutter upgrade && \
    flutter config --enable-web

# Copy project files
WORKDIR /app
COPY . .

# Get dependencies and build
RUN flutter pub get
RUN flutter build web --release

# -------------------
# Stage 2: Serve via NGINX
# -------------------
FROM nginx:1.21.1-alpine

# Clean default html directory
RUN rm -rf /usr/share/nginx/html/*

# Copy web build to NGINX html directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
