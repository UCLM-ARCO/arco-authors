## arco-authors

![Docker image](https://github.com/UCLM-ARCO/arco-authors/workflows/Docker%20image/badge.svg)

Las clases y estilos LaTeX de arco-authors están empaquetadas como paquete
debian/ubuntu. Para descargar el paquete, añade el repo https://uclm-arco.github.io/debian/.

E instala con:

    # apt-get install arco-authors

El makefile `latex.mk` y scripts asociados proporcionan grandes ventajas para compilar
documentos LaTeX:

* Automáticamente convierte las figuras al formato que pongas en tus \includegraphics
* Recompila el documento si cambia alguna de las partes (ficheros incluidos con `\input`).
