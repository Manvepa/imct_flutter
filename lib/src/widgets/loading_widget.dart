// 📁 lib/src/widgets/loading_widget.dart
// Este widget muestra una animación o texto indicando que la aplicación está cargando datos.

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message; // Mensaje opcional para mostrar debajo del loader

  const LoadingWidget({
    super.key,
    this.message = 'Cargando...', // Valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Indicador circular de carga
          const CircularProgressIndicator(),
          const SizedBox(height: 16), // Espacio entre elementos
          // Texto con el mensaje de carga
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
