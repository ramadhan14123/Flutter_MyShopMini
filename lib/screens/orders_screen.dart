import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/typography/app_typography.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'Orders',
        titleOnRight: false,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ListView(
            children: [
              Text(
                'Pesanan Anda',
                style: AppTypography.headingLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              // Placeholder untuk list pesanan
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceBase,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #1001'),
                      SizedBox(height: AppSpacing.xs),
                      Text('Status: Delivered'),
                    ],
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
