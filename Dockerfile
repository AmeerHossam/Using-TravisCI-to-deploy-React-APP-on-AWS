#Build Stage
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

#We won't use the volume because we are already in the production
COPY . .

RUN npm run build
#/app/build is the file we will copy to the next stage

#Run Stage
FROM nginx

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
