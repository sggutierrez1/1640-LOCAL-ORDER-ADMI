#!/bin/bash

# Directorio de salida para los archivos objeto (.o)
OBJDIR=obj
mkdir -p $OBJDIR

# Directorio de salida para el ejecutable final
BINDIR=bin
mkdir -p $BINDIR

# Buscar todos los archivos .cpp en el directorio actual y subdirectorios
SOURCES=$(find . -name '*.cpp')

# Compilar cada archivo fuente en un archivo objeto
for src in $SOURCES; do
    objfile="$OBJDIR/$(basename $src .cpp).o"
    g++ -c $src -o $objfile
done

# Enlazar los archivos objeto en un ejecutable
g++ $OBJDIR/*.o -o $BINDIR/my_program
