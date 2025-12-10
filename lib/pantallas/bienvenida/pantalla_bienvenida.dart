// ============================================
// PALACE FITNESS - Pantalla de Bienvenida
// ============================================
// Diseño premium con logo destacado
// Conecta con: pantalla_login.dart

import 'package:flutter/material.dart';
import '../../componentes/transiciones.dart';
import '../autenticacion/pantalla_login.dart';
import '../autenticacion/pantalla_registro.dart';

class PantallaBienvenida extends StatefulWidget {
  const PantallaBienvenida({super.key});

  @override
  State<PantallaBienvenida> createState() => _EstadoPantallaBienvenida();
}

class _EstadoPantallaBienvenida extends State<PantallaBienvenida>
    with SingleTickerProviderStateMixin {
  int _paginaActual = 0;
  
  // Animación para el texto
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  static const _verdeAcento = Color(0xFF4ADE80);

  final List<_Slide> _slides = [
    _Slide(
      imagen: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=900&q=80',
      titulo: 'Transforma tu cuerpo',
      subtitulo: 'Entrenamientos personalizados que se adaptan a tus metas y estilo de vida.',
    ),
    _Slide(
      imagen: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=900&q=80',
      titulo: 'Supera tus límites',
      subtitulo: 'Cada día es una oportunidad para ser más fuerte que ayer.',
    ),
    _Slide(
      imagen: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=900&q=80',
      titulo: 'Únete a la comunidad',
      subtitulo: 'Miles de personas ya están logrando sus objetivos con nosotros.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _animController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    
    _animController.forward();
    _iniciarAutoPlay();
  }
  
  void _iniciarAutoPlay() {
    Future.delayed(const Duration(seconds: 20), () {
      if (mounted) {
        _siguienteSlide();
        _iniciarAutoPlay();
      }
    });
  }
  
  void _siguienteSlide() {
    setState(() {
      _paginaActual = (_paginaActual + 1) % _slides.length;
    });
    _animController.forward(from: 0);
  }
  
  void _anteriorSlide() {
    setState(() {
      _paginaActual = (_paginaActual - 1 + _slides.length) % _slides.length;
    });
    _animController.forward(from: 0);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _manejarSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! < -50) {
      _siguienteSlide();
    } else if (details.primaryVelocity! > 50) {
      _anteriorSlide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Imágenes de fondo
          _construirFondo(),
          
          // Gradiente oscuro inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black,
                    Colors.black,
                  ],
                  stops: const [0.0, 0.3, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // Zona de swipe - toda la pantalla excepto botones
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 120, // Deja espacio para los botones
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: _manejarSwipe,
            ),
          ),
          
          // Contenido
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Logo PALACE FITNESS destacado
                _construirLogoDestacado(),
                
                const Spacer(),
                
                // Contenido del slide con animación
                _construirContenidoAnimado(),
                
                const SizedBox(height: 24),
                
                // Indicadores
                _construirIndicadores(),
                
                const SizedBox(height: 40),
                
                // Botones
                _construirBotones(),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirFondo() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
      child: Stack(
        key: ValueKey<int>(_paginaActual),
        fit: StackFit.expand,
        children: [
          Image.network(
            _slides[_paginaActual].imagen,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const ColoredBox(color: Color(0xFF111111));
            },
            errorBuilder: (context, error, stackTrace) {
              return const ColoredBox(color: Color(0xFF111111));
            },
          ),
          const ColoredBox(color: Color(0x66000000)),
        ],
      ),
    );
  }

  Widget _construirLogoDestacado() {
    return Column(
      children: [
        // PALACE - grande y bold
        Text(
          'PALACE',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 12,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        
        // FITNESS - verde y bold
        Text(
          'FITNESS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _verdeAcento,
            letterSpacing: 10,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _construirContenidoAnimado() {
    final slide = _slides[_paginaActual];
    return FadeTransition(
      opacity: _fadeAnim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(
              slide.titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              slide.subtitulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.6),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _construirIndicadores() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_slides.length, (i) {
        final activo = i == _paginaActual;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: activo ? 28 : 8,
          height: 4,
          decoration: BoxDecoration(
            color: activo ? _verdeAcento : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget _construirBotones() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        children: [
          // Botón Iniciar sesión
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context, TransicionFadeScale(pagina: const PantallaLogin())),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Botón Registrarse
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context, TransicionFadeScale(pagina: const PantallaRegistro())),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _verdeAcento,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide {
  final String imagen;
  final String titulo;
  final String subtitulo;
  _Slide({required this.imagen, required this.titulo, required this.subtitulo});
}
