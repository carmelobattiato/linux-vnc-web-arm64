# Usa una base ARM64
FROM arm64v8/ubuntu:20.04

# Impostare il frontend su non interattivo per evitare richieste durante l'installazione
ENV DEBIAN_FRONTEND=noninteractive

# Aggiorna e installa pacchetti di base
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    x11vnc \
    xvfb \
    supervisor \
    wget \
    curl \
    net-tools \
    python3 \
    sudo \
    dbus-x11 \
    && apt-get clean

# Installazione di noVNC
RUN mkdir -p /opt/novnc/utils/websockify \
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz | tar xz --strip 1 -C /opt/novnc \
    && wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.10.0.tar.gz | tar xz --strip 1 -C /opt/novnc/utils/websockify

# Creare l'utente non root per la sicurezza
RUN useradd -m -s /bin/bash linuxuser && echo 'linuxuser:password' | chpasswd && adduser linuxuser sudo

# Configurazione di supervisord per l'avvio di xvfb, x11vnc, noVNC e xfce4
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Esponi la porta noVNC su 8081
EXPOSE 8081

# Comando di avvio
CMD ["/usr/bin/supervisord"]
