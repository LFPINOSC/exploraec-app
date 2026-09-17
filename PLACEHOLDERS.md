# Placeholders de esta rama (sesion-06)

Punto de partida: ExploraEC con Overpass API resuelta en Inicio (Sesión 5), pero el Mapa todavía mostrando `lugaresEjemplo` por separado — dos fuentes de datos desincronizadas. El objetivo de esta sesión es centralizar todo en un `PlacesController` de GetX que ambas pantallas comparten, y refactorizar la navegación a `Get.to`.

## Archivos nuevos ya completos (sin `TODO`)
- `lib/controllers/places_controller.dart` — estado compartido (`RxList<Place> lugares`, `Rx<EstadoCarga> estado`, `Rx<Position?> posicion`), salvo el cuerpo de `cargarLugares()` (ver tabla de abajo).
- `lib/bindings/places_binding.dart` — registra `PlacesController` con `Get.put` al arrancar la app.
- `lib/main.dart` — ya usa `GetMaterialApp` con `initialBinding: PlacesBinding()`.
- `lib/widgets/place_card.dart` — ya navega con `Get.to(() => DetailScreen(place: place))` en vez de `Navigator.push`.
- `lib/screens/add_place_screen.dart` — ya guarda el lugar nuevo vía `Get.find<PlacesController>().agregarLugar(...)` y cierra con `Get.back()`.
- `pubspec.yaml` — ya incluye `get`.

## Qué descomentar

| Archivo | Qué descomentar | Paso de la práctica |
|---|---|---|
| `lib/controllers/places_controller.dart` | En `cargarLugares()`: borrar `lugares.value = []; estado.value = EstadoCarga.exito;` y descomentar el bloque `try { ... } catch (e) { ... }` completo (posición real → Overpass → estados) | Paso 3 |
| `lib/screens/home_screen.dart` | Borrar `body: const Center(child: Text('Pendiente de conectar con Obx'))` y descomentar el `body: Obx(() { ... })` completo | Paso 4 |
| `lib/screens/map_screen.dart` | Borrar `body: const Center(child: Text('Pendiente de conectar con Obx'))` y descomentar el `body: Obx(() { ... })` completo | Paso 4 |

Con la rama recién clonada (antes de descomentar nada), tanto Inicio como el Mapa muestran el texto "Pendiente de conectar con Obx" — es el comportamiento esperado hasta completar los Pasos 3 y 4. El orden importa: el controller (Paso 3) debe quedar resuelto antes de que las pantallas (Paso 4) tengan algo real que mostrar.

## Comando de arranque

```bash
flutter pub get
flutter run
```
