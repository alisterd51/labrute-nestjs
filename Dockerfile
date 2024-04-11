FROM node:21.7.3-alpine@sha256:6d0f18a1c67dc218c4af50c21256616286a53c09e500fadf025b6d342e1c90ae AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.7.3-alpine@sha256:6d0f18a1c67dc218c4af50c21256616286a53c09e500fadf025b6d342e1c90ae AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.7.3-alpine@sha256:6d0f18a1c67dc218c4af50c21256616286a53c09e500fadf025b6d342e1c90ae AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
