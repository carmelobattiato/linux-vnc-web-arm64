# Docker ARM64 Linux Desktop via Browser

Questo progetto fornisce un ambiente Linux leggero, basato su Ubuntu ARM64, accessibile via browser tramite noVNC. Utilizza XFCE come ambiente desktop e `supervisord` per gestire i servizi. Questo progetto è particolarmente utile per avere un desktop Linux virtualizzato, accessibile da qualsiasi dispositivo, senza dover installare client VNC.

## Struttura del Progetto
Il progetto contiene due file principali:

- **Dockerfile**: Definisce come costruire l'immagine Docker, installare i pacchetti necessari, configurare l'ambiente desktop XFCE e noVNC.
- **supervisord.conf**: Utilizzato per gestire l'avvio e il controllo di diversi processi, inclusi `Xvfb`, `x11vnc`, `noVNC` e `startxfce4`.

## Contenuto dei File

### Dockerfile
Il Dockerfile è la base per la creazione dell'immagine Docker. Esso:

1. **Base Image**: Utilizza `arm64v8/ubuntu:20.04` come immagine base.
2. **Pacchetti di Base**: Installa `xfce4`, `x11vnc`, `xvfb`, `supervisor`, `noVNC`, e vari strumenti necessari.
3. **Configurazione Localizzazione**: Configura la localizzazione in italiano (`language-pack-it`), così da rendere l'interfaccia utente in italiano.
4. **Utente Sicuro**: Crea un utente non root per motivi di sicurezza.
5. **Supervisord**: Copia il file di configurazione di `supervisord` per gestire il lancio dei processi principali (XFCE, VNC, noVNC).
6. **Esposizione delle Porte**: La porta `8081` è esposta per consentire l'accesso a noVNC tramite il browser.

### supervisord.conf
Il file `supervisord.conf` è utilizzato per gestire l'avvio dei servizi necessari all'interno del container:

1. **Xvfb**: Avvia un framebuffer virtuale sul display `:99`. Questo crea un ambiente grafico virtuale necessario per il desktop XFCE.
2. **x11vnc**: Si collega al display `:99` per fornire accesso VNC.
3. **XFCE**: Avvia l'ambiente desktop leggero XFCE, rendendo disponibile un'interfaccia grafica accessibile.
4. **noVNC**: Configura noVNC per fornire l'accesso al server VNC attraverso un'interfaccia web sulla porta `8081`.

## Come Utilizzare il Progetto

### Prerequisiti
- **Docker**: Assicurati di avere Docker installato e configurato per supportare l'architettura ARM64.

### Costruire l'Immagine
Per costruire l'immagine Docker, utilizza il seguente comando nella directory del progetto, che contiene il Dockerfile e `supervisord.conf`:

```sh
docker build -t linux-novnc-arm64 .
```

### Eseguire il Container
Per eseguire il container, utilizza il comando seguente. Questo renderà il desktop Linux accessibile tramite il browser sulla porta `8081`.

```sh
docker run -d -p 8081:8081 --name linux-container linux-novnc-arm64
```

### Accesso al Desktop Linux
Apri il browser e vai all'indirizzo:

```
http://localhost:8081
```

Qui troverai un desktop XFCE, accessibile via noVNC. L'interfaccia sarà in italiano grazie alla configurazione effettuata nel Dockerfile.

### Credenziali
Le credenziali predefinite per l'utente creato nel container sono:

- **Username**: `linuxuser`
- **Password**: `password`

Per maggiore sicurezza, ti consiglio di cambiare la password una volta effettuato l'accesso.

## Risoluzione dei Problemi
- **Schermo Nero**: Se vedi uno schermo nero quando ti colleghi tramite noVNC, assicurati che tutti i servizi (in particolare `xvfb` e `startxfce4`) siano attivi. Questo può essere verificato visualizzando i log di supervisord:
  ```sh
  docker logs linux-container
  ```

- **Lingua non Correttamente Configurata**: Se la lingua non appare in italiano, assicurati che i pacchetti di localizzazione siano stati correttamente installati e che le variabili d'ambiente siano impostate come indicato nel Dockerfile.

## Contributi
Sentiti libero di contribuire a questo progetto attraverso pull request o aprendo un issue se riscontri problemi o hai suggerimenti per miglioramenti.

## Licenza
Questo progetto è distribuito sotto la licenza MIT. Sentiti libero di utilizzarlo e modificarlo.

---
Grazie per aver esplorato questo progetto! Se hai domande o suggerimenti, non esitare a contattarmi.

