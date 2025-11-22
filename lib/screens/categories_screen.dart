import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/typography/app_typography.dart';
import '../data/mock/default_categories.dart';
import '../data/products/product_models.dart';
import '../data/categories/subcategory_image_repository.dart';
import '../widgets/category/category_icon_button.dart';
import '../widgets/category/subcategory_card.dart';
import '../widgets/category/category_drawer.dart';
import '../screens/product_search_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCategory = 'Fashion';
  Map<String, List<String>> _subcategoriesMap = {};
  Map<String, String> _subcategoryImages = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final repo = ProductRepository();
    final products = await repo.loadAll();
    
    final imageRepo = SubcategoryImageRepository();
    final images = await imageRepo.loadAll();
    
    final Map<String, Set<String>> tempMap = {};
    for (var product in products) {
      if (!tempMap.containsKey(product.category)) {
        tempMap[product.category] = {};
      }
      if (product.subcategory.isNotEmpty) {
        tempMap[product.category]!.add(product.subcategory);
      }
    }
    
    setState(() {
      _subcategoriesMap = tempMap.map((key, value) => MapEntry(key, value.toList()..sort()));
      _subcategoryImages = images;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = defaultCategories();
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'Categories',
        titleOnRight: false,
        leftActions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      drawer: CategoryDrawer(
        categories: categories,
        onCategorySelected: (categoryName) {
          setState(() {
            _selectedCategory = categoryName;
          });
        },
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: Row(
          children: [
            // Left Sidebar - Category Icons
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceBase.withOpacity(0.6),
                border: Border(
                  right: BorderSide(color: AppColors.surfaceMuted, width: 1),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category.name;
                  return CategoryIconButton(
                    category: category,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category.name;
                      });
                    },
                  );
                },
              ),
            ),
            // Right Content - Subcategories
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildSubcategoryGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubcategoryGrid() {
    final subcategories = _subcategoriesMap[_selectedCategory] ?? [];
    final imageRepo = SubcategoryImageRepository();
    
    if (subcategories.isEmpty) {
      return Center(
        child: Text(
          'No subcategories available',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.2,
      ),
      itemCount: subcategories.length,
      itemBuilder: (context, index) {
        final subcategory = subcategories[index];
        final imageUrl = imageRepo.getImageUrl(subcategory, _subcategoryImages);
        
        return SubcategoryCard(
          subcategory: subcategory,
          imageUrl: imageUrl,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductSearchScreen(
                  initialQuery: '',
                  filterCategory: _selectedCategory,
                  filterSubcategory: subcategory,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
