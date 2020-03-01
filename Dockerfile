# The first instruction is what image we want to base our container on
# We Use an official Node version 10 image as a parent image
FROM node:8.10

# Create an environment variable for MongoDB URI
ENV MONGODB_URI='mongodb://localhost:27017/realestate'

# Set working directory for the project to /usr/src/app
# NOTE: all the directives that follow in the Dockerfile will be executed
# in working directory.
WORKDIR /usr/src/app

# Copy the contents of the project folder into the working directory of
# docker image
COPY . /usr/src/app/

# Install any needed packages specified in package.json
RUN npm install

RUN ls /usr/src/app
RUN ls /usr/src/app/public

EXPOSE 5000

HEALTHCHECK --interval=1m --timeout=5s --start-period=1m \
  CMD nc -z -w5 127.0.0.1 5080 || exit 1

CMD echo "Warming up" && sleep 5 && npm start