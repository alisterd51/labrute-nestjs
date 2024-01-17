FROM node:21.6.0-alpine@sha256:ab620cffd0f4d4529ef97682b2309c0571cd14a75496aa0934a13b059d003647 AS development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
USER node

FROM node:21.6.0-alpine@sha256:ab620cffd0f4d4529ef97682b2309c0571cd14a75496aa0934a13b059d003647 AS build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN npm run build --omit=dev
ENV NODE_ENV production
RUN npm ci --omit=dev && npm cache clean --force
USER node

FROM node:21.6.0-alpine@sha256:ab620cffd0f4d4529ef97682b2309c0571cd14a75496aa0934a13b059d003647 AS production
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist
CMD [ "node", "dist/main.js" ]
