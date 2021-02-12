FROM node:latest

WORKDIR /usr/src/app

COPY . .

RUN yarn
RUN yarn build

CMD [ "yarn", "start:movies" ]

EXPOSE 5000
