#Build Stage
FROM node:14-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

#We won't use the volume because we are already in the production
COPY . .

RUN npm run build
#/app/build is the file we will copy to the next stage

#Run Stage
FROM nginx:1.25.3-alpine

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html