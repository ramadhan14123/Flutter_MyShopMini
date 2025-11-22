import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import '../../data/products/product_models.dart';
import 'size_chip.dart';
import 'variant_thumbnails.dart';
import 'product_details_list.dart';

class ProductInfoPanel extends StatelessWidget {
  final Product product;
  final List<String> images;
  final int currentImage;
  final String selectedSize;
  final Function(int) onImageTap;
  final Function(String) onSizeSelect;

  const ProductInfoPanel({
    super.key,
    required this.product,
    required this.images,
    required this.currentImage,
    required this.selectedSize,
    required this.onImageTap,
    required this.onSizeSelect,
  });

  @override
  Widget build(BuildContext context) {
    final brand = product.details['brand'] ?? product.name.split(' ').first;
    final color = product.details['color'] ?? 'White';
    final stock = product.details['stock'] ?? '5';
    final sizes = (product.details['sizes'] ?? '').split(',').where((s) => s.trim().isNotEmpty).toList();
    final discountPct = (product.oldPrice > product.price && product.oldPrice > 0)
        ? (((product.oldPrice - product.price) / product.oldPrice) * 100).round()
        : 0;
    
    // Hanya tampilkan size selector untuk kategori Fashion (pakaian & sepatu)
    final showSizeSelector = product.category == 'Fashion' && sizes.isNotEmpty && sizes.first.toLowerCase() != 'one size';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.surfaceBase,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Text(brand, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 6),

          // Product Name
          Text(product.name, style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary, height: 1.25)),
          const SizedBox(height: 12),

          // Rating and Price Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentOrange.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 14, color: AppColors.accentOrange),
                    const SizedBox(width: 4),
                    Text(product.rating.toStringAsFixed(1), style: AppTypography.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('${product.ratingCount} Reviews', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              const Spacer(),
              Text(_price(product.price), style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              if (discountPct > 0) ...[
                Text(_price(product.oldPrice), style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, decoration: TextDecoration.lineThrough)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.accentPink.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${discountPct}% OFF', style: AppTypography.caption.copyWith(color: AppColors.accentPink, fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 18),

          // Color and Stock
          Row(
            children: [
              Text('Color: $color', style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary)),
              const Spacer(),
              Text('Only $stock Left', style: AppTypography.bodySmall.copyWith(color: AppColors.accentPink, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),

          // Variant Thumbnails
          VariantThumbnails(
            images: images,
            current: currentImage,
            onTap: onImageTap,
          ),
          
          // Size Selection (hanya untuk Fashion)
          if (showSizeSelector) ...[
            const SizedBox(height: 22),
            Row(
              children: [
                Text('Size', style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Size Chart', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                )
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in sizes)
                  SizeChip(
                    label: s.trim(),
                    selected: selectedSize == s.trim(),
                    disabled: s.trim() == 'XXL',
                    onTap: () => onSizeSelect(s.trim()),
                  ),
              ],
            ),
          ],
          
          const SizedBox(height: 28),

          // Description
          Text('Description', style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(product.description, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.4)),

          // Details
          if (product.details.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Details', style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            ProductDetailsList(details: product.details),
          ],
        ],
      ),
    );
  }

  String _price(double v) {
    return v == v.roundToDouble() ? '\$${v.toInt()}' : '\$${v.toStringAsFixed(2)}';
  }
}
