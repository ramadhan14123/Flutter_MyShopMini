import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class ProfileMenuCard extends StatelessWidget {
  final List<ProfileMenuItem> items;

  const ProfileMenuCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceBase,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceMuted.withOpacity(0.5),
          width: 0.8,
        ),
      ),
      child: Column(
        children: List.generate(
          items.length * 2 - 1,
          (index) {
            if (index.isOdd) {
              return const Divider(height: 1, color: AppColors.surfaceMuted);
            }
            final itemIndex = index ~/ 2;
            return _buildMenuItem(items[itemIndex]);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(ProfileMenuItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: AppColors.accentBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
