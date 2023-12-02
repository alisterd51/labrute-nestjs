FROM node:21.3.0-alpine@sha256:3dab5cc219983a5f1904d285081cceffc9d181e64bed2a4a18855d2d62c64ccb AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.3.0-alpine@sha256:3dab5cc219983a5f1904d285081cceffc9d181e64bed2a4a18855d2d62c64ccb AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.3.0-alpine@sha256:3dab5cc219983a5f1904d285081cceffc9d181e64bed2a4a18855d2d62c64ccb AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
