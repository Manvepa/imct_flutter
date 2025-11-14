// 📁 lib/src/api/endpoints.dart
// Contiene las rutas relativas de las API disponibles en el backend Node.js.

class Endpoints {
  // 👥 Endpoints de ejemplo (puedes personalizarlos según tus rutas en Express)
  static const String users = '/users'; // GET - Listar usuarios
  static const String login = '/auth/login'; // POST - Iniciar sesión
  static const String register = '/auth/register'; // POST - Registrar usuario

  // 🎉 Endpoints de eventos
  static const String eventosTop10 = '/public/eventos/top10';
  static const String eventos = '/public/eventos';
  static const String eventoById = '/public/eventos'; // Usar con /{id}

  // 🗺️ Endpoints de rutas y experiencias
  static const String lugaresTop10 = '/public/lugares/top10';
  static const String lugares = '/public/lugares';
  static const String lugarById = '/public/lugares';
}
