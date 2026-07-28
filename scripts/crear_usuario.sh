#!/bin/bash
# Comprobar que se recibieron nombre y departamento
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 nombre departamento"
    exit 1
fi
USUARIO="$1"
DEPARTAMENTO="$2"
# Comprobar que el grupo existe
if ! getent group "$DEPARTAMENTO" > /dev/null; then
    echo "Error: el departamento $DEPARTAMENTO no existe."
    exit 1
fi
# Comprobar que el usuario no exista
if id "$USUARIO" &> /dev/null; then
    echo "Error: el usuario $USUARIO ya existe."
    exit 1
fi
# Crear usuario y asignarlo al departamento
useradd -m -s /bin/bash -g "$DEPARTAMENTO" "$USUARIO"
if [ $? -eq 0 ]; then
    echo "Usuario $USUARIO creado correctamente."
    echo "Departamento: $DEPARTAMENTO"
else
    echo "Error al crear el usuario."
    exit 1
fi
