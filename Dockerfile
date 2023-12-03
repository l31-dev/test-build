# build 
FROM node:18-alpine as build

WORKDIR /app
COPY package.json /app
COPY pnpm-lock.yaml /app
RUN npm install -g pnpm && pnpm install
COPY . .
RUN npm run build

# start
FROM node:18-alpine

WORKDIR /app
COPY --from=build /app/dist/* /app/
COPY --from=build /app/package.json /app

RUN npm install --omit=dev
CMD node server.js