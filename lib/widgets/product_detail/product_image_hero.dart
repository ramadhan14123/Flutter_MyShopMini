import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/icons/app_icons.dart';
import '../header/app_header.dart';
import 'circle_icon_button.dart';

class ProductImageHero extends StatelessWidget {
  final double height;
  final List<String> images;
  final int current;
  final ValueChanged<int> onChanged;
  final CarouselSliderController carousel;
  final VoidCallback onBack;

  const ProductImageHero({
    super.key,
    required this.height,
    required this.images,
    required this.current,
    required this.onChanged,
    required this.carousel,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient untuk depth
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  AppColors.surfaceElevated,
                  AppColors.backgroundDeep,
                  AppColors.backgroundMain,
                ],
              ),
            ),
          ),
          CarouselSlider.builder(
            carouselController: carousel,
            itemCount: images.length,
            options: CarouselOptions(
              height: height,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enlargeFactor: 0,
              enableInfiniteScroll: images.length > 1,
              onPageChanged: (i, _) => onChanged(i),
              autoPlay: false,
            ),
            itemBuilder: (context, index, realIdx) {
              final url = images[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentPink.withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                      spreadRadius: -5,
                    ),
                    BoxShadow(
                      color: AppColors.accentBlue.withOpacity(0.10),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                      spreadRadius: -8,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceBase,
                      border: Border.all(
                        color: AppColors.surfaceMuted.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Main product image as full background
                        Positioned.fill(
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.surfaceBase,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: AppColors.textSecondary,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Subtle vignette for depth
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 1.2,
                                colors: [
                                  Colors.transparent,
                                  AppColors.backgroundMain.withOpacity(0.15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Header overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppHeader(
              title: '',
              customTitle: const SizedBox.shrink(),
              splitActions: true,
              includeStatusBar: true,
              backgroundColor: Colors.transparent,
              bottomBorder: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 10),
              leftActions: [
                CircleIconButton(icon: Icons.arrow_back_ios_new, onTap: onBack),
              ],
              rightActions: [
                CircleIconButton(icon: AppIcons.heart, onTap: () {}),
                CircleIconButton(icon: AppIcons.share, onTap: () {}),
                CircleIconButton(icon: AppIcons.bag, onTap: () {}),
              ],
              height: 56,
            ),
          ),

          // Dot indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < images.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: current == i ? 18 : 6,
                    decoration: BoxDecoration(
                      color: current == i ? AppColors.accentBlue : AppColors.textSecondary.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
