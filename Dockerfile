FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/irynadiudiuk/hiapp.git

FROM maven:3.5 as builder
WORKDIR /app
COPY --from=clone /app/hiapp/ /app
RUN mvn clean package

FROM tomcat:8-jre8
WORKDIR /app
COPY --from=builder /app/target/hiapp.war /usr/local/tomcat/webapps/
EXPOSE 8080

