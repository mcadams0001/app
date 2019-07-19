FROM node:alpine as builder
WORKDIR /app
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM httpd:latest
COPY --from=builder /app/dist/adam /usr/local/apache2/htdocs