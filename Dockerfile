FROM node:16.16

WORKDIR /usr/src/app


COPY package*.json tsconfig.json ./

COPY . .

COPY .env .env

RUN yarn

RUN yarn build

EXPOSE 3000
CMD [ "npm", "run", "start" ]
