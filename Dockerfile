FROM node:16-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

FROM alpine:3.14 AS production
RUN apk add --no-cache nodejs
WORKDIR /app
COPY --from=build /app .
RUN adduser -D -u 10001 appuser
USER appuser

CMD node index.js