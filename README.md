# 🚀 Ivan Project

[![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Container-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Terraform](https://img.shields.io/badge/Terraform-Infrastructure-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Yandex.Cloud](https://img.shields.io/badge/Yandex-Cloud-E61428?logo=yandex&logoColor=white)](https://cloud.yandex.ru/)

Комплексный проект по контейнеризации, автоматизации инфраструктуры (IaaC) и оркестрации микросервиса. В рамках задания разработан REST-сервис, упакован в Docker-контейнер, развернут в Яндекс Облаке через Terraform и оркестрирован локально с помощью Kubernetes (Minikube).

---

## 🏗️ Архитектура и компоненты проекта

* **Backend:** Python-приложение на базе фреймворка FastAPI.
* **Контейнеризация:** Сборка легковесного Docker-образа на базе `slim`-версии Python.
* **Инфраструктура (IaaC):** Автоматическое управление облачной сетью, подсетью и виртуальной машиной (Container Optimized Image) в Yandex Cloud.
* **Оркестрация:** Развертывание отказоустойчивого кластера с распределением нагрузки (2 реплики) и службой доступа NodePort.

---

## 🛠️ Стек технологий

* **Язык:** Python 3.10
* **Фреймворк:** FastAPI + Uvicorn
* **IaaC:** Terraform
* **Облачный провайдер:** Yandex Cloud (YC CLI)
* **Реестр образов:** Docker Hub
* **Оркестратор:** Kubernetes (Minikube + kubectl)

---

## 📋 Выполненные шаги и структура проекта

### 1. Разработка сервиса (FastAPI)
Приложение содержит два эндпоинта для проверки работоспособности:
* `GET /` — приветственное сообщение.
* `GET /health` — проверка статуса здоровья сервиса (Health Check).

### 2. Докеризация (`/Dockerfile`)
Настроен многоэтапный и оптимизированный процесс сборки. Образ успешно отправлен в публичный репозиторий Docker Hub:
👉 **Репозиторий образа:** `balloobek/ivan-project:v1`

### 3. Инфраструктура как код (`/terraform`)
Скрипты Terraform полностью автоматизируют развертывание в `ru-central1-a`:
* Создание изолированной сети `ivan-network`.
* Создание подсети `ivan-subnet` (`192.168.10.0/24`).
* Развертывание ВМ `ivan-project-vm` на базе актуального **Container Optimized Image**, которая автоматически запускает целевой контейнер через встроенный Docker Compose.

### 4. Оркестрация Kubernetes (`/k8s`)
Создан единый декларативный манифест `deployment.yaml`, который разворачивает:
* **Namespace:** `ivan-namespace` для изоляции ресурсов проекта.
* **Deployment:** `ivan-api-deployment` с конфигурацией на **2 активные реплики** (поды) для обеспечения высокой доступности.
* **Service:** `ivan-api-service` типа `NodePort` (порт `30000`) для маршрутизации внешнего трафика к подам.

---

## 🚀 Инструкция по запуску и проверке

### Проверка облачного окружения (Terraform)
После применения манифестов Terraform инфраструктура выдает внешний IP-адрес.
```bash
# Пример проверки доступности облачного сервиса
Invoke-RestMethod -Uri "http://<EXTERNAL_VM_IP>/"
Invoke-RestMethod -Uri "http://<EXTERNAL_VM_IP>/health"
