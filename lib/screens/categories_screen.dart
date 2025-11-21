import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/typography/app_typography.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'Categories',
        titleOnRight: false,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ListView(
            children: [
              Text(
                'Jelajahi Kategori',
                style: AppTypography.headingLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              // Placeholder untuk grid kategori
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceBase,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('Category'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
