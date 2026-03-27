# 🐳 TOTAL Protocol | Docker Deployment Guide

Deploying the **Sentinel Core v.8.2** inside a Docker container ensures a secure, isolated, and standardized environment for hardware-level logic verification.

---

### 1. Prerequisites
Ensure you have **Docker** and **Docker Compose** installed on your system.
* [Install Docker](https://docs.docker.com/get-docker/)

### 2. Quick Build & Run
To compile and run the Sentinel node in a single command:
```bash
docker build -t sentinel-core .
docker run --rm -it sentinel-core
