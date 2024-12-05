# Spring Boot Readonly Root Example Application

Purpose of this application is to showcase running a Spring Boot application with a read-only root filesystem in an AWS
ECS container. Spring requires certain folders to be writable, and the `Dockerfile` together with
`ecs-task-definition.json` enable these, while still setting the root filesystem to read-only.

The pre-build container is available in Docker Hub

```shell
docker pull pasiorovuo/spring-boot-readonly-root:latest
```
