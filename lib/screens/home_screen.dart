import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/location_service.dart';
import '../services/places_api_service.dart';
import '../widgets/place_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../theme/app_theme.dart';
import 'add_place_screen.dart';

/// Pantalla de Inicio: lista de lugares — Sesión 2 (datos de ejemplo).
/// Desde la Sesión 3, la carga pasa por estados loading/vacío/error y un
/// layout responsivo. Desde la Sesión 5, esos mismos estados —construidos
/// para una carga simulada— pasan a alimentarse de una `Future` real: la
/// Overpass API. La interfaz (`FutureBuilder`, `LoadingView`/`EmptyView`/
/// `ErrorView`) no cambia una sola línea; solo cambia de dónde viene la
/// promesa.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Place>> _futuroLugares;
  bool _modoDebugError = false;
  bool _modoDebugVacio = false;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  /// Dispara (o vuelve a disparar) la carga. [_modoDebugError]/[_modoDebugVacio]
  /// son solo un recurso de esta práctica, para demostrar los 3 estados sin
  /// depender de que Overpass responda distinto cada vez — no existen en la
  /// versión final de la app.
  void _cargar() {
    setState(() {
      // TODO(sesion-05): borra la línea de abajo y descomenta el bloque completo. (Paso 3 — datos reales)
      _futuroLugares = Future.value(<Place>[]);
      // _futuroLugares = _cargarLugaresReales();
    });
  }

  /// Posición actual (Sesión 4) → Overpass API (Sesión 5) → se agregan los
  /// lugares que el propio usuario creó a mano en `AddPlaceScreen` (siguen
  /// solo en memoria hasta que la Sesión 7 los persista).
  // TODO(sesion-05): borra la línea de abajo y descomenta el bloque completo. (Paso 3 — datos reales)
  // Future<List<Place>> _cargarLugaresReales() async {
  //   final posicion = await LocationService.obtenerPosicionActual();
  //   final reales = await PlacesApiService.buscarLugaresCercanos(
  //     posicion,
  //     forzarError: _modoDebugError,
  //     forzarVacio: _modoDebugVacio,
  //   );
  //   return [...reales, ...lugaresEjemplo];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExploraEC'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Simular estado (solo práctica)',
            onSelected: (valor) {
              _modoDebugError = valor == 'error';
              _modoDebugVacio = valor == 'vacio';
              _cargar();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'normal', child: Text('Simular: normal')),
              PopupMenuItem(value: 'vacio', child: Text('Simular: vacío')),
              PopupMenuItem(value: 'error', child: Text('Simular: error')),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Place>>(
        future: _futuroLugares,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(mensaje: 'Buscando lugares cercanos...');
          }
          if (snapshot.hasError) {
            return ErrorView(mensaje: '${snapshot.error}', onReintentar: _cargar);
          }
          final lugares = snapshot.data ?? [];
          if (lugares.isEmpty) {
            return const EmptyView(mensaje: 'Todavía no hay lugares guardados');
          }
          return _buildLista(lugares);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlaceScreen()),
          );
          _cargar();
        },
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
