import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import 'deal_models.dart';
import 'deal_countdown.dart';

class DealOfDaySection extends StatelessWidget {
  final DateTime endTime;
  final List<DealProduct>? products; // optional; if null load from assets
  final VoidCallback? onViewAll;

  const DealOfDaySection({
    super.key,
    required this.endTime,
    this.products,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isTablet = width >= 600 && width < 1024;
      final isDesktop = width >= 1024;
      int crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);
      
      // If products provided, build grid directly; else we'll branch to FutureBuilder later
      Widget buildContent(List<DealProduct> data) => Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceBase,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceMuted, width: 0.8),
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header ditata ulang: baris 1 judul + View All, baris 2 countdown
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Deal of the day',
                    style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary),
                  ),
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
            const SizedBox(height: AppSpacing.sm),
            DealCountdown(endTime: endTime),
            const SizedBox(height: AppSpacing.lg),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.72, // allow space for title + badge
              ),
              itemBuilder: (context, index) {
                final p = data[index];
                return _DealCard(product: p);
              },
            ),
          ],
        ),
      );
      
      // If products provided, use directly
      if (products != null) return buildContent(products!);
      return FutureBuilder<List<DealProduct>>(
        future: DealRepository().loadDeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceBase,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceMuted, width: 0.8),
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: const SizedBox(
                height: 140,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            );
          }
          if (snapshot.hasError || !(snapshot.hasData)) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceBase,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceMuted, width: 0.8),
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text('Gagal memuat deals', style: AppTypography.bodyMedium.copyWith(color: Colors.red.shade300)),
            );
          }
          final loaded = snapshot.data!;
          return buildContent(loaded);
        },
      );
    });
  }
}

class _DealCard extends StatelessWidget {
  final DealProduct product;

  const _DealCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: AppColors.surfaceElevated,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surfaceElevated,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined, color: AppColors.textSecondary, size: 30),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        _DiscountBadge(text: product.discountText, color: product.accentColor),
      ],
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _DiscountBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.55), width: 1),
      ),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(color: color, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      ),
    );
  }
}
