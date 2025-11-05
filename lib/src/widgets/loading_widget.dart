// 📁 lib/src/widgets/loading_widget.dart
// ============================================================
// DESCRIPCIÓN:
// Este widget muestra una animación de carga (loader) acompañada
// de un texto informativo opcional mientras la aplicación obtiene
// datos o realiza procesos en segundo plano.
// ============================================================

// Importamos el paquete base de Flutter que contiene los widgets visuales.
import 'package:flutter/material.dart';

// ============================================================
// 🔹 CLASE: LoadingWidget
// ------------------------------------------------------------
// Es un widget sin estado (StatelessWidget) que representa una
// vista simple de carga con un spinner y un mensaje opcional.
// ============================================================
class LoadingWidget extends StatelessWidget {
  // Mensaje opcional que se muestra debajo del spinner de carga.
  final String message;

  // Constructor del widget, con un valor por defecto para el mensaje.
  // Si no se proporciona un mensaje, mostrará "Cargando...".
  const LoadingWidget({
    super.key,
    this.message = 'Cargando...', // Valor por defecto del texto
  });

  // ============================================================
  // MÉTODO build()
  // ------------------------------------------------------------
  // Se ejecuta cuando Flutter necesita renderizar el widget en
  // la pantalla. Retorna la estructura visual del componente.
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Center(
      // Centra su contenido tanto vertical como horizontalmente.
      child: Column(
        // Coloca los elementos uno debajo del otro (verticalmente).
        mainAxisAlignment:
            MainAxisAlignment.center, // Centra verticalmente el contenido
        children: [
          // ======================================================
          // 🔸 Indicador circular de progreso
          // ------------------------------------------------------
          // Es el típico spinner de Flutter que gira indefinidamente.
          // Indica que hay un proceso en curso (sin progreso definido).
          // ======================================================
          const CircularProgressIndicator(),

          // ======================================================
          // 🔸 Espaciado entre el spinner y el texto
          // ------------------------------------------------------
          // SizedBox se utiliza para dejar un espacio visual de 16 píxeles.
          // ======================================================
          const SizedBox(height: 16),

          // ======================================================
          // 🔸 Texto con el mensaje de carga
          // ------------------------------------------------------
          // Muestra el texto recibido en el parámetro "message".
          // Por ejemplo: "Cargando eventos..." o "Obteniendo datos...".
          // ======================================================
          Text(
            message, // Mensaje dinámico o el valor por defecto
            style: const TextStyle(
              fontSize: 16, // Tamaño de fuente del texto
              color: Colors.grey, // Color gris para indicar estado secundario
            ),
          ),
        ],
      ),
    );
  }
}
