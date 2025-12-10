import 'dart:ui';
import 'package:flutter/material.dart';
import 'constantes.dart';

class VistaProgreso extends StatelessWidget {
  const VistaProgreso({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: topPadding + 56, bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Resumen semanal
              _construirResumenSemanal(),
              const SizedBox(height: 28),
              // Stats principales
              _construirStats(),
              const SizedBox(height: 28),
              // Actividad reciente
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('ESTA SEMANA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white54, letterSpacing: 1)),
              ),
              const SizedBox(height: 14),
              _construirDiasSemana(),
              const SizedBox(height: 28),
              // Historial
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('HISTORIAL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white54, letterSpacing: 1)),
              ),
              const SizedBox(height: 14),
              _construirHistorialItem('Hoy', 'Full Body', '45 min'),
              _construirHistorialItem('Ayer', 'Upper Body', '35 min'),
              _construirHistorialItem('Lun', 'Leg Day', '40 min'),
              _construirHistorialItem('Dom', 'Core Blast', '25 min'),
              _construirHistorialItem('Sáb', 'HIIT Cardio', '30 min'),
            ],
          ),
        ),
        // Header blur
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: EdgeInsets.only(top: topPadding + 14, bottom: 14),
                decoration: BoxDecoration(
                  color: AppColores.fondoOscuro.withValues(alpha: 0.85),
                  border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('PALACE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 3)),
                    SizedBox(width: 4),
                    Text('FITNESS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColores.verdeAcento, letterSpacing: 3)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _construirResumenSemanal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColores.verdeAcento, AppColores.verdeAcento.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Esta semana', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
            const SizedBox(height: 8),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('5', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: Colors.black, height: 1)),
                SizedBox(width: 8),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('entrenamientos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
              child: const Text('🔥 Racha de 12 días', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _statCard('3h 25m', 'Tiempo total')),
          const SizedBox(width: 12),
          Expanded(child: _statCard('1,840', 'Calorías')),
          const SizedBox(width: 12),
          Expanded(child: _statCard('28', 'Ejercicios')),
        ],
      ),
    );
  }

  Widget _statCard(String valor, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(valor, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5))),
        ],
      ),
    );
  }

  Widget _construirDiasSemana() {
    final dias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    final completados = [true, true, false, true, true, true, false];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final completado = completados[index];
          return Column(
            children: [
              Text(dias[index], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white.withValues(alpha: 0.5))),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: completado ? AppColores.verdeAcento : Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: completado 
                  ? const Icon(Icons.check, color: Colors.black, size: 18)
                  : null,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _construirHistorialItem(String dia, String rutina, String duracion) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColores.verdeAcento.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check, color: AppColores.verdeAcento, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rutina, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 2),
                Text(dia, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
              ],
            ),
          ),
          Text(duracion, style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
