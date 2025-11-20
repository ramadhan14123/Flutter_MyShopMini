import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool expanded;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
        : Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600));
    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      child: child,
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
