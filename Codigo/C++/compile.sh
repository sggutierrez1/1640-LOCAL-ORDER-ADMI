#!/bin/bash

# Directorio de salida para los archivos objeto (.o)
OBJDIR=obj
mkdir -p $OBJDIR

# Directorio de salida para el ejecutable final
BINDIR=bin
mkdir -p $BINDIR

# Buscar todos los archivos .cpp, .c y .h en el directorio actual y subdirectorios
CPPSOURCES=$(find . -name '*.cpp')
CSOURCES=$(find . -name '*.c')
HEADERS=$(find . -name '*.h')

# Verificar si se encontraron archivos fuente
if [ -z "$CPPSOURCES" ] && [ -z "$CSOURCES" ] && [ -z "$HEADERS" ]; then
    echo "No se encontraron archivos fuente .cpp, .c o .h"
    exit 1
fi

# Variable para contar los errores
error_count=0

# Compilar archivos .cpp y .c a archivos objeto (.o)
for src in $CPPSOURCES $CSOURCES; do
    objfile="$OBJDIR/$(basename $src .cpp).o"
    objfile="${objfile%.c}.o"  # Cambiar extensión de .c a .o para archivos .c
    echo "Compilando $src a $objfile"
    if [[ $src == *.cpp ]]; then
        g++ -c $src -o $objfile
    elif [[ $src == *.c ]]; then
        gcc -c $src -o $objfile
    fi
    if [ $? -ne 0 ]; then
        echo "Error al compilar $src"
        error_count=$((error_count+1))
    fi
done

# Compilar archivos de cabecera (.h) - no se genera archivo objeto, pero se verifican dependencias
# Esto asegura que los cambios en los .h se tengan en cuenta al recompilar los .cpp/.c
for header in $HEADERS; do
    echo "Compilando dependencias de $header"
    if [[ $header == *.h ]]; then
        if [[ $header == *.hpp ]]; then
            g++ -MM -MT "${OBJDIR}/$(basename ${header} .hpp).o" $header >> ${OBJDIR}/dependencies.mk
        fi
    fi
done

# Verificar si hubo errores de compilación
if [ $error_count -ne 0 ]; then
    echo "Compilación completada con $error_count errores"
fi

# Intentar enlazar los archivos objeto en un ejecutable
echo "Enlazando archivos objeto en $BINDIR/my_program"
g++ $OBJDIR/*.o -o $BINDIR/my_program
if [ $? -ne 0 ]; then
    echo "Error al enlazar los archivos objeto"
    exit 0
fi

echo "Compilación y enlace completados exitosamente"
