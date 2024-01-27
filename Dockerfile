FROM node:21.6.0-alpine@sha256:a8beafd69068c05d09183e75b9aa679b520ba68f94b19c90d0da9f307f9f6565 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.6.0-alpine@sha256:a8beafd69068c05d09183e75b9aa679b520ba68f94b19c90d0da9f307f9f6565 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.6.0-alpine@sha256:a8beafd69068c05d09183e75b9aa679b520ba68f94b19c90d0da9f307f9f6565 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
