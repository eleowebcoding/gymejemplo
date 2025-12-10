// ============================================
// PALACE FITNESS - Pantalla de Login
// ============================================
// Formulario limpio con fondo blur profundo
// Conecta con: pantalla_bienvenida.dart, pantalla_registro.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../componentes/transiciones.dart';
import '../principal/pantalla_home.dart';
import 'pantalla_registro.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _EstadoPantallaLogin();
}

class _EstadoPantallaLogin extends State<PantallaLogin> {
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  bool _ocultarContrasena = true;
  bool _cargando = false;

  static const _verdeAcento = Color(0xFF4ADE80);

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    setState(() => _cargando = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _cargando = false);
      Navigator.pushAndRemoveUntil(
        context,
        TransicionFadeScale(pagina: const PantallaHome()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con blur muy profundo
          _construirFondo(),
          
          // Contenido
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _construirAppBar(),
                    const SizedBox(height: 60),
                    _construirEncabezado(),
                    const SizedBox(height: 50),
                    _construirFormulario(),
                    const SizedBox(height: 40),
                    _construirLinkRegistro(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirFondo() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        Image.network(
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=900&q=80',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(color: const Color(0xFF0A0A0A));
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(color: const Color(0xFF0A0A0A));
          },
        ),
        // Blur muy profundo
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(color: Colors.transparent),
        ),
        // Overlay oscuro (menos intenso para ver más la imagen)
        Container(color: Colors.black.withValues(alpha: 0.7)),
      ],
    );
  }

  Widget _construirAppBar() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
    );
  }

  Widget _construirEncabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hola de nuevo',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.5),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _construirFormulario() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label correo
        _construirLabel('Correo electrónico'),
        const SizedBox(height: 10),
        _construirCampo(
          controlador: _correoController,
          hint: 'ejemplo@correo.com',
          teclado: TextInputType.emailAddress,
        ),
        
        const SizedBox(height: 24),
        
        // Label contraseña
        _construirLabel('Contraseña'),
        const SizedBox(height: 10),
        _construirCampoContrasena(),
        
        const SizedBox(height: 16),
        
        // Olvidé contraseña
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(
                fontSize: 14,
                color: _verdeAcento,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Botón
        _construirBoton(),
      ],
    );
  }

  Widget _construirLabel(String texto) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _construirCampo({
    required TextEditingController controlador,
    required String hint,
    TextInputType? teclado,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controlador,
        keyboardType: teclado,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: _verdeAcento,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.25)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
    );
  }

  Widget _construirCampoContrasena() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _contrasenaController,
        obscureText: _ocultarContrasena,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: _verdeAcento,
        decoration: InputDecoration(
          hintText: '••••••••',
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.25)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _ocultarContrasena = !_ocultarContrasena),
            child: Icon(
              _ocultarContrasena ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.white.withValues(alpha: 0.3),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _construirBoton() {
    return GestureDetector(
      onTap: _cargando ? null : _iniciarSesion,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 17),
        decoration: BoxDecoration(
          color: _verdeAcento,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: _cargando
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black),
                )
              : const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                ),
        ),
      ),
    );
  }

  Widget _construirLinkRegistro() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta? ',
          style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.5)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            TransicionSlide(pagina: const PantallaRegistro()),
          ),
          child: Text(
            'Regístrate',
            style: TextStyle(fontSize: 15, color: _verdeAcento, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
