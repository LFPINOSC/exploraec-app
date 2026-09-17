import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/place.dart';
import '../services/location_service.dart';
import '../services/places_api_service.dart';

enum EstadoCarga { cargando, exito, error }

/// Fuente única de verdad de los lugares y la posición del usuario —
/// Sesión 6. Antes de esta sesión, `HomeScreen` y `MapScreen` pedían cada
/// una su propia copia por separado (cada una llamaba a `LocationService`,
/// y solo Inicio llamaba a la Overpass API): el Mapa seguía mostrando
/// `lugaresEjemplo` mientras Inicio ya mostraba datos reales, y la
/// posición se pedía al sistema operativo dos veces. Ahora ambas pantallas
/// leen del mismo `PlacesController`, registrado una sola vez por
/// `PlacesBinding` y obtenido con `Get.find()` (vía `GetView`, ver
/// `HomeScreen`/`MapScreen`).
class PlacesController extends GetxController {
  final RxList<Place> lugares = <Place>[].obs;
  final Rx<EstadoCarga> estado = EstadoCarga.cargando.obs;
  final RxString mensajeError = ''.obs;
  final Rx<Position?> posicion = Rx<Position?>(null);

  bool _modoDebugError = false;
  bool _modoDebugVacio = false;

  @override
  void onInit() {
    super.onInit();
    cargarLugares();
  }

  /// Simula uno de los 3 estados a propósito, solo para esta práctica —
  /// mismo recurso que ya traía `HomeScreen` desde la Sesión 3, ahora
  /// centralizado aquí porque el Mapa también necesita poder mostrarlos.
  void simular(String modo) {
    _modoDebugError = modo == 'error';
    _modoDebugVacio = modo == 'vacio';
    cargarLugares();
  }

  Future<void> cargarLugares() async {
    estado.value = EstadoCarga.cargando;

    // TODO(sesion-06): borra la línea de abajo y descomenta el bloque completo. (Paso 3 — conectar el controller a los servicios reales)
    lugares.value = [];
    estado.value = EstadoCarga.exito;
    // try {
    //   final pos = await LocationService.obtenerPosicionActual();
    //   posicion.value = pos;
    //   final reales = await PlacesApiService.buscarLugaresCercanos(
    //     pos,
    //     forzarError: _modoDebugError,
    //     forzarVacio: _modoDebugVacio,
    //   );
    //   lugares.value = [...reales, ...lugaresEjemplo];
    //   estado.value = EstadoCarga.exito;
    // } catch (e) {
    //   mensajeError.value = '$e';
    //   estado.value = EstadoCarga.error;
    // }
  }

  /// Agrega un lugar creado a mano (`AddPlaceScreen`) — en memoria
  /// únicamente hasta que la Sesión 7 lo persista con Hive. `lugares.add`
  /// (en vez de reconstruir toda la lista) ya notifica a cualquier `Obx`
  /// que esté escuchando, en Inicio y en el Mapa a la vez.
  void agregarLugar(Place lugar) {
    lugaresEjemplo.add(lugar);
    lugares.add(lugar);
  }

  double? distanciaA(Place lugar) {
    final pos = posicion.value;
    return pos == null ? null : distanciaAPlaceEnMetros(pos, lugar);
  }
}
