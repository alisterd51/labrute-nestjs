FROM node:21.7.2-alpine@sha256:6b840bf0506e8dfd3e3ce9e8c0cfb7c21333cdedabb25425b6ddc555d5df2442 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.7.2-alpine@sha256:6b840bf0506e8dfd3e3ce9e8c0cfb7c21333cdedabb25425b6ddc555d5df2442 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.7.2-alpine@sha256:6b840bf0506e8dfd3e3ce9e8c0cfb7c21333cdedabb25425b6ddc555d5df2442 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
