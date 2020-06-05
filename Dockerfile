FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn

COPY . .

ARG VUE_APP_SNWBRD_BOOTSTRAP_HOST
ARG VUE_APP_SNWBRD_BOOTSTRAP_PROTOCOL
ARG VUE_APP_SNWBRD_BOOTSTRAP_CHAIN_ID
ARG VUE_APP_SNWBRD_BOOTSTRAP_PORT
ARG VUE_APP_SNWBRD_BOOTSTRAP_NETWORK_ID

# 'LOCAL' NODE RELATED CONFIG

ARG VUE_APP_SNWBRD_NODE_HOST
ARG VUE_APP_SNWBRD_NODE_PROTOCOL
ARG VUE_APP_SNWBRD_NODE_CHAIN_ID
ARG VUE_APP_SNWBRD_NODE_PORT
ARG VUE_APP_SNWBRD_NODE_NETWORK_ID

ENV VUE_APP_SNWBRD_BOOTSTRAP_HOST $VUE_APP_SNWBRD_BOOTSTRAP_HOST
ENV VUE_APP_SNWBRD_BOOTSTRAP_PROTOCOL $VUE_APP_SNWBRD_BOOTSTRAP_PROTOCOL
ENV VUE_APP_SNWBRD_BOOTSTRAP_CHAIN_ID $VUE_APP_SNWBRD_BOOTSTRAP_CHAIN_ID
ENV VUE_APP_SNWBRD_BOOTSTRAP_PORT $VUE_APP_SNWBRD_BOOTSTRAP_PORT
ENV VUE_APP_SNWBRD_BOOTSTRAP_NETWORK_ID $VUE_APP_SNWBRD_BOOTSTRAP_NETWORK_ID

# 'LOCAL' NODE RELATED CONFIG

ENV VUE_APP_SNWBRD_NODE_HOST $VUE_APP_SNWBRD_NODE_HOST
ENV VUE_APP_SNWBRD_NODE_PROTOCOL $VUE_APP_SNWBRD_NODE_PROTOCOL
ENV VUE_APP_SNWBRD_NODE_CHAIN_ID $VUE_APP_SNWBRD_NODE_CHAIN_ID
ENV VUE_APP_SNWBRD_NODE_PORT $VUE_APP_SNWBRD_NODE_PORT
ENV VUE_APP_SNWBRD_NODE_NETWORK_ID $VUE_APP_SNWBRD_NODE_NETWORK_ID


RUN yarn build

FROM nginx:stable-alpine as production-stage

ARG VUE_APP_SNWBRD_BOOTSTRAP_HOST
ARG VUE_APP_SNWBRD_BOOTSTRAP_PROTOCOL
ARG VUE_APP_SNWBRD_BOOTSTRAP_CHAIN_ID
ARG VUE_APP_SNWBRD_BOOTSTRAP_PORT
ARG VUE_APP_SNWBRD_BOOTSTRAP_NETWORK_ID

# 'LOCAL' NODE RELATED CONFIG

ARG VUE_APP_SNWBRD_NODE_HOST
ARG VUE_APP_SNWBRD_NODE_PROTOCOL
ARG VUE_APP_SNWBRD_NODE_CHAIN_ID
ARG VUE_APP_SNWBRD_NODE_PORT
ARG VUE_APP_SNWBRD_NODE_NETWORK_ID

ENV VUE_APP_SNWBRD_BOOTSTRAP_HOST =$VUE_APP_SNWBRD_BOOTSTRAP_HOST
ENV VUE_APP_SNWBRD_BOOTSTRAP_PROTOCOL =$VUE_APP_SNWBRD_BOOTSTRAP_PROTOCOL
ENV VUE_APP_SNWBRD_BOOTSTRAP_CHAIN_ID =$VUE_APP_SNWBRD_BOOTSTRAP_CHAIN_ID
ENV VUE_APP_SNWBRD_BOOTSTRAP_PORT = $VUE_APP_SNWBRD_BOOTSTRAP_PORT
ENV VUE_APP_SNWBRD_BOOTSTRAP_NETWORK_ID = $VUE_APP_SNWBRD_BOOTSTRAP_NETWORK_ID

# 'LOCAL' NODE RELATED CONFIG

ENV VUE_APP_SNWBRD_NODE_HOST = $VUE_APP_SNWBRD_NODE_HOST
ENV VUE_APP_SNWBRD_NODE_PROTOCOL = $VUE_APP_SNWBRD_NODE_PROTOCOL
ENV VUE_APP_SNWBRD_NODE_CHAIN_ID = $VUE_APP_SNWBRD_NODE_CHAIN_ID
ENV VUE_APP_SNWBRD_NODE_PORT = $VUE_APP_SNWBRD_NODE_PORT
ENV VUE_APP_SNWBRD_NODE_NETWORK_ID = $VUE_APP_SNWBRD_NODE_NETWORK_ID

COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
