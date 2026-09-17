import 'package:flutter/material.dart';
import '../models/place.dart';
import '../screens/detail_screen.dart';

/// Tarjeta reutilizable que representa un [Place] en cualquier lista de
/// la app (Inicio, resultados de categoría, etc.) — Sesión 2.
class PlaceCard extends StatelessWidget {
  final Place place;
  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        // TODO(sesion-02): borra la línea de abajo y descomenta el bloque completo. (Paso 4 — navegación al Detalle)
        onTap: null,
        // onTap: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DetailScreen(place: place)),
        // ),

        // TODO(sesion-02): borra la línea de abajo y descomenta el bloque completo. (Paso 3 — cuerpo de la tarjeta)
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Cargando tarjeta...'),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.all(12),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Icon(Icons.place, size: 32),
        //       const SizedBox(width: 12),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               place.nombre,
        //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             const SizedBox(height: 4),
        //             Text(place.categoria, style: const TextStyle(color: Colors.grey)),
        //             const SizedBox(height: 4),
        //             Text(
        //               place.descripcion,
        //               maxLines: 2,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
