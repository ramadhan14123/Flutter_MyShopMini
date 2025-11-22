import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class VariantThumbnails extends StatelessWidget {
  final List<String> images;
  final int current;
  final ValueChanged<int> onTap;

  const VariantThumbnails({
    super.key,
    required this.images,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: images.length,
        itemBuilder: (context, i) {
          final active = i == current;
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: active ? AppColors.accentPink : AppColors.surfaceMuted.withOpacity(0.4), width: active ? 1.8 : 1),
                color: AppColors.surfaceElevated,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    images[i],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: AppColors.surfaceElevated,
                      child: Center(child: Icon(Icons.image_not_supported_outlined, color: AppColors.textSecondary)),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
