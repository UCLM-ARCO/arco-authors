## arco-authors

[![docker image](https://github.com/UCLM-ARCO/arco-authors/actions/workflows/dockerimage.yml/badge.svg)](https://github.com/UCLM-ARCO/arco-authors/actions/workflows/dockerimage.yml)

Las clases y estilos LaTeX de arco-authors están disponibles como paquete
debian/ubuntu. Para descargar el paquete, añade el repo https://uclm-arco.github.io/debian/.

E instala con:

    # apt install arco-authors

El makefile `latex.mk` y scripts asociados proporcionan ventajas para compilar
documentos LaTeX:

* Automáticamente convierte las figuras al formato que pongas en tus \includegraphics
* Recompila el documento si cambia alguna de las partes (ficheros incluidos con `\input`).

### Uso con docker

Primero debes hacer login para poder descargar la imagen docker:

    $ cat ~/.github-token-packages | docker login docker.pkg.github.com -u <username> --password-stdin

Para obtener el token mira https://docs.github.com/es/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages


Y para compilar, cambia al directorio dónde tienes el documento y ejecuta:

    $ docker run -v$PWD:/host -w /host ghcr.io/uclm-arco/arco-authors/arco-authors:latest make
