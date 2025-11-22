import 'package:flutter/material.dart';
import 'category_tile.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';

class CategoryData {
  final String name;
  final IconData icon;
  final Color color;
  const CategoryData(this.name, this.icon, this.color);
}

class CategoryScroller extends StatelessWidget {
  final List<CategoryData> categories;
  final VoidCallback? onViewAll;
  final Function(String)? onCategoryTap;
  final EdgeInsetsGeometry padding;

  const CategoryScroller({
    super.key,
    required this.categories,
    this.onViewAll,
    this.onCategoryTap,
    this.padding = const EdgeInsets.symmetric(vertical: AppSpacing.md),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            children: [
              Text('Categories', style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary)),
              const Spacer(),
              InkWell(
                onTap: onViewAll,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                  child: Row(
                    children: [
                      Text('View All', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            itemBuilder: (context, index) {
              final c = categories[index];
              return CategoryTile(
                icon: c.icon,
                label: c.name,
                tint: c.color,
                onTap: () => onCategoryTap?.call(c.name),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }
}

