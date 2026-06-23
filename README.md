# moviedb 🎬

Una aplicación Flutter para explorar películas usando la API de The Movie Database (TMDb).

## 📋 Descripción

Comics es una aplicación de películas construida con Flutter que permite a los usuarios:
- 🔍 Buscar películas por título
- ⭐ Ver películas populares y trending
- 📖 Consultar detalles completos de películas
- ❤️ Marcar películas como favoritas
- 🎨 Disfrutar de una interfaz moderna y responsiva

## 🏗️ Arquitectura

El proyecto sigue una arquitectura limpia con tres capas:

### **Domain Layer**
- `entities/`: Entidades de negocio principales
- `repositories/`: Interfaces de repositorios
- `datasources/`: Interfaces de fuentes de datos

### **Infrastructure Layer**
- `datasources/`: Implementación de fuentes de datos (API de TMDb)
- `models/`: Modelos de datos para la API
- `mappers/`: Conversión entre modelos y entidades
- `repositories/`: Implementación de repositorios

### **Presentation Layer**
- `providers/`: Gestión de estado con Riverpod
- `screens/`: Pantallas principales
- `views/`: Vistas componibles
- `widgets/`: Componentes reutilizables

## 🛠️ Tecnologías

- **Framework**: Flutter
- **Lenguaje**: Dart
- **Gestión de Estado**: Riverpod
- **API**: The Movie Database (TMDb) v3
- **HTTP**: Dio
- **Persistencia**: SQLite (sqflite)
- **Enrutamiento**: Go Router

## 📱 Características

### Buscar Películas
- Búsqueda en tiempo real de películas
- Interfaz intuitiva con sugerencias

### Explorar Películas
- Vista de películas populares
- Películas en tendencia
- Carrusel de imágenes destacadas

### Detalles de Película
- Sinopsis completa
- Puntuación de usuarios
- Fecha de lanzamiento
- Elenco y tripulación

### Favoritos
- Guardar películas favoritas
- Acceso rápido a favoritos guardados

## 🚀 Instalación

### Requisitos Previos
- Flutter 3.x o superior
- Dart 3.x o superior
- Clave de API de TMDb (obtener en [themoviedb.org](https://www.themoviedb.org/settings/api))

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/LuisJesus24/Comics.git
   cd Comics
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar API Key**
   - Crear archivo `.env` en la raíz del proyecto
   - Agregar: `TMDB_API_KEY=tu_clave_aqui`

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📦 Dependencias Principales

- `riverpod`: Gestión de estado
- `go_router`: Enrutamiento
- `dio`: Cliente HTTP
- `sqflite`: Base de datos local
- `cached_network_image`: Caché de imágenes

## 🔗 Estructura de Carpetas

```
lib/
├── config/              # Configuración de la app
│   ├── constants/       # Constantes
│   ├── database/        # Configuración de BD
│   ├── router/          # Rutas de navegación
│   └── theme/           # Temas y estilos
├── domain/              # Lógica de negocio
│   ├── datasources/     # Interfaces
│   ├── entities/        # Entidades
│   └── repositories/    # Interfaces repositorio
├── infrastructure/      # Implementación
│   ├── datasources/     # Fuentes de datos
│   ├── mappers/         # Conversión de datos
│   ├── models/          # Modelos de datos
│   └── repositories/    # Implementación repositorio
└── presentation/        # Interfaz de usuario
    ├── providers/       # Riverpod providers
    ├── screens/         # Pantallas principales
    ├── views/           # Vistas reutilizables
    └── widgets/         # Componentes UI
```

## 👨‍💻 Desarrollo

### Comandos Útiles

```bash
# Generar código (si es necesario)
flutter pub run build_runner build

# Ejecutar tests
flutter test

# Compilar para release
flutter build apk    # Android
flutter build ios    # iOS
```

### Rama de Desarrollo
Actualmente en desarrollo de nuevas características en la rama `feature/tmdb-bottomNav`.

## 📝 Recientes Cambios

### v0.2.0 - Bottom Navigation y Búsqueda
- ✅ Agregada vista de búsqueda (search_view.dart)
- ✅ Mejorada navegación con bottom navigation bar
- ✅ Mejoras en UI de carrusel y tarjetas
- ✅ Actualización de datasources y mappers
- ✅ Optimización de repositorios

## 📄 Licencia

Este proyecto está disponible bajo licencia MIT.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Haz un fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Contacto

Luis Jesús - [@LuisJesus24](https://github.com/LuisJesus24)

Proyecto: [moviedb - GitHub](https://github.com/LuisJesus24/Comics)
