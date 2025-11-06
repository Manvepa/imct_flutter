// 📁 lib/src/services/evento/evento_service.dart
// ============================================================
// DESCRIPCIÓN:
// Servicio encargado de obtener los eventos desde un backend público.
// Integra soporte para imágenes (Cloudinary) y almacenamiento en caché
// local mediante SharedPreferences, para poder operar en modo offline.
// ============================================================

// Importamos las dependencias necesarias:
import 'package:dio/dio.dart'; // Librería para peticiones HTTP con soporte avanzado.
import 'package:shared_preferences/shared_preferences.dart'; // Permite guardar datos localmente.
import 'dart:convert'; // Necesario para convertir objetos a JSON y viceversa.

// Importaciones internas del proyecto.
import '../../api/dio_client.dart'; // Cliente centralizado de Dio (configura headers, baseURL, etc.).
import '../../api/endpoints.dart'; // Contiene las URLs de los endpoints del backend.
import '../../models/evento/event_model.dart'; // Modelo que representa un evento.

// Importacion para mostrar logs en consola usando logger
import 'package:logger/logger.dart';

// ============================================================
// 🔹 CLASE: EventoService
// Encargada de gestionar todas las operaciones relacionadas con eventos.
// ============================================================
class EventoService {
  // Instancia de Dio obtenida desde un cliente centralizado (singleton).
  final Dio _dio = DioClient.instance;

  // Metodo para mostrar logs usando logger
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      lineLength: 80,
    ),
  );

  // ============================================================
  // 🔸 MÉTODO: Obtener todos los eventos públicos
  // Descripción: Obtiene la lista de eventos desde el backend, y en caso
  // de fallo, carga los datos guardados en caché local.
  // ============================================================
  Future<List<EventoModel>> getPublicEventos() async {
    try {
      _logger.i('📡 Solicitando lista de eventos públicos...');

      // 🚀 Petición HTTP GET al endpoint público de eventos.
      final response = await _dio.get(Endpoints.eventos);

      _logger.i('📬 Código de respuesta: ${response.statusCode}');

      // Si la respuesta del servidor fue exitosa (HTTP 200)
      if (response.statusCode == 200) {
        final data = response.data;

        // 👇 El backend devuelve un objeto JSON con esta estructura:
        // { mensaje, total, eventos: [ ... ] }
        if (data is Map && data.containsKey('eventos')) {
          // Extraemos la lista de eventos.
          final List<dynamic> listaEventos = data['eventos'];

          _logger.i(
            '✅ Se recibieron ${listaEventos.length} eventos desde el backend',
          );

          // Convertimos cada evento JSON en un objeto EventoModel.
          final eventos = listaEventos
              .map((json) => EventoModel.fromJson(json))
              .toList();

          // 📸 Log de depuración: mostramos las URLs de las imágenes (Cloudinary).
          for (var e in eventos) {
            _logger.i('🖼️ Imagen evento (Cloudinary): ${e.imagen}');
          }

          // 💾 Guardamos los eventos en caché local para modo offline.
          await _guardarEventosEnCache('public_eventos', eventos);
          _logger.i('💾 Eventos públicos guardados en caché correctamente');

          // Retornamos la lista de eventos.
          return eventos;
        } else {
          // Si la respuesta no tiene el campo esperado "eventos".
          _logger.w('⚠️ Respuesta sin campo "eventos", usando caché local...');
          return await _obtenerEventosDesdeCache('public_eventos');
        }
      }

      // Si el código HTTP no es 200, se intenta cargar desde caché.
      _logger.w(
        '⚠️ Código HTTP inesperado (${response.statusCode}), usando caché...',
      );
      return await _obtenerEventosDesdeCache('public_eventos');
    }
    // ============================================================
    // 🧱 Manejo de errores específicos y genéricos
    // ============================================================
    on DioException catch (e) {
      // Errores de red: conexión fallida, timeout, etc.
      _logger.w('❌ Error de red: ${e.message}');
      _logger.i('📴 Mostrando datos en caché (modo offline)...');
      return await _obtenerEventosDesdeCache('public_eventos');
    } catch (e) {
      // Errores inesperados (parseo, tipo de dato, etc.)
      _logger.w('❌ Error inesperado: $e');
      return await _obtenerEventosDesdeCache('public_eventos');
    }
  }

  // ============================================================
  // 🔸 MÉTODO: Obtener Top 10 eventos
  // Descripción: Lógica similar a la anterior, pero consultando
  // un endpoint diferente y guardando con otra clave de caché.
  // ============================================================
  Future<List<EventoModel>> getTop10Eventos() async {
    try {
      _logger.i('📡 Solicitando Top 10 eventos...');

      // Realiza la petición HTTP al endpoint de Top10.
      final response = await _dio.get(Endpoints.eventosTop10);

      // Verificamos que la respuesta sea exitosa.
      if (response.statusCode == 200) {
        final data = response.data;

        // En este caso, el backend devuelve una lista directa.
        if (data is List) {
          _logger.i('✅ Se recibieron ${data.length} eventos del Top 10');

          // Convertimos cada ítem del JSON en un EventoModel.
          final eventos = data
              .map((json) => EventoModel.fromJson(json))
              .toList();

          // Imprimimos las URLs de las imágenes para depuración.
          for (var e in eventos) {
            _logger.i('🏆 Imagen evento (Top10): ${e.imagen}');
          }

          // Guardamos en caché local.
          await _guardarEventosEnCache('top10_eventos', eventos);
          _logger.i('💾 Top 10 guardado en caché correctamente');

          // Retornamos la lista final.
          return eventos;
        }
      }

      // Si no hubo éxito o el formato no es el esperado, usamos caché.
      _logger.w('⚠️ Respuesta inesperada del servidor, usando caché...');
      return await _obtenerEventosDesdeCache('top10_eventos');
    } on DioException catch (e) {
      // Manejo de error de red (sin conexión, tiempo agotado, etc.)
      _logger.w('❌ Error de red (Top10): ${e.message}');
      _logger.i('📴 Mostrando Top10 desde caché...');
      return await _obtenerEventosDesdeCache('top10_eventos');
    } catch (e) {
      // Manejo de error general.
      _logger.w('❌ Error inesperado en Top10: $e');
      return await _obtenerEventosDesdeCache('top10_eventos');
    }
  }

  // ============================================================
  // 🔹 MÉTODOS PRIVADOS DE CACHÉ
  // Estos métodos no son accesibles desde fuera de la clase.
  // ============================================================

  // Guarda una lista de eventos en caché local (SharedPreferences).
  Future<void> _guardarEventosEnCache(
    String key, // Clave con la que se guardará (e.g. 'top10_eventos')
    List<EventoModel> eventos, // Lista de eventos a guardar
  ) async {
    // Obtenemos la instancia de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();

    // Convertimos los objetos EventoModel a JSON y luego a String.
    final data = jsonEncode(eventos.map((e) => e.toJson()).toList());

    // Guardamos la cadena JSON bajo la clave especificada.
    await prefs.setString(key, data);
  }

  // Recupera los eventos almacenados previamente en caché.
  Future<List<EventoModel>> _obtenerEventosDesdeCache(String key) async {
    // Obtenemos la instancia de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();

    // Intentamos recuperar la cadena guardada.
    final data = prefs.getString(key);

    // Si existe información guardada:
    if (data != null) {
      // Decodificamos el string JSON a una lista dinámica.
      final List<dynamic> jsonList = jsonDecode(data);

      // Convertimos cada elemento JSON nuevamente en un EventoModel.
      final eventos = jsonList
          .map((json) => EventoModel.fromJson(json))
          .toList();

      // Mostramos en consola las imágenes cargadas desde caché.
      for (var e in eventos) {
        _logger.i('🗂️ Imagen evento (cache): ${e.imagen}');
      }

      _logger.i('📂 ${eventos.length} eventos cargados desde caché');
      return eventos;
    }

    // Si no hay datos guardados, devolvemos una lista vacía.
    _logger.w('⚠️ No hay datos guardados en caché para "$key"');
    return [];
  }
}
