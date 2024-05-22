FROM node:21.7.3-alpine@sha256:d44678a321331f2f003b51303cc5105f9787637e0524cf94d4323d08050a99c9 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.7.3-alpine@sha256:d44678a321331f2f003b51303cc5105f9787637e0524cf94d4323d08050a99c9 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.7.3-alpine@sha256:d44678a321331f2f003b51303cc5105f9787637e0524cf94d4323d08050a99c9 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
