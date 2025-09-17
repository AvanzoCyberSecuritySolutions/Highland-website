# -------------------
# Stage 1: Build Flutter Web
# -------------------

# Use a well-maintained, official Flutter image with a specific version tag.
# 'hey_zap/flutter:3.19.5' is a valid and stable image.
FROM heyzap/flutter:3.19.5 AS build-env

# Set the working directory inside the container
WORKDIR /app

# --- OPTIMIZED CACHING ---
# 1. Copy only the dependency files first.
# This layer will be cached and only re-run if pubspec.yaml changes.
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# 2. Now, copy the rest of your project source code.
# If you only change your Dart code, the slow 'flutter pub get' step is skipped.
COPY . .

# 3. Build the web application.
# The --no-wasm-dry-run flag suppresses WebAssembly warnings that aren't errors.
RUN flutter build web --release --no-wasm-dry-run


# -------------------
# Stage 2: Serve via NGINX
# -------------------
FROM nginx:1.21.1-alpine

# Clean default NGINX directory
RUN rm -rf /usr/share/nginx/html/*

# Copy the built web application from the 'build-env' stage
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start NGINX in the foreground so the container stays running
CMD ["nginx", "-g", "daemon off;"]