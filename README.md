# ChambaApp Frontend

**ChambaApp** es una aplicación móvil desarrollada con **SwiftUI** que conecta usuarios con prestadores de servicios como plomeros, niñeras, jardineros, entre otros. Forma parte del ecosistema completo de **ChambaApp**, el cual incluye también un backend en Swift (Vapor) y una base de datos MongoDB.

## 📲 Funcionalidades

- Registro e inicio de sesión
- Vista de servicios y subservicios disponibles
- Consulta de prestadores por subservicio
- Detalle del prestador con experiencia, calificación y reseñas
- Edición de datos del usuario y recuperación de contraseña
- Persistencia de sesión con `@AppStorage`

---

## 🗂 Estructura del proyecto

```
ChambaApp-Front/
├── Assets.xcassets/                # Paleta de colores y recursos visuales
├── Config/
│   └── Constants.swift            # URL base y configuraciones globales
├── Models/                        # Modelos de datos (Prestador, Usuario, etc.)
├── Networking/                    # Servicios para llamadas a la API REST
├── ViewModels/                    # Componentes visuales reutilizables y modificadores
├── Views/                         # Vistas organizadas por módulo
│   ├── Login/
│   ├── Register/
│   ├── Servicios/
│   ├── Subservicios/
│   ├── Prestadores/
│   └── Configuration/
├── ChambaApp_FrontApp.swift       # Entry point principal
├── ContentView.swift              # Componente raíz de navegación
├── ImagePicker.swift              # Utilidad para subir imagen
├── Info.plist                     # Configuración del proyecto
└── estructura.txt                 # Archivo auxiliar
```

---

## ⚙️ Requisitos

- macOS Ventura o superior
- Xcode 15+
- Swift 5.9+
- Backend de ChambaApp corriendo local o en nube

---

## 🚀 Cómo correr el proyecto

1. Clona el repositorio:

   ```bash
   git clone https://github.com/angx7/chambaApp-Front.git
   ```

2. Abre el proyecto en Xcode:

   ```bash
   open ChambaApp-Front/ChambaApp-Front.xcodeproj
   ```

3. Configura el archivo `Config/Constants.swift` con tu URL base del backend:

   ```swift
   struct Constants {
       static let baseURL = "http://localhost:8080" // o tu URL de producción
   }
   ```

4. Ejecuta el proyecto en simulador o dispositivo físico.

---

## 🔒 Seguridad

- Las contraseñas no se guardan en texto plano
- Se valida que los campos estén completos antes de enviar peticiones
- Se incluyen alertas para confirmación de acciones sensibles como eliminación de cuenta

---

## 🌐 Backend relacionado

Este proyecto se conecta a una API REST desarrollada con [Vapor](https://github.com/vapor/vapor) y utiliza MongoDB como base de datos.

---

## 🧪 Estado actual

✅ Módulo de login  
✅ Registro de usuarios  
✅ Visualización y filtrado de servicios  
✅ Edición de cuenta  
✅ Recuperación de contraseña  
❌ No incluye test unitarios (por ahora)

---

## 👤 Autores

Desarrollado por [@angx7](https://github.com/angx7), [@Kuripipeer](https://github.com/kuripipeer), [@bardodepacotilla2912](https://github.com/bardodepacotilla2912), [@GreciaNM](https://github.com/GreciaNM), [@Xitony0407](https://github.com/Xitony0407)

---

## 📄 Licencia

Este proyecto está licenciado bajo los términos de la licencia MIT.
