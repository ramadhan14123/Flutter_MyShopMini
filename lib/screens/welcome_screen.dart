import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/typography/app_typography.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../widgets/welcome/button.dart';
import '../widgets/welcome/animated_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackgroundShapes(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: AppSpacing.xl),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MyShopMini',
                        style: AppTypography.displayLarge.copyWith(
                          color: AppColors.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      
                      Text(
                        'Modern E-Commerce Experience',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Bottom button
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                  child: WelcomeButton(
                    label: 'Get Started',
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/main');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
