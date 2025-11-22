import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import 'product_models.dart';
import '../../data/products/product_models.dart' as catalog;
import 'product_card.dart';
import '../../screens/product_detail_screen.dart';

class HotSellingSection extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const HotSellingSection({super.key, this.title = 'Hot Selling Footwear', this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HotProduct>>(
      future: HotSellingRepository().load(),
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
            child: Text('Gagal memuat produk', style: AppTypography.bodyMedium.copyWith(color: Colors.red.shade300)),
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
                  itemBuilder: (context, index) => HotProductCard(
                    product: items[index],
                    onTap: () => _openDetail(context, items[index]),
                  ),
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
          Container(height: 16, width: 160, color: AppColors.surfaceElevated),
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

  Future<void> _openDetail(BuildContext context, HotProduct hp) async {
    final repo = catalog.ProductRepository();
    final products = await repo.loadAll();
    final match = products.firstWhere(
      (p) => p.id == hp.id,
      orElse: () => products.first,
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product: match)));
  }
}
