# Docker ARM64 Linux Desktop via Browser

This project provides a lightweight Linux environment, based on Ubuntu ARM64, accessible via browser using noVNC. It uses XFCE as the desktop environment and `supervisord` to manage services. This project is particularly useful for having a virtualized Linux desktop accessible from any device without needing to install a VNC client.

## Project Structure
The project contains two main files:

- **Dockerfile**: Defines how to build the Docker image, install the necessary packages, and configure the XFCE desktop environment and noVNC.
- **supervisord.conf**: Used to manage the startup and control of various processes, including `Xvfb`, `x11vnc`, `noVNC`, and `startxfce4`.

## File Contents

### Dockerfile
The Dockerfile is the basis for creating the Docker image. It:

1. **Base Image**: Uses `arm64v8/ubuntu:20.04` as the base image.
2. **Base Packages**: Installs `xfce4`, `x11vnc`, `xvfb`, `supervisor`, `noVNC`, and various necessary tools.
3. **Localization Configuration**: Configures localization in Italian (`language-pack-it`) to make the user interface in Italian.
4. **Secure User**: Creates a non-root user for security purposes.
5. **Supervisord**: Copies the `supervisord` configuration file to manage the startup of the main processes (XFCE, VNC, noVNC).
6. **Port Exposure**: Exposes port `8081` to allow access to noVNC via the browser.

### supervisord.conf
The `supervisord.conf` file is used to manage the startup of the necessary services within the container:

1. **Xvfb**: Starts a virtual framebuffer on display `:99`. This creates the virtual graphical environment required for the XFCE desktop.
2. **x11vnc**: Connects to display `:99` to provide VNC access.
3. **XFCE**: Starts the lightweight XFCE desktop environment, making an accessible graphical interface available.
4. **noVNC**: Configures noVNC to provide access to the VNC server through a web interface on port `8081`.

## How to Use the Project

### Prerequisites
- **Docker**: Ensure you have Docker installed and configured to support the ARM64 architecture.

### Build the Image
To build the Docker image, use the following command in the project directory, which contains the Dockerfile and `supervisord.conf`:

```sh
docker build -t linux-novnc-arm64 .
```

### Run the Container
To run the container, use the following command. This will make the Linux desktop accessible via the browser on port `8081`.

```sh
docker run -d -p 8081:8081 --name linux-container linux-novnc-arm64
```

### Access the Linux Desktop
Open your browser and go to:

```
http://localhost:8081
```

Here you will find an XFCE desktop, accessible via noVNC. The interface will be in Italian thanks to the configuration made in the Dockerfile.

### Credentials
The default credentials for the user created in the container are:

- **Username**: `linuxuser`
- **Password**: `password`

For better security, it is recommended to change the password once logged in.

## Troubleshooting
- **Black Screen**: If you see a black screen when connecting via noVNC, make sure all services (particularly `xvfb` and `startxfce4`) are running. This can be verified by viewing the supervisord logs:
  ```sh
  docker logs linux-container
  ```

- **Incorrect Language Configuration**: If the language does not appear in Italian, ensure that the localization packages have been properly installed and that the environment variables are set as indicated in the Dockerfile.

## Contributions
Feel free to contribute to this project through pull requests or by opening an issue if you encounter problems or have suggestions for improvements.

## License
This project is distributed under the MIT license. Feel free to use and modify it.

---
Thank you for exploring this project! If you have any questions or suggestions, do not hesitate to contact me.

