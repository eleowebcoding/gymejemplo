// ============================================
// PALACE FITNESS - Transiciones Animadas
// ============================================
// Animaciones personalizadas entre pantallas

import 'package:flutter/material.dart';

/// Transición con fade y slide desde la derecha
class TransicionSlide extends PageRouteBuilder {
  final Widget pagina;
  
  TransicionSlide({required this.pagina})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => pagina,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Curva suave
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            
            // Slide desde la derecha
            final slideAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(curvedAnimation);
            
            // Fade
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation);
            
            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );
}

/// Transición con fade y scale (zoom suave)
class TransicionFadeScale extends PageRouteBuilder {
  final Widget pagina;
  
  TransicionFadeScale({required this.pagina})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => pagina,
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            
            // Scale desde 0.95 a 1.0
            final scaleAnimation = Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(curvedAnimation);
            
            // Fade
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation);
            
            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            );
          },
        );
}

/// Transición con slide desde abajo (para modales)
class TransicionSlideUp extends PageRouteBuilder {
  final Widget pagina;
  
  TransicionSlideUp({required this.pagina})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => pagina,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            
            // Slide desde abajo
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0.0, 0.3),
              end: Offset.zero,
            ).animate(curvedAnimation);
            
            // Fade
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation);
            
            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );
}
