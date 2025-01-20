#!/bin/bash
if [ -z "$VERCEL_TOKEN" ]; then
    echo "Error: VERCEL_TOKEN no configurado."
    exit 1
fi

# Ejecutar el despliegue con Vercel
vercel --prod --token "$VERCEL_TOKEN" || exit 1
echo "Despliegue completado correctamente."
