// 📁 lib/src/services/user_service.dart
// Servicio encargado de comunicarse con el backend Node.js para las operaciones relacionadas con usuarios.
// Utiliza Dio (cliente HTTP avanzado) para realizar las peticiones a las rutas definidas en endpoints.dart.

import 'package:dio/dio.dart';
import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../models/usuario/user_model.dart';

class UserService {
  // Se obtiene la instancia global de Dio ya configurada con baseUrl e interceptores
  final Dio _dio = DioClient.instance;

  // Constructor: inicializa interceptores de Dio solo una vez
  UserService() {
    DioClient.initializeInterceptors();
  }

  // 🧱 Método para obtener la lista de usuarios desde el backend
  Future<List<UserModel>> getUsers() async {
    try {
      // Se realiza una petición GET a la ruta '/users'
      final response = await _dio.get(Endpoints.users);

      // Verificamos si la respuesta fue exitosa (código 200)
      if (response.statusCode == 200) {
        // Convertimos cada elemento del JSON en una instancia de UserModel
        List<dynamic> data = response.data;
        return data.map((user) => UserModel.fromJson(user)).toList();
      } else {
        // Si el servidor responde con otro código, lanzamos un error
        throw Exception('Error al obtener usuarios: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Captura de errores específicos de Dio (como tiempo de espera o conexión)
      throw Exception('Error de red: ${e.message}');
    } catch (e) {
      // Captura de errores generales
      throw Exception('Error inesperado: $e');
    }
  }

  // 🧩 Método para registrar un nuevo usuario (POST)
  Future<UserModel> registerUser(Map<String, dynamic> userData) async {
    try {
      // Enviamos una petición POST con el cuerpo del usuario
      final response = await _dio.post(Endpoints.register, data: userData);

      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Error al registrar usuario');
      }
    } on DioException catch (e) {
      throw Exception('Error de red al registrar: ${e.message}');
    }
  }

  // 🔐 Método para iniciar sesión (POST)
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        Endpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Se devuelve el token u otros datos del backend
        return response.data;
      } else {
        throw Exception('Credenciales inválidas');
      }
    } on DioException catch (e) {
      throw Exception('Error al iniciar sesión: ${e.message}');
    }
  }
}
