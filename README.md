# Práctica Jenkins Pipeline con React

## Introducción Teórica

### ¿Qué es Jenkins?
Jenkins es una herramienta de automatización de código abierto escrita en Java que permite la integración continua (CI) y la entrega continua (CD) de proyectos de software. Permite automatizar las partes del desarrollo de software relacionadas con la construcción, prueba y despliegue, facilitando la integración continua y la entrega continua.

Características principales:
- Fácil instalación y configuración
- Extensible a través de plugins
- Distribuido: puede manejar múltiples máquinas para pruebas
- Basado en web con interfaz gráfica
- Sistema de notificaciones integrado
- Soporta pipelines como código (Jenkinsfile)

### ¿Qué es una Pipeline?
Una pipeline en Jenkins es una suite de plugins que permite implementar y integrar pipelines de entrega continua. Define el proceso completo de CI/CD como código y puede incluir múltiples etapas (stages) para construir, probar y desplegar aplicaciones.

## Configuración del Proyecto

### Prerrequisitos
- Node.js y npm instalados
- Jenkins instalado y configurado
- Cuenta en Vercel
- Bot de Telegram
- Git instalado

### Estructura del Proyecto
```
proyecto-react/
├── src/
├── jenkinsScripts/
│   ├── deployToVercel.sh
│   ├── pushChanges.sh
│   └── updateReadme.sh
├── Jenkinsfile
└── README.md
```

### Pasos de Configuración

1. **Crear Nueva Rama**
   ```bash
   git checkout -b ci_jenkins
   ```

2. **Instalar Plugin Build Monitor View**
   - Acceder a Jenkins
   - Ir a "Administrar Jenkins" > "Administrar Plugins"
   - En la pestaña "Disponibles", buscar "Build Monitor View"
   - Instalar y reiniciar Jenkins

3. **Configurar Credenciales en Jenkins**
   - Ir a "Administrar Jenkins" > "Manage Credentials"
   - Agregar las siguientes credenciales:
     * VERCEL_ANALYTICS_ID
     * GMAIL_USER
     * GMAIL_PASS
     * METRICS_TOKEN
     * VERCEL_TOKEN
     * ORG_ID
     * PROJECT_ID
     * PAT_TOKEN
     * TELEGRAM_TOKEN
     * TELEGRAM_CHAT_ID

4. **Configurar Build Monitor View**
   - En el Dashboard de Jenkins, click en el "+"
   - Seleccionar "Build Monitor View"
   - Nombrar la vista
   - Seleccionar los jobs a monitorear

5. **Configurar ESLint**
   ```bash
   npm install eslint --save-dev
   npx eslint --init
   ```

6. **Configurar Tests con Jest**
   ```bash
   npm install jest @testing-library/react @testing-library/jest-dom --save-dev
   ```

### Configuración de la Pipeline

1. **Crear Pipeline en Jenkins**
   - Click en "Nueva Tarea"
   - Seleccionar "Pipeline"
   - Configurar:
     * GitHub project URL
     * Build Triggers
     * Pipeline script from SCM
     * SCM: Git
     * Repository URL
     * Credentials
     * Branch: */ci_jenkins
     * Script Path: Jenkinsfile

2. **Stages de la Pipeline**

   La pipeline incluye las siguientes etapas:
   
   a. **Petición de datos**
   - Solicita información del ejecutor
   - Motivo de la ejecución
   - Chat ID de Telegram

   b. **Linter**
   - Ejecuta ESLint sobre el código
   - Verifica estándares de código
   
   c. **Test**
   - Ejecuta tests con Jest
   - Verifica funcionalidad
   
   d. **Build**
   - Construye la versión de producción
   
   e. **Update_Readme**
   - Actualiza README con badge de estado
   
   f. **Push_Changes**
   - Sube cambios a GitHub
   
   g. **Deploy to Vercel**
   - Despliega en Vercel
   
   h. **Notificació**
   - Envía notificación por Telegram

### Verificación y Ejecución

1. **Ejecutar Pipeline**
   - Ir al proyecto en Jenkins
   - Click en "Construir con parámetros"
   - Ingresar:
     * Nombre del ejecutor
     * Motivo de ejecución
     * Chat ID de Telegram

2. **Verificar Resultados**
   - Revisar el Build Monitor View
   - Verificar los logs de cada stage
   - Comprobar el despliegue en Vercel
   - Verificar la notificación en Telegram

### Solución de Problemas

Si encuentras errores:
1. Verificar credenciales en Jenkins
2. Comprobar permisos de ejecución de scripts
3. Revisar logs de Jenkins
4. Verificar conexión con GitHub y Vercel

## RESULTADO DE LOS ÚLTIMOS TESTS

![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)

## Enlaces Útiles
- [Documentación Jenkins](https://www.jenkins.io/doc/)
- [Documentación Vercel](https://vercel.com/docs)
- [ESLint Documentation](https://eslint.org/)
- [Jest Documentation](https://jestjs.io/)
