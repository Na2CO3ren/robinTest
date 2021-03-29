

# First stage: complete build environment
FROM maven:3.5.0-jdk-8-alpine AS builder

# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./web web/
ADD ./service service/

# package jar
RUN mvn clean package

# Second stage: minimal runtime environment
FROM openjdk:8-jre-alpine

# copy jar from the first stage
COPY --from=builder web/target/robin-web-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar

EXPOSE 1018

CMD java -jar my-app-1.0-SNAPSHOT.jar  --spring.profiles.active=daily

#
#### 基础镜像，使用alpine操作系统，openjkd使用8u201
#FROM java:8
#
##作者
#MAINTAINER Robin
#
##系统编码
#ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
#
##声明一个挂载点，容器内此路径会对应宿主机的某个文件夹
#VOLUME /tmp
#
#
#RUN sh mvnw package
##RUN mvn clean package

#
#ARG JAR_FILE
#COPY ${JAR_FILE} ./app.jar
#
#COPY ./target /testweb
#
#
#COPY ./web/robin-web-1.0-SNAPSHOT.jar /abcd.jar
#
#
#COPY ./app.jar /abcd.jar
#
#ENTRYPOINT ["java","-jar","/app.jar"]
#
###应用构建成功后的jar文件被复制到镜像内，名字也改成了app.jar
##COPY /robin-web-1.0-SNAPSHOT.jar robinDemo.jar
##
###启动容器时的进程
##ENTRYPOINT ["java","-jar","/robinDemo.jar"]
#
##暴露8088端口,这个端口对应的是服务本身的端口
#EXPOSE 1018