import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/places_controller.dart';
import '../models/place.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/place_card.dart';
import 'add_place_screen.dart';

/// Pantalla de Inicio: lista de lugares — Sesión 2. Desde la Sesión 6 ya
/// no mantiene su propio `Future`/`setState`: `GetView<PlacesController>`
/// da acceso directo al controller ya registrado por `PlacesBinding`
/// (equivalente a `Get.find<PlacesController>()`, pero sin repetirlo en
/// cada método), y `Obx` reconstruye la pantalla sola cuando el controller
/// cambia — el mismo controller que ahora también usa `MapScreen`.
class HomeScreen extends GetView<PlacesController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExploraEC'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Simular estado (solo práctica)',
            onSelected: controller.simular,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'normal', child: Text('Simular: normal')),
              PopupMenuItem(value: 'vacio', child: Text('Simular: vacío')),
              PopupMenuItem(value: 'error', child: Text('Simular: error')),
            ],
          ),
        ],
      ),
      // TODO(sesion-06): borra la línea de abajo y descomenta el bloque completo. (Paso 4 — reactividad con Obx)
      // Por qué: el texto fijo de abajo nunca cambia porque nada lo
      // observa — Obx reconstruye automáticamente su contenido cada vez
      // que una variable Rx que lee (controller.estado, controller.lugares)
      // cambia, sin necesitar setState ni StatefulWidget en esta pantalla.
      body: const Center(child: Text('Pendiente de conectar con Obx')),
      // body: Obx(() {
      //   if (controller.estado.value == EstadoCarga.cargando) {
      //     return const LoadingView(mensaje: 'Buscando lugares cercanos...');
      //   }
      //   if (controller.estado.value == EstadoCarga.error) {
      //     return ErrorView(
      //       mensaje: controller.mensajeError.value,
      //       onReintentar: controller.cargarLugares,
      //     );
      //   }
      //   if (controller.lugares.isEmpty) {
      //     return const EmptyView(mensaje: 'Todavía no hay lugares guardados');
      //   }
      //   return _buildLista(controller.lugares);
      // }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddPlaceScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLista(List<Place> lugares) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemCount: lugares.length,
            itemBuilder: (context, index) => PlaceCard(place: lugares[index]),
          );
        }
        final columnas = constraints.maxWidth < 900 ? 2 : 3;
        return GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.sm),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnas,
            childAspectRatio: 2.4,
          ),
          itemCount: lugares.length,
          itemBuilder: (context, index) => PlaceCard(place: lugares[index]),
        );
      },
    );
  }
}
