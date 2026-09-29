# Placeholders de esta rama (sesion-04)

Punto de partida: ExploraEC con tema, estados loading/vacío/error y layout responsivo ya resueltos (Sesión 3), y todo el estado de Inicio todavía dentro de `HomeScreen`. Tráela con:

```bash
git fetch starter
git checkout starter/sesion-04 -- lib pubspec.yaml PLACEHOLDERS.md
```

El objetivo de esta sesión es centralizar el estado de la lista de lugares en un `PlacesController` de GetX que `HomeScreen` lee con `Obx`, y refactorizar la navegación a `Get.to`. Cada bloque comentado trae, justo debajo del `TODO`, un comentario `// Por qué:` con la explicación.

## Archivos nuevos ya completos (sin `TODO`)
- `lib/controllers/places_controller.dart` — estado compartido (`RxList<Place> lugares`, `Rx<EstadoCarga> estado`, `RxString mensajeError`), salvo el cuerpo de `cargarLugares()` (ver tabla de abajo).
- `lib/bindings/places_binding.dart` — registra `PlacesController` con `Get.put` al arrancar la app.
- `lib/main.dart` — ya usa `GetMaterialApp` con `initialBinding: PlacesBinding()`.
- `lib/widgets/place_card.dart` — ya navega con `Get.to(() => DetailScreen(place: place))` en vez de `Navigator.push`.
- `lib/screens/add_place_screen.dart` — ya guarda el lugar nuevo vía `Get.find<PlacesController>().agregarLugar(...)` y cierra con `Get.back()`.
- `pubspec.yaml` — ya incluye `get`.

## Qué descomentar

| Archivo | Qué descomentar | Paso de la práctica |
|---|---|---|
| `lib/controllers/places_controller.dart` | En `cargarLugares()`: borrar `lugares.value = []; estado.value = EstadoCarga.exito;` y descomentar el bloque `try { ... } catch (e) { ... }` completo (`fetchLugaresSimulado` → estados) | Paso 2 |
| `lib/screens/home_screen.dart` | Borrar `body: const Center(child: Text('Pendiente de conectar con Obx'))` y descomentar el `body: Obx(() { ... })` completo | Paso 3 |

Con la rama recién traída (antes de descomentar nada), Inicio muestra el texto "Pendiente de conectar con Obx" — es el comportamiento esperado hasta completar los Pasos 2 y 3. El orden importa: el controller (Paso 2) debe quedar resuelto antes de que la pantalla (Paso 3) tenga algo real que mostrar. Las pestañas Mapa y Favoritos siguen siendo los placeholders de la Sesión 2.

## Comando de arranque

```bash
flutter pub get
flutter run
```
