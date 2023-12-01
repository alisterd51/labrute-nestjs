FROM node:21.2.0-alpine@sha256:5fc1d095e47286b0859342a7b8a90b1c3adf2c283f12c6542a5456c1f2955218 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.2.0-alpine@sha256:5fc1d095e47286b0859342a7b8a90b1c3adf2c283f12c6542a5456c1f2955218 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.2.0-alpine@sha256:5fc1d095e47286b0859342a7b8a90b1c3adf2c283f12c6542a5456c1f2955218 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
