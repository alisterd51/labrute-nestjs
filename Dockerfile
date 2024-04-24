FROM node:21.7.3-alpine@sha256:db8772d9f5796ac4e8c47508038c413ea1478da010568a2e48672f19a8b80cd2 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.7.3-alpine@sha256:db8772d9f5796ac4e8c47508038c413ea1478da010568a2e48672f19a8b80cd2 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.7.3-alpine@sha256:db8772d9f5796ac4e8c47508038c413ea1478da010568a2e48672f19a8b80cd2 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
