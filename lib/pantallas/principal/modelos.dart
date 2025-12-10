import 'package:flutter/material.dart';

class Programa {
  final String imagen;
  final String titulo;
  final String coach;
  final String nivel;
  final String semanas;
  final String frecuencia;
  final String descripcion;
  final Color colorAccent;

  Programa({
    required this.imagen,
    required this.titulo,
    required this.coach,
    required this.nivel,
    required this.semanas,
    required this.frecuencia,
    required this.descripcion,
    required this.colorAccent,
  });
}

class OpcionPerfil {
  final IconData icono;
  final String texto;
  OpcionPerfil(this.icono, this.texto);
}
