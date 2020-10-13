FROM node:alpine as stage1

WORKDIR /usr/vinod/app

COPY ./package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx:alpine

COPY --from=stage1 ./ /usr/share/nginx/html/

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]