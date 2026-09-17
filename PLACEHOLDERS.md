# Placeholders de esta rama (sesion-02)

Punto de partida: proyecto `exploraec` recién creado (Sesión 1) — solo con `lib/main.dart` mostrando una pantalla de bienvenida. El resto de los archivos de esta rama ya están en el árbol. Cada uno trae una versión provisional que ya compila (para que `flutter run` nunca muestre una pantalla en blanco ni un error) y, comentada justo debajo, la versión real que hay que descomentar en la práctica.

| Archivo | Qué descomentar | Paso de la práctica |
|---|---|---|
| `lib/models/place.dart` | La lista `lugaresEjemplo` con 6 lugares de ejemplo | Paso 2 |
| `lib/widgets/place_card.dart` | El `child` con el cuerpo visual de la tarjeta (`Row`/`Column`/`Text`) | Paso 3 |
| `lib/screens/home_screen.dart` | El `body` con el `ListView.builder` que recorre `lugaresEjemplo` | Paso 3 |
| `lib/widgets/place_card.dart` | El `onTap` que navega a `DetailScreen` | Paso 4 |
| `lib/screens/add_place_screen.dart` | Los 3 `TextFormField` con su `validator` | Paso 5 |
| `lib/screens/add_place_screen.dart` | El `onPressed` del botón "Guardar" | Paso 5 |
| `lib/main.dart` | El `bottomNavigationBar` con sus 3 ítems | Paso 6 |
| `lib/main.dart` | El `body` que alterna según `_indiceActual` | Paso 6 |

En cada archivo, primero se **borra** el bloque provisional (el que ya está activo) y luego se **descomenta** el bloque de abajo — nunca dejes los dos activos a la vez. Atajo del editor para descomentar un bloque seleccionado: `Ctrl+/` en Windows/Linux, `Cmd+/` en Mac.

`lib/screens/detail_screen.dart`, `lib/screens/map_placeholder_screen.dart` y `lib/screens/favorites_placeholder_screen.dart` ya están completos, sin `TODO` — no requieren ningún paso de la práctica.

## Comando de arranque

```bash
flutter pub get
flutter run
```

Con la rama recién clonada (antes de descomentar nada), la app corre con la pantalla de Inicio mostrando "Cargando lugares...", tarjetas vacías si llegaras a tocar una (no hay lista todavía), un formulario con campos sin validar, y sin barra de navegación inferior — todo intencional, para que cada paso de la práctica produzca un cambio visible.
