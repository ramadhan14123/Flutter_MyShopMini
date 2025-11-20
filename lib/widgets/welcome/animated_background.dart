import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AnimatedBackgroundShapes extends StatefulWidget {
  final Widget child;

  const AnimatedBackgroundShapes({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackgroundShapes> createState() =>
      _AnimatedBackgroundShapesState();
}

class _AnimatedBackgroundShapesState extends State<AnimatedBackgroundShapes>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _controller2 = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();
    _controller3 = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient background
        Container(
          decoration: BoxDecoration(gradient: AppGradients.hero),
        ),
        // Floating animated orbs
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return Positioned(
              top: -50 + (MediaQuery.of(context).size.height * 0.2 * _controller1.value),
              right: -50,
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.accentPink.withAlpha(77),
                        AppColors.accentPink.withAlpha(0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        // Second floating orb
        AnimatedBuilder(
          animation: _controller2,
          builder: (context, child) {
            return Positioned(
              bottom: -80 + (MediaQuery.of(context).size.height * 0.25 * _controller2.value),
              left: -60,
              child: Opacity(
                opacity: 0.08,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.accentOrange.withAlpha(77),
                        AppColors.accentOrange.withAlpha(0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        // Third floating orb
        AnimatedBuilder(
          animation: _controller3,
          builder: (context, child) {
            return Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              right: -100 + (MediaQuery.of(context).size.width * 0.2 * _controller3.value),
              child: Opacity(
                opacity: 0.06,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.accentBlue.withAlpha(51),
                        AppColors.accentBlue.withAlpha(0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        // Content on top
        widget.child,
      ],
    );
  }
}
