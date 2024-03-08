FROM node:21.7.0-alpine@sha256:7bfef1d72befbb72b0894a3e4503edbdc0441058b4d091325143338cbf54cff8 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.7.0-alpine@sha256:7bfef1d72befbb72b0894a3e4503edbdc0441058b4d091325143338cbf54cff8 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.7.0-alpine@sha256:7bfef1d72befbb72b0894a3e4503edbdc0441058b4d091325143338cbf54cff8 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
