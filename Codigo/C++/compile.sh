#!/bin/bash

# Directorio de salida para los archivos objeto (.o)
OBJDIR=obj
mkdir -p $OBJDIR

# Directorio de salida para el ejecutable final
BINDIR=bin
mkdir -p $BINDIR

# Buscar todos los archivos .cpp y .c en el directorio actual y subdirectorios
CPPSOURCES=$(find . -name '*.cpp')
CSOURCES=$(find . -name '*.c')

# Verificar si se encontraron archivos fuente
if [ -z "$CPPSOURCES" ] && [ -z "$CSOURCES" ]; then
    echo "No se encontraron archivos fuente .cpp o .c"
    exit 1
fi

# Variable para contar los errores
error_count=0

# Compilar cada archivo fuente en un archivo objeto
for src in $CPPSOURCES $CSOURCES; do
    objfile="$OBJDIR/$(basename $src .cpp).o"
    objfile="${objfile%.c}.o"  # Cambiar extensión de .c a .o para archivos .c
    echo "Compilando $src a $objfile"
    g++ -c $src -o $objfile
    if [ $? -ne 0 ]; then
        echo "Error al compilar $src"
        error_count=$((error_count+1))
    fi
done

# Verificar si hubo errores de compilación
if [ $error_count -ne 0 ]; then
    echo "Compilación completada con $error_count errores"
fi

# Intentar enlazar los archivos objeto en un ejecutable
g++ $OBJDIR/*.o -o $BINDIR/my_program
if [ $? -ne 0 ]; then
    echo "Error al enlazar los archivos objeto"
    exit 0  # No detener el script, continuar con el análisis de SonarQube
fi

echo "Compilación y enlace completados exitosamente"
