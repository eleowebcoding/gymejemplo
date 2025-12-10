// ============================================
// PALACE FITNESS - Tema Oscuro Premium
// ============================================
// Paleta: Negro profundo + Coral/Rosa + Estilo Fitbod

import 'package:flutter/material.dart';

class ColoresApp {
  // Fondos oscuros
  static const Color fondoPrincipal = Color(0xFF0D0D0F);
  static const Color fondoSecundario = Color(0xFF151518);
  static const Color fondoTarjeta = Color(0xFF1C1C21);
  static const Color fondoElevado = Color(0xFF252529);
  
  // Acento coral/rosa (estilo Fitbod)
  static const Color acento = Color(0xFFFF6B6B);
  static const Color acentoSecundario = Color(0xFFEE5A5A);
  
  // Textos
  static const Color textoClaro = Color(0xFFFFFFFF);
  static const Color textoSecundario = Color(0xFF8E8E9A);
  static const Color textoApagado = Color(0xFF5A5A6A);
  
  // Estados
  static const Color exito = Color(0xFF00F5A0);
  static const Color error = Color(0xFFFF4757);
  static const Color advertencia = Color(0xFFFFBE0B);

  // Gradiente principal
  static const LinearGradient gradienteAcento = LinearGradient(
    colors: [acento, acentoSecundario],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get temaOscuro {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: acento,
      scaffoldBackgroundColor: fondoPrincipal,
      fontFamily: 'Roboto',
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textoClaro,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: textoClaro),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: acento,
          foregroundColor: fondoPrincipal,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: acento,
          side: const BorderSide(color: acento, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: acento),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fondoTarjeta,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: acento, width: 2)),
        labelStyle: const TextStyle(color: textoSecundario),
        hintStyle: const TextStyle(color: textoApagado),
        prefixIconColor: textoSecundario,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      
      colorScheme: const ColorScheme.dark(
        primary: acento,
        secondary: acentoSecundario,
        surface: fondoTarjeta,
        error: error,
      ),
    );
  }
}
