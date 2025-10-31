// 📦 event_service.dart
// Este archivo se encarga de la comunicación entre el frontend Flutter
// y el backend Node.js (AppMovil) para obtener los eventos públicos
// y los Top 10 eventos.
//
// Utiliza el paquete `dio` para hacer las peticiones HTTP y maneja
// las respuestas JSON que vienen del backend, convirtiéndolas en
// instancias del modelo `EventoModel`.
//
// ⚙️ Incluye impresión detallada (prints) para debuggear los datos
// que llegan del backend, útil para verificar si las imágenes
// están siendo devueltas correctamente.

// ------------------------------------------------------------
// 🔹 Importaciones necesarias
// ------------------------------------------------------------
import 'package:dio/dio.dart'; // Para realizar peticiones HTTP
import '../../api/dio_client.dart'; // Configuración con la URL base del backend
import '../../api/endpoints.dart'; // Modelo del evento
import '../../models/evento/event_model.dart'; // Endpoints de la API

// ------------------------------------------------------------
// 🔹 Clase principal del servicio
// ------------------------------------------------------------
class EventoService {
  // Instancia de Dio para hacer peticiones HTTP
  final Dio _dio = DioClient.instance;

  // ------------------------------------------------------------
  // 🔸 Obtener todos los eventos públicos
  // ------------------------------------------------------------
  Future<List<EventoModel>> getPublicEventos() async {
    try {
      print('📡 Solicitando lista de eventos públicos...');

      // Hacemos la petición al backend
      final response = await _dio.get(Endpoints.eventos);

      print('🛰️ URL solicitada: ${response.realUri}');
      print('📥 Código de respuesta: ${response.statusCode}');
      print('📦 Datos crudos recibidos: ${response.data}');

      // Si la respuesta fue exitosa
      if (response.statusCode == 200) {
        final data = response.data;

        // Verificamos si es una lista de eventos
        print('🔍 Tipo de respuesta: ${data.runtimeType}');
        if (data is List) {
          print('✅ Se recibió una lista con ${data.length} eventos');

          // Convertimos el JSON en lista de objetos EventoModel
          final eventos = data
              .map((json) => EventoModel.fromJson(json))
              .toList();

          // Mostramos información de depuración
          for (int i = 0; i < eventos.length; i++) {
            print('🎯 Evento[${i + 1}] -> ${eventos[i].nombre}');
            print('🖼️ URL imagen: ${eventos[i].getImageUrl()}');
          }

          print('✅ Lista de eventos obtenida correctamente');
          return eventos;
        } else {
          print('⚠️ La respuesta no fue una lista. Tipo: ${data.runtimeType}');
          return [];
        }
      } else {
        throw Exception(
          'Error al obtener eventos públicos (Código: ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      print('❌ Error de red (eventos públicos): ${e.message}');
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      print('❌ Error inesperado en getPublicEventos: $e');
      throw Exception('Error inesperado: $e');
    }
  }

  // ------------------------------------------------------------
  // 🔸 Obtener Top 10 de eventos públicos (con debug detallado)
  // ------------------------------------------------------------
  Future<List<EventoModel>> getTop10Eventos() async {
    try {
      print('📡 Solicitando Top 10 eventos públicos...');

      // Hacemos la petición al endpoint del backend
      final response = await _dio.get(Endpoints.eventosTop10);

      print('🛰️ URL solicitada: ${response.realUri}');
      print('📥 Código de respuesta: ${response.statusCode}');
      print('📦 Datos crudos recibidos: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        // Verificamos el tipo de respuesta (importante para evitar errores tipo List vs Map)
        print('🔍 Tipo de respuesta: ${data.runtimeType}');
        if (data is List) {
          print('✅ Se recibió una lista con ${data.length} elementos');

          // Convertimos cada JSON en un objeto EventoModel
          final eventos = data
              .map((json) => EventoModel.fromJson(json))
              .toList();

          // Revisamos las imágenes que llegaron después de convertir
          for (int i = 0; i < eventos.length; i++) {
            print('🏆 Evento[${i + 1}] -> ${eventos[i].nombre}');
            print('🖼️ URL imagen: ${eventos[i].getImageUrl()}');
          }

          print('✅ Top 10 eventos obtenidos correctamente');
          return eventos;
        } else {
          // Si no es una lista (por ejemplo, si es un objeto con clave 'data')
          print('⚠️ La respuesta no fue una lista. Tipo: ${data.runtimeType}');
          print('🧩 Contenido de respuesta: $data');
          return [];
        }
      } else {
        throw Exception(
          'Error al obtener Top 10 (Código: ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      print('❌ Error de red (Top10): ${e.message}');
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      print('❌ Error inesperado en getTop10Eventos: $e');
      throw Exception('Error inesperado: $e');
    }
  }
}
