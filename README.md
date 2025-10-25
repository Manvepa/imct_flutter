# 📱 AppMovil Flutter (Proyecto IMCT)

Este proyecto corresponde al **frontend móvil** del sistema **Scrum IMCT**, desarrollado con **Flutter**.  
Forma parte del ecosistema del proyecto junto con el **backend en Node.js + Docker**.

La aplicación muestra inicialmente una pantalla de carga (logo o imagen animada),  
y luego pasa a la pantalla principal de la app.

---

## 🧠 Descripción general

Esta aplicación móvil está desarrollada en **Flutter**, un framework creado por Google  
que permite construir aplicaciones **Android** e **iOS** desde un mismo código base.

El proyecto actualmente cuenta con:
- Una **pantalla de carga (SplashScreen)** que muestra un logo animado o imagen.
- Una **pantalla principal (HomeScreen)** con el mensaje de bienvenida.
- Estructura inicial lista para seguir desarrollando módulos.
- Código completamente **comentado línea por línea**, para que cualquier persona pueda entender su funcionamiento.

---

## 🧩 Requisitos previos

Antes de ejecutar este proyecto, asegúrate de tener instalado lo siguiente:

| Requisito | Descripción | Descarga / Comando |
|------------|-------------|--------------------|
| **Flutter SDK** | Framework base para ejecutar la app. | [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install) |
| **Android Studio** | Entorno de desarrollo para emular y ejecutar la app. | [https://developer.android.com/studio](https://developer.android.com/studio) |
| **Git** | Control de versiones (para clonar y subir cambios). | [https://git-scm.com/downloads](https://git-scm.com/downloads) |

---

## ⚙️ Instalación (local)

Sigue los siguientes pasos para ejecutar la aplicación en tu equipo:

### 1️⃣ Clonar el repositorio

```bash
git clone https://github.com/TU_ORGANIZACION/imct_flutter.git
```

> 💡 *Reemplaza `TU_ORGANIZACION` por el nombre de tu organización o usuario en GitHub.*

### 2️⃣ Entrar al directorio del proyecto

```bash
cd imct_flutter
```

### 3️⃣ Descargar las dependencias del proyecto

```bash
flutter pub get
```

### 4️⃣ (Opcional) Limpiar caché previa

```bash
flutter clean
flutter pub get
```

### 5️⃣ Ejecutar la aplicación

```bash
flutter run
```

> 🧩 Si tienes más de un dispositivo conectado, Flutter te preguntará cuál usar.  
> Puedes ejecutar `flutter devices` para listar los disponibles.

---

## 📱 Pantallas principales

### 🖼️ Pantalla de carga (SplashScreen)
- Se muestra al abrir la aplicación.
- Muestra un logo o GIF animado (`assets/logo.gif`).
- Después de unos segundos, pasa automáticamente a la pantalla principal.

### 🏠 Pantalla principal (HomeScreen)
- Muestra el texto **"Bienvenido a AppMovil 🎉"**.
- Es la base donde se agregarán los futuros módulos del proyecto (menús, vistas, etc).

---

## 🧰 Estructura del proyecto

```
lib/
├─ main.dart                → Punto de entrada de la app
└─ src/
   └─ screens/
      ├─ splash_screen.dart → Pantalla de carga (inicio)
      └─ home_screen.dart   → Pantalla principal
assets/
└─ logo.gif                 → Imagen o animación del logo
```

---

## 🧱 Flujo de trabajo con Git (igual que el backend)

El proyecto usa dos ramas principales:

| Rama | Descripción |
|------|--------------|
| `main` | Rama principal estable, contiene las versiones listas para producción. |
| `develop` | Rama de desarrollo donde se agregan y prueban nuevas funciones. |

### 🔄 Flujo recomendado:

1. Siempre trabaja en la rama **develop**:
   ```bash
   git checkout develop
   ```
2. Guarda tus avances:
   ```bash
   git add .
   git commit -m "Descripción del cambio realizado"
   git push
   ```
3. Cuando una versión esté lista, fusiona los cambios en **main**:
   ```bash
   git checkout main
   git merge develop
   git push
   ```

---

## 📦 Variables de entorno

Actualmente, la app **no requiere variables de entorno**,  
pero se usa el paquete `flutter_dotenv` preparado para el futuro.

El archivo `.env` podrá almacenar datos como:
```
API_URL=https://api.tuservidor.com
```

Y se cargará en el código con:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
await dotenv.load(fileName: ".env");
```

---

## 🧠 Notas importantes

- La carpeta `/build/` **no se sube a GitHub** (está en `.gitignore`).
- Si cambias el nombre del archivo del logo, recuerda actualizarlo también en:
  - `pubspec.yaml`
  - `splash_screen.dart`
- Puedes usar imágenes `.gif`, `.png` o `.jpg` dentro de la carpeta `/assets/`.

---

## 🧾 Licencia

Este proyecto forma parte del desarrollo de **Scrum IMCT**,  
y su uso está restringido a fines empresariales y de desarrollo interno.

---

## 👨‍💻 Autor

**Manuel Felipe Parra Velandia**  
Desarrollador del proyecto **Scrum IMCT**  
📍 Colombia 🇨🇴  
