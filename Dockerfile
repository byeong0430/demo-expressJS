FROM node:8.1.2

# Reference: https://github.com/facebook/create-react-app/issues/982
# Reference: https://stackoverflow.com/questions/19537645/get-environment-variable-value-in-dockerfile
ARG CI_COMMIT_SHA
ENV CI_COMMIT_SHA=$CI_COMMIT_SHA

RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN npm install

# PM2 reference: https://semaphoreci.com/community/tutorials/dockerizing-a-node-js-web-application
CMD ["node", "server.js"]
