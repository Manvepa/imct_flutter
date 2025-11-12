// 📁 lib/src/screens/pantallaInicio/footer_background.dart
// ------------------------------------------------------------
// Este widget representa una sección visual independiente debajo
// del footer, mostrando solo una imagen decorativa a pantalla completa
// o a cierta altura, sin mezclarla con los íconos del footer.
// ------------------------------------------------------------

import 'package:flutter/material.dart';

class FooterBackground extends StatelessWidget {
  const FooterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // 📏 Obtenemos el tamaño de pantalla para ajustar la imagen
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.1, // 🔹 Altura ajustable (40% de la pantalla)
      child: Image.network(
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        fit: BoxFit.cover, // Cubre todo el ancho y alto sin deformarse
      ),
    );
  }
}
