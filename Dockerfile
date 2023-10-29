# Use an official Node runtime as the base image
FROM node:20 as build-stage

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json for installing dependencies
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project into the container
COPY . .

# Build the Angular project
RUN npx ng build

# Start a new stage to create a smaller image
FROM nginx:1.25-bookworm

# Copy the build output to replace the default nginx contents
COPY --from=build-stage /app/dist/angular-conduit /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
