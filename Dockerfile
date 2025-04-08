FROM node:16-alpine
WORKDIR /usr/src/app
COPY *.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node","app.js"]
