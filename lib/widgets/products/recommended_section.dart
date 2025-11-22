import 'package:flutter/material.dart';
import 'package:my_minishop/core/theme/app_colors.dart';
import 'package:my_minishop/core/theme/spacing/app_spacing.dart';
import 'package:my_minishop/core/theme/typography/app_typography.dart';
import 'package:my_minishop/widgets/products/product_models.dart';
import 'package:my_minishop/widgets/products/product_card.dart';

class RecommendedSection extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const RecommendedSection({super.key, this.title = 'Recommended For You', this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HotProduct>>(
      future: RecommendedRepository().load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _skeleton();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surfaceBase,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.surfaceMuted, width: 0.8),
            ),
            child: Text('Gagal memuat rekomendasi', style: AppTypography.bodyMedium.copyWith(color: Colors.red.shade300)),
          );
        }
        final items = snapshot.data!;
        return Container(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(title, style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary)),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onViewAll,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('View All', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) => HotProductCard(product: items[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _skeleton() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceBase,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceMuted, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16, width: 180, color: AppColors.surfaceElevated),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => Container(
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
