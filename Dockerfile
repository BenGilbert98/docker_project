# # build this image from the official image of node
# FROM node:latest

# # Reference to who built the image
# LABEL MAINTAINER=bgilbert@spartaglobal.com

# # Creating a directory in the container
# WORKDIR /usr/src/app


# COPY package*.json ./

# # Copies the current directory to the working directory specified above
# COPY . .

# RUN npm install


# # Expose port 3001 to launch in the browser
# EXPOSE 3000

# CMD ["node", "app.js"]

# ________________________________________________________________________
# Creating micro-services for nodejs front-end using Docker

# Select the latest node image to work from
FROM node as App

# Who edited this docker file
LABEL MAINTAINER=bgilbert@spartaglobal.com

# Choose the working directory
WORKDIR /usr/src/app

COPY package*.json ./

# 1. (. = copy whole current directory) 2. (. = to current working directory)
COPY . .

# Install npm
RUN npm install 

#####################
# Second stage -> Multi Stage Docker build
FROM node:alpine

# Magical line -> Copies only essential things to the layer
# Compresses the size, creates a lighter weight image
COPY --from=App /usr/src/app /usr/src/app

WORKDIR /usr/src/app

RUN npm install 

# Default port 3000
EXPOSE 3000

# Start app with CMD | node
# CMD command cd /seeds && npm run postinstall && node app.js
# CMD command cd /usr/src/app/seeds, donpm run postinstall, node app.js 
# CMD ["npm", "run", "seed"]
CMD ["node", "app.js"]