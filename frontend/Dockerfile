FROM node:10

WORKDIR /app

COPY . .

RUN npm install -g serve

COPY ./package.json .

RUN npm install

RUN npm run build

CMD [ "serve", "-s", "build", "-l", "7000" ]



