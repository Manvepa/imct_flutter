// ============================================
// ARCHIVO: lib/src/widgets/evento_detalle_modal.dart
// ============================================

import 'package:flutter/material.dart';
import '../../models/evento/event_model.dart';

// ============================================
// WIDGET: Modal con detalle de un evento
// ============================================

class EventoDetalleModal extends StatelessWidget {
  final EventoModel evento;
  final void Function(String) onNavigate;

  const EventoDetalleModal({
    super.key,
    required this.evento,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Línea superior del modal
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Imagen del evento
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              evento.getImageUrl(),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 250,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 80),
              ),
            ),
          ),

          // Contenido principal del evento
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5F4F),
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (evento.fecha != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          evento.fecha!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),

                  if (evento.ubicacion != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            evento.ubicacion!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  if (evento.descripcion != null) ...[
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      evento.descripcion!,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ],

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onNavigate('Más info: ${evento.nombre}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C5F4F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Más información',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
