import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../widgets/header/animated_search_field.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'Home',
        titleOnRight: false,
        customTitle: const CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.accentBlue,
          child: Icon(Icons.person, color: Colors.white),
        ),
        leftActions: [
          AnimatedSearchField(
            onChanged: (value) {
            },
            onClose: () {
            },
          ),
          IconButton(
            tooltip: 'Keranjang',
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ListView(
          children: const [
            SizedBox(height: AppSpacing.lg),
            Text(
              'Beranda MiniShop',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Konten awal nanti meliputi banner promo, kategori, dan produk populer.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
