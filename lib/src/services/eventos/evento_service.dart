// 📁 lib/src/services/evento/evento_service.dart
// ============================================================
// DESCRIPCIÓN:
// Servicio encargado de obtener los eventos del backend público
// y almacenarlos en caché local para poder mostrarlos sin conexión.
//
// - Usa `Dio` para las peticiones HTTP.
// - Usa `SharedPreferences` para guardar los datos localmente.
// - Evita errores visuales si no hay conexión.
// ============================================================

// ------------------------------------------------------------
// 🔹 Importaciones necesarias
// ------------------------------------------------------------
import 'package:dio/dio.dart'; // Para realizar peticiones HTTP
import 'package:shared_preferences/shared_preferences.dart'; // Para guardar datos localmente (modo offline)
import 'dart:convert'; // Para convertir listas y objetos a JSON

import '../../api/dio_client.dart'; // Configuración base de Dio
import '../../api/endpoints.dart'; // Rutas del backend (eventos, top10)
import '../../models/evento/event_model.dart'; // Modelo de datos del evento

// ------------------------------------------------------------
// 🔹 Clase principal del servicio de eventos
// ------------------------------------------------------------
class EventoService {
  // Instancia única de Dio configurada con la URL base del backend
  final Dio _dio = DioClient.instance;

  // ============================================================
  // 🔸 Obtener todos los eventos públicos (con modo offline)
  // ============================================================
  Future<List<EventoModel>> getPublicEventos() async {
    try {
      print('📡 Solicitando lista de eventos públicos...');

      // Hacemos la petición al backend
      final response = await _dio.get(Endpoints.eventos);

      // Si la respuesta fue exitosa (HTTP 200)
      if (response.statusCode == 200) {
        final data = response.data;

        // Verificamos si lo que viene del backend es una lista
        if (data is List) {
          print('✅ Se recibieron ${data.length} eventos');

          // Convertimos los JSON a objetos EventoModel
          final eventos = data
              .map((json) => EventoModel.fromJson(json))
              .toList();

          // ✅ Guardamos los datos en caché local
          await _guardarEventosEnCache('public_eventos', eventos);

          print('💾 Eventos públicos guardados en caché correctamente');
          return eventos;
        }
      }

      print('⚠️ Respuesta inesperada del servidor, usando caché...');
      return await _obtenerEventosDesdeCache('public_eventos');
    } on DioException catch (e) {
      // Si hay error de red, cargamos los datos guardados localmente
      print('❌ Error de red: ${e.message}');
      print('📴 Mostrando datos en caché (modo offline)...');
      return await _obtenerEventosDesdeCache('public_eventos');
    } catch (e) {
      print('❌ Error inesperado: $e');
      return await _obtenerEventosDesdeCache('public_eventos');
    }
  }

  // ============================================================
  // 🔸 Obtener el Top 10 de eventos (con modo offline)
  // ============================================================
  Future<List<EventoModel>> getTop10Eventos() async {
    try {
      print('📡 Solicitando Top 10 eventos...');

      // Petición HTTP al backend
      final response = await _dio.get(Endpoints.eventosTop10);

      if (response.statusCode == 200) {
        final data = response.data;

        // Si recibimos una lista de eventos
        if (data is List) {
          print('✅ Se recibieron ${data.length} eventos del Top 10');

          final eventos = data
              .map((json) => EventoModel.fromJson(json))
              .toList();

          // ✅ Guardamos los datos localmente
          await _guardarEventosEnCache('top10_eventos', eventos);

          print('💾 Top 10 guardado en caché correctamente');
          return eventos;
        }
      }

      print('⚠️ Respuesta inesperada del servidor, usando caché...');
      return await _obtenerEventosDesdeCache('top10_eventos');
    } on DioException catch (e) {
      print('❌ Error de red (Top10): ${e.message}');
      print('📴 Mostrando Top10 desde caché...');
      return await _obtenerEventosDesdeCache('top10_eventos');
    } catch (e) {
      print('❌ Error inesperado en Top10: $e');
      return await _obtenerEventosDesdeCache('top10_eventos');
    }
  }

  // ============================================================
  // 🔹 Métodos privados para caché local (SharedPreferences)
  // ============================================================

  // Guarda los eventos en caché local en formato JSON
  Future<void> _guardarEventosEnCache(
    String key,
    List<EventoModel> eventos,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(eventos.map((e) => e.toJson()).toList());
    await prefs.setString(key, data);
  }

  // Obtiene los eventos desde la caché local
  Future<List<EventoModel>> _obtenerEventosDesdeCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      final eventos = jsonList
          .map((json) => EventoModel.fromJson(json))
          .toList();
      print('📂 ${eventos.length} eventos cargados desde caché');
      return eventos;
    }

    print('⚠️ No hay datos guardados en caché para "$key"');
    return [];
  }
}
