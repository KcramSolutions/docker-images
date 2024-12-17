#!/bin/bash
# Definimos algunas variables globales
if [ -z "$1" ]; then
  echo "Por favor, proporciona una carpeta (como rust, node, python, java)."
  exit 1
fi

# REGISTRY="docker.kcramsolutions.org"
REGISTRY="kcramsolutions"
TAG="latest"
DOCKERFOLDERS="rust node python java"
FOLDER=$1
PLATFORM=linux/arm64,linux/amd64,linux/arm/v7
DOCKERFILE_PATH="./$FOLDER/Dockerfile"


# Verificar que la carpeta exista
if [ ! -d "$FOLDER" ]; then
  echo "La carpeta '$FOLDER' no existe."
  exit 1
fi

# Verificar que el Dockerfile exista
if [ ! -f "$DOCKERFILE_PATH" ]; then
  echo "El Dockerfile en '$DOCKERFILE_PATH' no existe."
  exit 1
fi

# Construir la imagen Docker
echo "Construyendo la imagen para la carpeta '$FOLDER'..."
docker build -f "$DOCKERFILE_PATH" -t "$REGISTRY/$FOLDER:$TAG" .

# Si la construcción fue exitosa, hacer el push
if [ $? -eq 0 ]; then
  echo "Construcción exitosa. Subiendo la imagen..."
  docker buildx build --platform $PLATFORM -f "$DOCKERFILE_PATH" -t "$REGISTRY/$FOLDER:$TAG" --push .
else
  echo "Error en la construcción de la imagen."
  exit 1
fi

echo "Proceso completado para la carpeta '$FOLDER'."
