$(aws ecr get-login --no-include-email --region ${AWS_REGION})
docker build --build-arg CI_COMMIT_SHA=$TRAVIS_COMMIT -t $REPOSITORY_URL:$TRAVIS_COMMIT -t $REPOSITORY_URL:latest .
docker push $REPOSITORY_URL
# Wait for 20 minutes for deploy
ecs deploy --region ${AWS_REGION} ${PRODUCTION_CLUSTER_NAME} ${PRODUCTION_SERVICE_NAME} --timeout 3000 --tag $TRAVIS_COMMIT --ignore-warnings
