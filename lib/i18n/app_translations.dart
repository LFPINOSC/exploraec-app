import 'package:get/get.dart';

/// Textos de la app en cada idioma — Paso 6B (opcional) de la Sesión 4.
/// La clave (`'inicio'`) se busca con `'inicio'.tr` en el idioma activo de
/// `Get.locale`; si una clave no existe en ese idioma, GetX usa
/// `fallbackLocale` y, si tampoco está, muestra la clave tal cual.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es_EC': {
          'inicio': 'Inicio',
          'mapa': 'Mapa',
          'favoritos': 'Favoritos',
          'idioma': 'Cambiar idioma',
          'sim_normal': 'Simular: normal',
          'sim_vacio': 'Simular: vacío',
          'sim_error': 'Simular: error',
          'agregar_lugar': 'Agregar lugar',
          'lugar_agregado': 'Lugar agregado',
          'lugar_agregado_msg': 'Ya aparece en Inicio',
        },
        'en_US': {
          'inicio': 'Home',
          'mapa': 'Map',
          'favoritos': 'Favorites',
          'idioma': 'Change language',
          'sim_normal': 'Simulate: normal',
          'sim_vacio': 'Simulate: empty',
          'sim_error': 'Simulate: error',
          'agregar_lugar': 'Add place',
          'lugar_agregado': 'Place added',
          'lugar_agregado_msg': 'It now shows up on Home',
        },
      };
}
