# VNC Container with XFCE and noVNC

This repository provides a Docker container that runs an ARM64-based Ubuntu system with a lightweight XFCE desktop environment, accessible via a web browser using noVNC. The default resolution is set to 1920x1080, and it is easily configurable.

## Features
- **ARM64 Ubuntu Base**: Uses Ubuntu 20.04 for ARM64 architecture.
- **XFCE Desktop Environment**: A lightweight desktop environment for a responsive experience.
- **noVNC**: Enables browser-based VNC access without additional VNC client software.
- **Customizable Resolution**: Default resolution is set to 1920x1080, but it can be customized by setting an environment variable.
- **Pre-configured Italian Locale**: The system language is set to Italian (it_IT.UTF-8).

## Getting Started
These instructions will help you set up and run the container on your local machine.

### Prerequisites
- Docker installed on your machine.

### Building the Docker Image
Clone this repository and navigate to the directory containing the Dockerfile. Run the following command to build the Docker image:

```sh
docker build -t linux-novnc-arm64 .
```

### Running the Container
To run the container and expose the VNC interface via noVNC on port 8081, use the following command:

```sh
docker run -d -p 8081:8081 --name linux-container -e RESOLUTION=1920x1080 linux-novnc-arm64
```

#### Customizing the Resolution
The default resolution for the desktop is set to `1920x1080`. You can customize this resolution by changing the `RESOLUTION` environment variable while running the container, like so:

```sh
docker run -d -p 8081:8081 --name linux-container -e RESOLUTION=1280x720 linux-novnc-arm64
```

### Accessing the Desktop
Once the container is running, open your browser and navigate to:

```
http://localhost:8081
```

You will see the XFCE desktop environment running inside your container, accessible via noVNC.

## File Descriptions
- **Dockerfile**: The Docker configuration file used to build the image, with all the necessary components including XFCE, noVNC, and other dependencies.
- **supervisord.conf**: Configuration file for Supervisor, which manages the services like Xvfb, x11vnc, noVNC, and XFCE session.

## Environment Variables
- `RESOLUTION`: Set the resolution for the virtual display. Default is `1920x1080`. Example: `-e RESOLUTION=1366x768`.

## Default Credentials
The default user credentials are:
- **Username**: `linuxuser`
- **Password**: `password`

For security purposes, it is recommended to change the password after your first login.

## Contributing
Feel free to submit pull requests, report issues, or provide suggestions for improvement.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

