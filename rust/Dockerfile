# Usamos Ubuntu como base
FROM ubuntu:latest

# Instalamos dependencias necesarias para Rust y otras herramientas
RUN apt-get update && \
    apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalamos Rust a través de rustup (instalador oficial de Rust)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Añadimos Rust al PATH
ENV PATH=/root/.cargo/bin:$PATH

# Establecemos el directorio de trabajo
WORKDIR /app

# Configuramos el entrypoint para usar cargo
ENTRYPOINT ["cargo"]

# Establecemos un comando predeterminado (opcional)
CMD ["build"]
