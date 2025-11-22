import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/typography/app_typography.dart';
import '../core/theme/icons/app_icons.dart';
import '../data/products/product_models.dart';
import '../widgets/product_detail/product_image_hero.dart';
import '../widgets/product_detail/product_info_panel.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CarouselSliderController _carousel = CarouselSliderController();
  int _current = 0;
  String _selectedSize = 'M';

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceBase,
        border: Border(
          top: BorderSide(color: AppColors.surfaceMuted, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Add to Cart Button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.name} added to cart'),
                      backgroundColor: AppColors.accentBlue,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(AppIcons.bag, size: 20),
                label: Text(
                  'Add to Cart',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.accentBlue, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Buy Now Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Proceeding to checkout for ${widget.product.name}'),
                      backgroundColor: AppColors.accentPink,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout_rounded, size: 20),
                label: Text(
                  'Buy Now',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentPink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images.isNotEmpty ? widget.product.images : [widget.product.thumbnail];
    final screenH = MediaQuery.of(context).size.height;
    final heroH = screenH * 0.62;

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageHero(
              height: heroH,
              images: images,
              current: _current,
              onChanged: (i) => setState(() => _current = i),
              carousel: _carousel,
              onBack: () => Navigator.of(context).pop(),
            ),
            ProductInfoPanel(
              product: widget.product,
              images: images,
              currentImage: _current,
              selectedSize: _selectedSize,
              onImageTap: (i) => _carousel.animateToPage(i),
              onSizeSelect: (size) => setState(() => _selectedSize = size),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
}

