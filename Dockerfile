#Stage 1 - Install dependencies and build the app
FROM debian:latest AS build-stage

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget zip unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Run flutter doctor and set path
RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web

# # Copy files to container and build
RUN mkdir /usr/local/VotingMobile
COPY . /usr/local/VotingMobile
WORKDIR /usr/local/VotingMobile
RUN /usr/local/flutter/bin/flutter build web

# # Stage 2 - Create the run-time image
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /usr/local/VotingMobile/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]