# Ivan Project

Проект развертывания микросервиса на FastAPI с использованием Docker, Terraform, Yandex Cloud и Kubernetes (Minikube).

## Выполненные задачи:
1. **Разработка**: Создан REST-сервис на FastAPI (Python 3.10) с эндпоинтами / и /health.
2. **Контейнеризация**: Написан Dockerfile, собран образ и загружен на Docker Hub (alloonbek/ivan-project:v1).
3. **Инфраструктура (IaaC)**: С помощью Terraform развернута облачная инфраструктура в Yandex Cloud (сеть, подсеть и виртуальная машина на базе Container Optimized Image с автоматическим запуском контейнера через Docker Compose).
4. **Оркестрация**: Написан манифест Kubernetes, включающий Namespace, Deployment (2 реплики приложения) и Service (тип NodePort) для локального развертывания в кластере Minikube.

## Стек технологий:
* FastAPI / Uvicorn / Python
* Docker
* Terraform
* Yandex Cloud
* Kubernetes / Minikube