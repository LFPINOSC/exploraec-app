import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/place.dart';
import '../services/location_service.dart';
import '../theme/app_theme.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import 'detail_screen.dart';

/// Pantalla de Mapa real — Sesión 4. Reemplaza a `MapPlaceholderScreen`
/// (Sesión 2). Teselas de OpenStreetMap, sin API key: ver la política de
/// uso de tiles de OSM citada en la teoría de esta sesión.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<Position> _futuroPosicion;

  @override
  void initState() {
    super.initState();
    _futuroPosicion = LocationService.obtenerPosicionActual();
  }

  void _reintentar() {
    setState(() => _futuroPosicion = LocationService.obtenerPosicionActual());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa')),
      body: FutureBuilder<Position>(
        future: _futuroPosicion,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(mensaje: 'Obteniendo tu ubicación...');
          }
          if (snapshot.hasError) {
            return ErrorView(mensaje: '${snapshot.error}', onReintentar: _reintentar);
          }
          return _buildMapa(context, snapshot.data!);
        },
      ),
    );
  }

  Widget _buildMapa(BuildContext context, Position posicion) {
    final miUbicacion = LatLng(posicion.latitude, posicion.longitude);
    return FlutterMap(
      options: MapOptions(initialCenter: miUbicacion, initialZoom: 15),
      children: [
        // La política de uso de tiles de OSM exige un userAgentPackageName
        // real que identifique la app — no dejar el valor de ejemplo del
        // paquete en una app publicada.
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.tmo.exploraec',
        ),
        // TODO(sesion-04): borra la línea de abajo y descomenta el bloque completo. (Paso 4 — marcadores)
        const MarkerLayer(markers: []),
        // MarkerLayer(
        //   markers: [
        //     Marker(
        //       point: miUbicacion,
        //       width: 40,
        //       height: 40,
        //       child: const Icon(Icons.my_location, color: Colors.blue, size: 32),
        //     ),
        //     ...lugaresEjemplo.map(
        //       (lugar) => Marker(
        //         point: LatLng(lugar.lat, lugar.lng),
        //         width: 40,
        //         height: 40,
        //         child: GestureDetector(
        //           onTap: () => Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => DetailScreen(
        //                 place: lugar,
        //                 distanciaMetros: distanciaAPlaceEnMetros(posicion, lugar),
        //               ),
        //             ),
        //           ),
        //           child: Icon(Icons.place, color: AppTheme.colorPrimario, size: 36),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
