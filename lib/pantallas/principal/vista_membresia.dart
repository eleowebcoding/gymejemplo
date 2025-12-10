import 'package:flutter/material.dart';
import 'constantes.dart';

class VistaMembresia extends StatefulWidget {
  final bool membresiaActiva;
  final Function(bool) onMembresiaChanged;

  const VistaMembresia({super.key, required this.membresiaActiva, required this.onMembresiaChanged});

  @override
  State<VistaMembresia> createState() => _EstadoVistaMembresia();
}

class _EstadoVistaMembresia extends State<VistaMembresia> {
  bool _procesandoPago = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Membresía', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: Colors.white)),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Gestiona tu suscripción', style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.6))),
            ),
            const SizedBox(height: 28),
            _construirCardMembresia(),
            const SizedBox(height: 24),
            _construirMetodoPago(),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Planes disponibles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
            const SizedBox(height: 16),
            _construirPlanItem('Mensual', '\$499', '/mes', false),
            _construirPlanItem('Anual', '\$4,499', '/año', true, ahorro: 'Ahorra \$1,489'),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Historial de pagos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
            const SizedBox(height: 16),
            _construirPagoItem('Dic 2025', '\$499 MXN', 'Completado', 'pi_3Ox...'),
            _construirPagoItem('Nov 2025', '\$499 MXN', 'Completado', 'pi_3Nw...'),
            _construirPagoItem('Oct 2025', '\$499 MXN', 'Completado', 'pi_3Mv...'),
            const SizedBox(height: 40),
            if (widget.membresiaActiva) _construirBotonCancelar(),
            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }


  Widget _construirCardMembresia() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.membresiaActiva ? [AppColores.verdeAcento, AppColores.verdeAcento.withValues(alpha: 0.7)] : [Colors.grey, Colors.grey.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.workspace_premium, color: Colors.black, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Plan Premium', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black)),
                        Text(widget.membresiaActiva ? 'ACTIVA' : 'INACTIVA', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black54, letterSpacing: 1)),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(Icons.lock, size: 14, color: Colors.black.withValues(alpha: 0.7)),
                      const SizedBox(width: 4),
                      Text('Stripe', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Próximo cobro', style: TextStyle(fontSize: 14, color: Colors.black87)),
                      Text(widget.membresiaActiva ? '15 Ene 2026' : '—', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Monto', style: TextStyle(fontSize: 14, color: Colors.black87)),
                      Text('\$499 MXN', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
            if (!widget.membresiaActiva) ...[
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _mostrarPagoStripe,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('Reactivar membresía', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white))),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _construirMetodoPago() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF1A1F71), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.credit_card, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•••• •••• •••• 4242', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('Visa · Expira 12/26', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: const Text('Cambiar', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirPlanItem(String nombre, String precio, String periodo, bool recomendado, {String? ahorro}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: GestureDetector(
        onTap: _mostrarPagoStripe,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: recomendado ? AppColores.verdeAcento : Colors.white.withValues(alpha: 0.1), width: recomendado ? 2 : 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(nombre, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
                        if (recomendado) ...[
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: AppColores.verdeAcento, borderRadius: BorderRadius.circular(6)),
                            child: const Text('POPULAR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black)),
                          ),
                        ],
                      ],
                    ),
                    if (ahorro != null) ...[
                      const SizedBox(height: 4),
                      Text(ahorro, style: const TextStyle(fontSize: 13, color: AppColores.verdeAcento)),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(precio, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text(periodo, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirPagoItem(String fecha, String monto, String estado, String idPago) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColores.verdeAcento.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.check, color: AppColores.verdeAcento, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fecha, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(idPago, style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.4), fontFamily: 'monospace')),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(monto, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                Text(estado, style: const TextStyle(fontSize: 11, color: AppColores.verdeAcento)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirBotonCancelar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _mostrarConfirmacionCancelar,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          ),
          child: const Center(child: Text('Cancelar suscripción', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red))),
        ),
      ),
    );
  }


  void _mostrarPagoStripe() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(color: AppColores.fondoCard, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: StatefulBuilder(
          builder: (context, setModalState) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)))),
                const SizedBox(height: 24),
                const Row(children: [Icon(Icons.lock, color: Colors.white54, size: 20), SizedBox(width: 8), Text('Pago seguro con Stripe', style: TextStyle(fontSize: 14, color: Colors.white54))]),
                const SizedBox(height: 20),
                const Text('Confirmar pago', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    children: [
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Plan Premium Mensual', style: TextStyle(fontSize: 15, color: Colors.white)), Text('\$499.00', style: TextStyle(fontSize: 15, color: Colors.white))]),
                      const SizedBox(height: 12),
                      Divider(color: Colors.white.withValues(alpha: 0.1)),
                      const SizedBox(height: 12),
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)), Text('\$499.00 MXN', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white))]),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1A1F71), borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.credit_card, color: Colors.white, size: 18)),
                      const SizedBox(width: 12),
                      const Text('•••• 4242', style: TextStyle(fontSize: 15, color: Colors.white)),
                      const Spacer(),
                      const Icon(Icons.check_circle, color: AppColores.verdeAcento, size: 22),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _procesandoPago ? null : () async {
                    setModalState(() => _procesandoPago = true);
                    await Future.delayed(const Duration(seconds: 2));
                    setModalState(() => _procesandoPago = false);
                    if (mounted) {
                      Navigator.pop(context);
                      widget.onMembresiaChanged(true);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('¡Pago exitoso! Tu membresía está activa.'), backgroundColor: AppColores.verdeAcento, behavior: SnackBarBehavior.floating));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(color: AppColores.verdeAcento, borderRadius: BorderRadius.circular(14)),
                    child: Center(
                      child: _procesandoPago
                          ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black))
                          : const Text('Pagar \$499.00 MXN', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarConfirmacionCancelar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(color: AppColores.fondoCard, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.15), shape: BoxShape.circle), child: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32)),
              const SizedBox(height: 20),
              const Text('¿Cancelar suscripción?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 12),
              Text('Perderás acceso a todas las rutinas y programas premium al finalizar tu período actual.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.6), height: 1.5)),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('Mantener', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onMembresiaChanged(false);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Suscripción cancelada'), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating));
                      },
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('Cancelar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
