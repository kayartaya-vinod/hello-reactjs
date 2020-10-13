FROM node:alpine as stage1

# create the directory sturcture (if not exist already)
# and cd into the workdir
WORKDIR /usr/vinod/app

COPY ./package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx:alpine

COPY --from=stage1 /usr/vinod/app/build /usr/share/nginx/html

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]