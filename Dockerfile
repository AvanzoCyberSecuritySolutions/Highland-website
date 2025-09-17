# -------------------
# Stage 1: Build Flutter Web
# -------------------
FROM debian:latest AS build-env

# Install necessary system dependencies
RUN apt-get update && \
    apt-get install -y curl git wget unzip gdb libglu1-mesa fonts-droid-fallback python3 && \
    apt-get clean

# Clone the Flutter SDK from the official repository
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Add Flutter to the system's PATH environment variable
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-warm the Flutter tool and enable web support
# Running 'flutter doctor' downloads necessary components
RUN flutter doctor -v
RUN flutter config --enable-web

# Set the working directory for the application
WORKDIR /app

# --- OPTIMIZED CACHING ---
# 1. Copy only the dependency files first.
# This step is cached and only re-runs if pubspec.yaml or pubspec.lock changes.
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# 2. Now, copy the rest of your project source code.
# If you only change your Dart code, the slow 'flutter pub get' step is skipped.
COPY . .

# 3. Build the web application.
RUN flutter build web --release

# -------------------
# Stage 2: Serve via NGINX
# -------------------
FROM nginx:1.21.1-alpine

# Clean the default NGINX web root directory
RUN rm -rf /usr/share/nginx/html/*

# Copy the built web app from the 'build-env' stage to the NGINX directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start NGINX in the foreground so the container stays running
CMD ["nginx", "-g", "daemon off;"]