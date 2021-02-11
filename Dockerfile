FROM node:latest

WORKDIR /usr/src/app

COPY . .

RUN yarn
RUN yarn build

CMD [ "yarn", "start" ]

EXPOSE 5000
