// ============================================
// ARCHIVO: lib/src/services/evento_service.dart (NUEVO)
// Servicio para manejar todas las peticiones relacionadas con eventos
// ============================================

import 'package:dio/dio.dart';
import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../models/evento/event_model.dart';

class EventoService {
  final Dio _dio = DioClient.instance;

  /// Obtener el Top 10 de eventos
  Future<List<EventoModel>> getTop10Eventos() async {
    try {
      print('📡 Solicitando Top 10 eventos...');

      final response = await _dio.get(Endpoints.eventosTop10);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // Convertir cada elemento del JSON a EventoModel
        List<EventoModel> eventos = data
            .map((json) => EventoModel.fromJson(json))
            .toList();

        print('✅ Top 10 eventos obtenidos: ${eventos.length} eventos');
        return eventos;
      } else {
        throw Exception('Error al obtener eventos: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Error de red: ${e.message}');

      // Manejo de diferentes tipos de errores
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Timeout: El servidor tardó demasiado en responder');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Timeout: Tardó demasiado en recibir los datos');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Endpoint no encontrado (404)');
      } else if (e.response?.statusCode == 500) {
        throw Exception('Error interno del servidor (500)');
      } else {
        throw Exception('Error de conexión: ${e.message}');
      }
    } catch (e) {
      print('❌ Error inesperado: $e');
      throw Exception('Error inesperado: $e');
    }
  }

  /// Obtener todos los eventos
  Future<List<EventoModel>> getTodosEventos() async {
    try {
      print('📡 Solicitando todos los eventos...');

      final response = await _dio.get(Endpoints.eventos);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        List<EventoModel> eventos = data
            .map((json) => EventoModel.fromJson(json))
            .toList();

        print('✅ Eventos obtenidos: ${eventos.length} eventos');
        return eventos;
      } else {
        throw Exception('Error al obtener eventos: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Error de red: ${e.message}');
      throw Exception('Error de conexión: ${e.message}');
    }
  }

  /// Obtener un evento por ID
  Future<EventoModel> getEventoById(int id) async {
    try {
      print('📡 Solicitando evento con ID: $id');

      final response = await _dio.get('${Endpoints.eventoById}/$id');

      if (response.statusCode == 200) {
        EventoModel evento = EventoModel.fromJson(response.data);
        print('✅ Evento obtenido: ${evento.nombre}');
        return evento;
      } else {
        throw Exception('Error al obtener evento: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Error de red: ${e.message}');
      throw Exception('Error de conexión: ${e.message}');
    }
  }
}
