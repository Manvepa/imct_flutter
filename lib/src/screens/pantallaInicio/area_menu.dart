// ============================================
// ARCHIVO: lib/src/screens/pantallaInicio/area_menu.dart
// ============================================

// Importa el paquete principal de Flutter para usar widgets, estilos y más.
import 'package:flutter/material.dart';

// Importa un archivo local que contiene los modelos de la aplicación (como MenuItem).
import '../../models/app_models.dart';

// Define un widget con estado (StatefulWidget) llamado AreaMenu.
class AreaMenu extends StatefulWidget {
  // Lista de elementos del menú, de tipo MenuItem.
  final List<MenuItem> menuItems;

  // Función opcional que se ejecuta cuando se toca un elemento del menú.
  final void Function(int)? onItemTap;

  // Índice inicial del elemento seleccionado.
  final int initialIndex;

  // Color de fondo del área del menú, en formato hexadecimal como cadena.
  final String backgroundColor;

  // Color que se usará para resaltar el elemento seleccionado.
  final String selectedColor;

  // Constructor del widget AreaMenu, que recibe parámetros requeridos y opcionales.
  const AreaMenu({
    Key? key,
    required this.menuItems, // Este parámetro es obligatorio.
    this.onItemTap, // Este es opcional (puede ser null).
    this.initialIndex = 0, // Valor predeterminado del índice inicial.
    this.backgroundColor = '#2C5F4F', // Color de fondo por defecto.
    this.selectedColor = '#FFC107', // Color de selección por defecto.
  }) : super(
         key: key,
       ); // Llama al constructor de la superclase (StatefulWidget).

  // Crea el estado asociado a este widget.
  @override
  State<AreaMenu> createState() => _AreaMenuState();
}

// Clase privada que representa el estado mutable de AreaMenu.
class _AreaMenuState extends State<AreaMenu> {
  // Variable que almacena el índice del elemento actualmente seleccionado.
  late int selectedIndex;

  // Método que se ejecuta una vez cuando el widget se inicializa.
  @override
  void initState() {
    super.initState();
    // Inicializa el índice seleccionado con el valor proporcionado en el widget.
    selectedIndex = widget.initialIndex;
  }

  // Método que construye el árbol de widgets de la interfaz.
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Altura fija del contenedor principal del menú.
      color: _hexToColor(
        widget.backgroundColor,
      ), // Aplica el color de fondo convertido.
      child: ListView.separated(
        // Lista horizontal de elementos separados.
        scrollDirection:
            Axis.horizontal, // Dirección de desplazamiento: horizontal.
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ), // Espaciado lateral.
        itemCount: widget.menuItems.length, // Cantidad de elementos del menú.
        // Define el separador entre cada elemento del menú.
        separatorBuilder: (context, index) => Container(
          width: 1, // Ancho de la línea separadora.
          height: 20, // Alto de la línea.
          margin: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 8,
          ), // Margen interno.
          color: Colors.white24, // Color blanco semitransparente.
        ),
        // Construye cada elemento del menú.
        itemBuilder: (context, index) {
          bool isSelected =
              index == selectedIndex; // Determina si el ítem está seleccionado.
          return _buildMenuItem(
            widget.menuItems[index],
            index,
            isSelected,
          ); // Llama a un método auxiliar.
        },
      ),
    );
  }

  // Método auxiliar que construye un solo elemento del menú.
  Widget _buildMenuItem(MenuItem item, int index, bool isSelected) {
    return InkWell(
      // Detecta toques en el área del elemento.
      onTap: () {
        // Acción al tocar el elemento.
        setState(() {
          // Actualiza el estado del widget.
          selectedIndex = index; // Cambia el índice seleccionado.
        });
        widget.onItemTap?.call(
          index,
        ); // Llama a la función externa si está definida.
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ), // Relleno interno.
        decoration: BoxDecoration(
          border: Border(
            // Agrega una línea en la parte inferior.
            bottom: BorderSide(
              color: isSelected
                  ? _hexToColor(
                      widget.selectedColor,
                    ) // Si está seleccionado, usa el color destacado.
                  : Colors.transparent, // Si no, no muestra borde.
              width: 3, // Grosor de la línea inferior.
            ),
          ),
        ),
        child: Center(
          // Centra el texto en el contenedor.
          child: Text(
            item.text.toUpperCase(), // Muestra el texto en mayúsculas.
            style: TextStyle(
              color: Colors.white, // Texto blanco.
              fontSize: 12, // Tamaño de fuente.
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal, // Negrita si está seleccionado.
              letterSpacing: 0.5, // Espaciado entre letras.
            ),
          ),
        ),
      ),
    );
  }

  // Método privado que convierte un color hexadecimal en un objeto Color de Flutter.
  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', ''); // Elimina el símbolo '#' si existe.
    return Color(
      int.parse('FF$hex', radix: 16),
    ); // Convierte el valor hexadecimal a entero ARGB.
  }
}
