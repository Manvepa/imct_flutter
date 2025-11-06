// 📁 lib/src/api/dio_client.dart
// Configuración del cliente Dio que manejará las peticiones HTTP a nuestro backend.

import 'package:dio/dio.dart';
import 'api_config.dart';
import 'package:logger/logger.dart';

class DioClient {
  // 🔧 Se crea una única instancia de Dio (patrón Singleton)
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '${ApiConfig.baseUrl}api/', // ✅ Se agrega /api solo aquí
      connectTimeout: const Duration(seconds: 10), // Tiempo máximo de conexión
      receiveTimeout: const Duration(
        seconds: 15,
      ), // Tiempo máximo para recibir respuesta
      headers: {'Content-Type': 'application/json'}, // Encabezado estándar
    ),
  );

  // Constructor privado para evitar crear múltiples instancias
  DioClient._();

  // Getter público para acceder a la instancia configurada
  static Dio get instance => _dio;

  // 🔥 Instancia global del logger
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      lineLength: 80,
    ),
  );

  // Método para inicializar interceptores globales (logs, errores, etc.)
  static void initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // Se ejecuta antes de enviar la petición
        onRequest: (options, handler) {
          _logger.i('🚀 Enviando petición a: ${options.uri}');
          return handler.next(options);
        },
        // Se ejecuta cuando llega la respuesta del servidor
        onResponse: (response, handler) {
          _logger.d('✅ Respuesta recibida: ${response.statusCode}');
          return handler.next(response);
        },
        // Se ejecuta si ocurre un error en la petición
        onError: (DioException e, handler) {
          _logger.e('❌ Error en la petición: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }
}
