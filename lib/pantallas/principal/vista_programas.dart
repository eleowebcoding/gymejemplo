import 'dart:ui';
import 'package:flutter/material.dart';
import 'constantes.dart';
import 'modelos.dart';

class VistaProgramas extends StatelessWidget {
  final List<Programa> programas;

  const VistaProgramas({super.key, required this.programas});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: topPadding + 56, bottom: 120),
          itemCount: programas.length,
          itemBuilder: (context, index) {
            return _construirCardPrograma(programas[index], index == 0);
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _construirHeaderBlur(topPadding),
        ),
      ],
    );
  }

  Widget _construirHeaderBlur(double topPadding) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(top: topPadding + 14, bottom: 14),
          decoration: BoxDecoration(
            color: AppColores.fondoOscuro.withValues(alpha: 0.85),
            border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('PALACE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 3)),
              const SizedBox(width: 4),
              Text('FITNESS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColores.verdeAcento, letterSpacing: 3)),
            ],
          ),
        ),
      ),
    );
  }


  Widget _construirCardPrograma(Programa programa, bool esPrimero) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: esPrimero ? 1.2 : 1.5,
                child: Image.network(
                  programa.imagen,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(color: AppColores.fondoCard);
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Text(
                  programa.titulo,
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 0.95,
                    fontStyle: FontStyle.italic,
                    shadows: [Shadow(color: programa.colorAccent.withValues(alpha: 0.5), blurRadius: 30)],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: programa.colorAccent.withValues(alpha: 0.3), shape: BoxShape.circle),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(programa.coach, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(programa.nivel, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColores.verdeAcento)),
                Text('  •  ${programa.semanas}  •  ${programa.frecuencia}', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.7))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Text(programa.descripcion, style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6), height: 1.5)),
          ),
        ],
      ),
    );
  }
}
