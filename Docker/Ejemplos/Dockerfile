# syntax=docker/dockerfile:1
# FROM node:10.14.2-jessie
# WORKDIR /app
# COPY . .
# ## RUN npm install
# ENV WEB_PORT=3002
# EXPOSE 3002
# RUN yarn install --dev && yarn build
# CMD ["yarn", "start"]

#FROM node:10.14.2-jessie-slim
#WORKDIR /app
#COPY . .
# RUN npm install
#ENV WEB_PORT=3002
#EXPOSE 3002
#RUN yarn install --dev && yarn build
#CMD ["yarn", "start"]


#FROM node:10.14.2-alpine
#WORKDIR /app
#COPY . .
#ENV WEB_PORT=3002
#EXPOSE 3002
#RUN yarn install --dev && yarn build
#CMD ["yarn", "start"]

#FROM node:10.14.2-alpine AS builder
#WORKDIR /app
#COPY . .
#RUN yarn install --dev && yarn build

#FROM node:10.14.2-alpine
#WORKDIR /app
#COPY --from=builder /app .
#ENV WEB_PORT=3002
#EXPOSE 3002:3002
#CMD ["yarn", "start"]


FROM node:10.14.2-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install && yarn build

FROM node:10.14.2-alpine
COPY --from=builder ./app/dist ./dist
COPY package.json .
ENV WEB_PORT=3002
EXPOSE 3002
CMD [ "yarn", "start" ]

