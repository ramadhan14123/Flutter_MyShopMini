import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import '../../core/responsive/responsive.dart';

class AnimatedSearchField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClose;
  final String hint;
  final double? expandedWidth; 
  const AnimatedSearchField({
    super.key,
    this.onChanged,
    this.onClose,
    this.hint = 'Cari produk...',
    this.expandedWidth,
  });

  @override
  State<AnimatedSearchField> createState() => _AnimatedSearchFieldState();
}

class _AnimatedSearchFieldState extends State<AnimatedSearchField> {
  bool _expanded = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      // Fokus saat expand
      Future.delayed(const Duration(milliseconds: 150), () => _focusNode.requestFocus());
    } else {
      _controller.clear();
      widget.onClose?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final targetWidth = widget.expandedWidth ?? Responsive.searchFieldWidth(context);
    const iconBoxWidth = 40.0;
    const gap = AppSpacing.sm;

    // Total outer width = icon area + (gap + fieldWidth when expanded)
    final outerWidth = _expanded ? (iconBoxWidth + gap + targetWidth) : iconBoxWidth;

    return SizedBox(
      width: outerWidth,
      height: 40,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            right: iconBoxWidth + gap, 
            width: _expanded ? targetWidth : 0,
            height: 40,
            child: ClipRect(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: _expanded ? 1 : 0,
                child: _expanded
                    ? _FieldShell(
                        controller: _controller,
                        focusNode: _focusNode,
                        hint: widget.hint,
                        onChanged: widget.onChanged,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              tooltip: _expanded ? 'Tutup' : 'Search',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: iconBoxWidth, minHeight: 40),
              onPressed: _toggle,
              icon: Icon(
                _expanded ? Icons.close : Icons.search,
                color: AppColors.textPrimary,
                size: AppSpacing.iconMd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldShell extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final ValueChanged<String>? onChanged;
  const _FieldShell({
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceBase,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.surfaceMuted, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
        cursorColor: AppColors.accentPink,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
