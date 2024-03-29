# Step 1: Build the app
FROM node:20-alpine as build

# Create app directory

WORKDIR /app

# Install app dependencies
COPY package.json .

# Install dependencies
RUN npm install

COPY . .

RUN npm run build

# Step 2: Serve the app
# Use nginx image
FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf *

COPY --from=build /app/build . 
EXPOSE 80
ENTRYPOINT [ "nginx","-g","daemon off;" ]
