# exploraec-app

Repo de arranque de *ExploraEC* para el curso *MOD3: Desarrolla Aplicaciones Móviles Robustas con Flutter e IA*.

## Cómo se usa este repo

Cada rama `sesion-NN` es el punto de partida de la práctica de esa sesión: contiene el código ya construido en la práctica de la sesión **anterior**, más el código provisional (que ya compila y corre) de la sesión actual, con el bloque real comentado justo debajo, precedido por:

```dart
// TODO(sesion-NN): borra la línea de abajo y descomenta el bloque completo.
```

El flujo esperado en cada sesión (a partir de la Sesión 2):

1. Hacer checkout de la rama de tu sesión actual: `git checkout sesion-NN`.
2. Ubicar los bloques `TODO(sesion-NN)` documentados en `PLACEHOLDERS.md` de esa rama (o buscarlos con tu editor).
3. Borrar el bloque provisional activo y descomentar el bloque real, siguiendo la práctica de clase o el instructivo correspondiente.
4. Ejecutar y verificar.

**Importante:** este repo no incluye el esqueleto completo que genera `flutter create` (carpetas `android/`, `ios/`, `web/`, etc.) — esas las genera el propio Flutter SDK, una sola vez, en la Sesión 1. Este repo es una **capa superpuesta** con los archivos específicos de ExploraEC (principalmente dentro de `lib/`). El flujo completo:

```bash
flutter create exploraec        # Sesión 1, una sola vez
cd exploraec
# copia dentro de esta carpeta los archivos de la rama de tu sesión actual,
# reemplazando los que correspondan (lib/, pubspec.yaml)
flutter pub get
flutter run
```

Tu proyecto real se llama `exploraec` — este repo de arranque, si lo clonas, debe vivir en una carpeta separada (`exploraec-app-starter`), nunca dentro de tu propio proyecto ni reemplazándolo por completo.

## Ramas disponibles

| Rama | Punto de partida para | Qué agrega/completa esa sesión |
|---|---|---|
| `sesion-02` | Sesión 2 — Widgets básicos y avanzados | Modelo `Place`, lista de lugares en memoria (`ListView`/`GridView`, `PlaceCard`), pantalla de detalle, formulario "Agregar lugar", navegación inferior |
| `sesion-03` | Sesión 3 — Interfaces y UX | Tema Material, estados de carga/vacío/error reutilizables, layout responsivo |
| `sesion-04` | Sesión 4 — Mapas y geolocalización | Permisos de ubicación, posición actual, pantalla de Mapa con `flutter_map` |
| `sesion-05` | Sesión 5 — Programación asíncrona | Lugares reales desde la Overpass API, estados loading/success/error |
| `sesion-06` | Sesión 6 — Gestión de estado con GetX | `PlacesController`, `Obx`, navegación e inyección de dependencias con GetX |
| `sesion-07` | Sesión 7 — Almacenamiento de datos | Favoritos persistentes con Hive, `PlaceRepository` |
| `sesion-08` | Sesión 8 — Integración con Firebase | Authentication, Firestore (reseñas), reglas de seguridad |
| `sesion-09` | Sesión 9 — IA y modelos LLM en Flutter | Pantalla "Asistente ExploraIA", consumo del backend de IA |
| `sesion-10` | Sesión 10 — Proyecto final | Punto de partida para pulido final — sin `TODO` pendientes, base para la entrega |

No existe una rama `sesion-01`: en esa sesión el proyecto se crea desde cero con `flutter create` (ver `sesiones/sesion-01/instructivo-practica-sesion-01.md` del curso) — no hay nada previo que clonar.

Cada rama se creó a partir de la anterior (`git checkout -b sesion-03 sesion-02`, etc.), así que `git log --oneline` refleja la progresión real de la práctica del curso.

## Advertencia de verificación

El código de este repo fue escrito y revisado cuidadosamente contra la documentación oficial de cada paquete, pero **no fue compilado ni ejecutado contra un SDK de Flutter real** (el entorno donde se generó este curso no tiene Flutter/Dart instalado). Antes de dictar cada sesión, ejecuta `flutter pub get`, `flutter analyze` y `flutter run` sobre la rama correspondiente y corrige cualquier detalle de API que haya cambiado de versión.
