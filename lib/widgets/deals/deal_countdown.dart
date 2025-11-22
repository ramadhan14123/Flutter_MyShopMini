import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';

class DealCountdown extends StatefulWidget {
  final DateTime endTime;
  final TextStyle? numberStyle;
  final TextStyle? labelStyle;
  final bool accent; 
  final bool autoAccent; 
  final int accentThresholdMinutes; 
  final bool stagedAccent; 
  final bool pulseOnAccent; 

  const DealCountdown({
    super.key,
    required this.endTime,
    this.numberStyle,
    this.labelStyle,
    this.accent = false,
    this.autoAccent = true,
    this.accentThresholdMinutes = 10,
    this.stagedAccent = true,
    this.pulseOnAccent = true,
  });

  factory DealCountdown.quickDemo({Key? key}) {
    return DealCountdown(
      key: key,
      endTime: DateTime.now().add(const Duration(seconds: 10)),
      autoAccent: true,
      accentThresholdMinutes: 1,
    );
  }

  @override
  State<DealCountdown> createState() => _DealCountdownState();
}

class _DealCountdownState extends State<DealCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calc();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calc());
  }

  void _calc() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.endTime.isAfter(now) ? widget.endTime.difference(now) : Duration.zero;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remaining.inHours;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    final numStyle = widget.numberStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
    final labStyle = widget.labelStyle ?? const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white70);

    List<_TimeBlock> blocks = [
      _TimeBlock(value: hours, label: 'HRS'),
      _TimeBlock(value: minutes, label: 'MIN'),
      _TimeBlock(value: seconds, label: 'SEC'),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < blocks.length; i++) ...[
          _buildBlock(blocks[i], numStyle, labStyle),
          if (i != blocks.length - 1) const SizedBox(width: AppSpacing.sm),
        ]
      ],
    );
  }

  Widget _buildBlock(_TimeBlock b, TextStyle numStyle, TextStyle labStyle) {
    final minsLeft = _remaining.inMinutes;
    final bool accentActive = widget.accent || (widget.autoAccent && minsLeft <= widget.accentThresholdMinutes);
    final bool preAccentStage = !accentActive && widget.autoAccent && widget.stagedAccent && minsLeft <= widget.accentThresholdMinutes * 2;

    final Gradient gradient = accentActive
        ? AppGradients.buttonCta
        : preAccentStage
            ? LinearGradient(
                colors: [AppColors.accentBlue, AppColors.accentPink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  AppColors.backgroundSubtle,
                  AppColors.surfaceElevated,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );

    final int seconds = _remaining.inSeconds % 60;
    final double scale = (accentActive && widget.pulseOnAccent)
      ? (seconds % 2 == 0 ? 1.05 : 1.0)
      : 1.0;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: accentActive
                ? AppColors.accentOrange.withOpacity(0.7)
                : preAccentStage
                    ? AppColors.accentPink.withOpacity(0.5)
                    : AppColors.surfaceMuted,
            width: 0.9,
          ),
          boxShadow: accentActive
              ? [
                  BoxShadow(
                    color: AppColors.accentOrange.withOpacity(0.45),
                    blurRadius: 14,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : preAccentStage
                  ? [
                      BoxShadow(
                        color: AppColors.accentPink.withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(b.value.toString().padLeft(2, '0'), style: numStyle),
            Text(b.label, style: labStyle),
          ],
        ),
      ),
    );
  }
}

class _TimeBlock {
  final int value;
  final String label;
  _TimeBlock({required this.value, required this.label});
}
