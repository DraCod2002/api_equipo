import 'package:flutter/material.dart';
import 'package:api_equipo/screens/equiposScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipos de Fútbol',
      theme: ThemeData(
        brightness: Brightness.dark, // Establece el tema oscuro
        primarySwatch: Colors.deepPurple, // Color principal ajustado
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Color de fondo de los botones elevados
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepPurple, // Color de texto de los botones de texto
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple, // Color de fondo de la barra de app
        ),
      ),
      home: EquiposScreen(), // Aquí estableces EquiposScreen como la página inicial
    );
  }
}
