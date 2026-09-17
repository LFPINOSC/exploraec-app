# Placeholders de esta rama (sesion-05)

Punto de partida: ExploraEC con mapa real, permisos y posición del usuario ya resueltos (Sesión 4). El objetivo de esta sesión es reemplazar la carga de Inicio, que hasta ahora dependía de una lista fija en memoria, por lugares reales obtenidos de la Overpass API de OpenStreetMap (sin API key), usando la posición real del usuario.

## Archivos nuevos ya completos (sin `TODO`)
- `lib/services/places_api_service.dart` — construcción de la consulta Overpass QL, llamada HTTP, manejo de errores (`SocketException`, timeout, `429`, JSON inválido) y mapeo de la respuesta a `Place`.
- `lib/models/place.dart` — nuevo `Place.fromOverpassElement(...)`; ya no incluye `fetchLugaresSimulado` (reemplazada por el servicio real de esta sesión).
- `pubspec.yaml` — ya incluye `http`.

## Qué descomentar

| Archivo | Qué descomentar | Paso de la práctica |
|---|---|---|
| `lib/screens/home_screen.dart` | En `_cargar()`: borrar `_futuroLugares = Future.value(<Place>[]);` y descomentar `_futuroLugares = _cargarLugaresReales();`. Descomentar también el método completo `_cargarLugaresReales()` (posición real → Overpass → se agregan los lugares creados a mano en `AddPlaceScreen`) | Paso 3 |

## Nota sobre el Mapa

La pestaña Mapa **todavía** muestra los lugares de ejemplo de la Sesión 2 como marcadores (`lugaresEjemplo`), no los lugares reales que Inicio ya consume desde hoy — es intencional, no un error pendiente de esta sesión. Unificar ambas pantallas bajo una sola fuente de datos es exactamente el problema que la Sesión 6 resuelve con un `PlacesController` de GetX compartido.

## Comando de arranque

```bash
flutter pub get
flutter run
```

Con la rama recién clonada (antes de descomentar nada), Inicio carga una lista vacía de inmediato (`EmptyView`) — es el comportamiento esperado hasta completar el Paso 3. La Overpass API es pública y no requiere registro ni API key; sí aplica un límite de uso razonable (fair-use) — evitar refrescar la pantalla repetidamente en poco tiempo durante la práctica.
