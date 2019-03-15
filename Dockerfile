FROM node:8.1.2

# Reference: https://github.com/facebook/create-react-app/issues/982
# Reference: https://stackoverflow.com/questions/19537645/get-environment-variable-value-in-dockerfile
ARG CI_COMMIT_SHA
ENV CI_COMMIT_SHA=$CI_COMMIT_SHA
ARG NPM_TOKEN
ENV NPM_TOKEN=$NPM_TOKEN

WORKDIR /app
COPY package.json /app
COPY yarn.lock /app
RUN npm config set //registry.npmjs.org/:_authToken $NPM_TOKEN
RUN npm install -g yarn
RUN yarn install
COPY . /app
RUN yarn build
RUN echo commit $CI_COMMIT_SHA
RUN node scripts/generateEnvFile.js || exit 1
EXPOSE 443
# PM2 reference: https://semaphoreci.com/community/tutorials/dockerizing-a-node-js-web-application
CMD ["node", "build/app.js"]
# ENTRYPOINT ["/docker-entrypoint.sh"]
