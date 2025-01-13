import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Método para crear un botón con efecto de inclinación
Widget buildSkewedButton(BuildContext context, String characterName) {
  return Transform(
    transform: Matrix4.skewX(-0.3),
    origin: const Offset(50.0, 0.0),
    child: ElevatedButton(
      onPressed: () {
        context.push('/frame-data', extra: characterName);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        backgroundColor: Colors.red,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Text(
        characterName,
        style: const TextStyle(fontSize: 16.0 , color: Colors.white),
      ),
    ),
  );
}

// Método para crear un botón con efecto de inclinación
Widget buildSkewedSpecialButton(BuildContext context, String characterName) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinear a la izquierda
      children: [
        SizedBox(
          width: 175, // Ancho fijo para el botón único
          child: Transform(
            transform: Matrix4.skewX(-0.3),
            origin: const Offset(50.0, 0.0),
            child: ElevatedButton(
              onPressed: () {
                context.push('/frame-data', extra: characterName);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                backgroundColor: Colors.red,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                characterName,
                style: const TextStyle(fontSize: 16.0 , color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
