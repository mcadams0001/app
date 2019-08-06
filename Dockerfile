FROM node:alpine as builder
WORKDIR /app
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM httpd:latest
ENV LICENSE=12345678
ENV LOCATION=US
WORKDIR /usr/local/apache2/htdocs
RUN echo "<html><body>License: ${LICENSE}<br/>Location:${LOCATION}</body></html>" > info.html
COPY --from=builder /app/dist/adam /usr/local/apache2/htdocs
EXPOSE 80