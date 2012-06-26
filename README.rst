
arco-authors
============

Las clases y estilos LaTeX de arco-authors están empaquetadas como paquete
debian/ubuntu. Para descargar el paquete, añade el repo ejecutando lo siguiente (como
root)::

  # echo "deb http://babel.esi.uclm.es/arco sid main" > /etc/apt/sources.list.d/babel.list
  # apt-get update
  # apt-get install arco-archive-keyring

E instala con::

  # apt-get install arco-authors

El makefile latex.mk y scripts asociados proporcionan grandes ventajas para compilar
documentos LaTeX:

* Automáticamente convierte las figuras al formato que pongas en tus \includegraphics
* Recompila el documento si cambia alguna de las partes (ficheros incluidos con \input).
