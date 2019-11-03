FROM openjdk:8-jre-alpine
MAINTAINER Mikhail Samohin <misfis123@gmail.com>
WORKDIR /app
VOLUME /tmp
ADD ./target/VUchobe.jar /app/
EXPOSE 8082

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=prod","-Xmx300m", "-jar", "VUchobe.jar"]

