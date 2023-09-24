# Step 1: Build the Angular application
FROM node:16.20.2 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Step 2: Serve the application with Nginx
FROM nginx:alpine3.18

COPY --from=build /app/dist/angular-conduit/ /usr/share/nginx/html
