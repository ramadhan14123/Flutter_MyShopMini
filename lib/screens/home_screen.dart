import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../widgets/header/animated_search_field.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/icons/app_icons.dart';
import '../widgets/category/category_scroller.dart';
import '../data/mock/default_categories.dart';
import '../widgets/carousel/promo_carousel.dart';
import '../widgets/deals/deal_of_day_section.dart';
import 'package:my_minishop/widgets/products/hot_selling_section.dart';
import 'package:my_minishop/widgets/products/recommended_section.dart';

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
          child: Icon(AppIcons.user, color: Colors.white, size: 18),
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
            icon: const Icon(AppIcons.cart, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ListView(
            children: [
              CategoryScroller(categories: defaultCategories(), onViewAll: () {}),
              //Carousel
              const SizedBox(height: AppSpacing.sm),
              const PromoBannerCarousel(),
              //Deal of the Day
              const SizedBox(height: AppSpacing.xl),
              DealOfDaySection(
                endTime: DateTime.now().add(const Duration(hours: 11, minutes: 15, seconds: 4)),
                onViewAll: () {},
              ),
              //Hot Selling & Recommended
              const SizedBox(height: AppSpacing.xl),
              const HotSellingSection(),
              const SizedBox(height: AppSpacing.xl),
              const RecommendedSection(),
            ],
          ),
        ),
      ),
    );
  }
}
