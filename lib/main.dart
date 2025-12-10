// ============================================
// PALACE FITNESS - Archivo Principal
// ============================================
// Punto de entrada de la aplicación.
// Configura el tema y la pantalla inicial.
// 
// ESTRUCTURA DE CARPETAS:
// lib/
// ├── main.dart                    <- Este archivo
// ├── tema/
// │   └── colores_app.dart         <- Colores y tema visual
// ├── modelos/
// │   └── modelo_usuario.dart      <- Modelos de datos
// ├── componentes/
// │   └── boton_personalizado.dart <- Widgets reutilizables
// └── pantallas/
//     ├── bienvenida/              <- Pantalla inicial
//     ├── autenticacion/           <- Login, registro, recuperar
//     ├── inicio/                  <- Home principal
//     ├── rutinas/                 <- Lista y detalle de rutinas
//     ├── ejercicios/              <- Catálogo de ejercicios
//     ├── progreso/                <- Seguimiento del progreso
//     ├── membresia/               <- Información de membresía
//     ├── perfil/                  <- Perfil del usuario
//     └── invitado/                <- Modo invitado

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tema/colores_app.dart';
import 'pantallas/bienvenida/pantalla_bienvenida.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configura la barra de estado para tema oscuro
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const PalaceFitnessApp());
}

/// Widget principal de la aplicación Palace Fitness
class PalaceFitnessApp extends StatelessWidget {
  const PalaceFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palace Fitness',
      debugShowCheckedModeBanner: false,
      theme: ColoresApp.temaOscuro, // Tema oscuro moderno con verde neón
      home: const PantallaBienvenida(), // Pantalla inicial
    );
  }
}
