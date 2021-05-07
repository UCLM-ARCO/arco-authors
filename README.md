## arco-authors

![Docker image](https://github.com/UCLM-ARCO/arco-authors/workflows/Docker%20image/badge.svg)

Las clases y estilos LaTeX de arco-authors están empaquetadas como paquete
debian/ubuntu. Para descargar el paquete, añade el repo https://uclm-arco.github.io/debian/.

E instala con:

    # apt-get install arco-authors

El makefile `latex.mk` y scripts asociados proporcionan ventajas para compilar
documentos LaTeX:

* Automáticamente convierte las figuras al formato que pongas en tus \includegraphics
* Recompila el documento si cambia alguna de las partes (ficheros incluidos con `\input`).

### Usarlo como docker

Primero debes hacer login para poder descargar la imagen docker:

    $ cat ~/.github-token-packages | docker login docker.pkg.github.com -u <username> --password-stdin  
   
Para obtener el token mira https://docs.github.com/es/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages   


Y para compilar, cambia al directorio dónde tienes el documento y ejecuta:

    $ docker run -v$PWD:/host -w /host docker.pkg.github.com/uclm-arco/arco-authors/arco-authors:latest make


