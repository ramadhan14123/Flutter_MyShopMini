import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../widgets/orders/empty_orders_state.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/icons/app_icons.dart';

class OrdersScreen extends StatelessWidget {
  final VoidCallback? onNavigateToHome;
  
  const OrdersScreen({super.key, this.onNavigateToHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'My Orders',
        titleOnRight: false,
        rightActions: [
          IconButton(
            icon: const Icon(AppIcons.filter, color: AppColors.textPrimary),
            tooltip: 'Filter Orders',
            onPressed: () {
              // TODO: Implement order filters
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: EmptyOrdersState(onStartShopping: onNavigateToHome),
      ),
    );
  }
}
