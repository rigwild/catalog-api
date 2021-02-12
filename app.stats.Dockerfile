FROM node:latest

WORKDIR /usr/src/app

COPY . .

RUN yarn
RUN yarn build

CMD [ "yarn", "start:stats" ]

EXPOSE 5000
