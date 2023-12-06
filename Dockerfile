FROM node:21.4.0-alpine@sha256:9bfaec4816d320226b1533abd5d22d6a888105ee502b820676736de99a198408 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.4.0-alpine@sha256:9bfaec4816d320226b1533abd5d22d6a888105ee502b820676736de99a198408 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.4.0-alpine@sha256:9bfaec4816d320226b1533abd5d22d6a888105ee502b820676736de99a198408 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
