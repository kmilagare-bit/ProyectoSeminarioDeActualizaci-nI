# 1. Etapa de compilación (Usa Node para construir el proyecto)
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 2. Etapa de producción (Usa Nginx para servir la aplicación)
FROM nginx:alpine
COPY --from=build /app/dist/frontend/browser/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
