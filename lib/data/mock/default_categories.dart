import '../../core/theme/app_colors.dart';
import '../../core/theme/icons/app_icons.dart';
import '../../widgets/category/category_scroller.dart';

/// Factory function rather than static final to allow hot reload picking changes.
List<CategoryData> defaultCategories() => <CategoryData>[
  CategoryData('Fashion', AppIcons.fashion, AppColors.accentPink),
  CategoryData('Electronics', AppIcons.electronics, AppColors.accentOrange),
  CategoryData('Appliances', AppIcons.appliances, AppColors.accentBlue),
  CategoryData('Beauty', AppIcons.beauty, AppColors.accentPink),
  CategoryData('Furniture', AppIcons.furniture, AppColors.accentOrange),
  CategoryData('Sports', AppIcons.sports, AppColors.accentBlue),
];
