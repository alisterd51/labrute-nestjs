FROM node:21.7.3-alpine@sha256:c986eb0b8970240f8d648e524bab46016b78f290f912aac16a4aa6705dde05f4 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.7.3-alpine@sha256:c986eb0b8970240f8d648e524bab46016b78f290f912aac16a4aa6705dde05f4 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.7.3-alpine@sha256:c986eb0b8970240f8d648e524bab46016b78f290f912aac16a4aa6705dde05f4 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
