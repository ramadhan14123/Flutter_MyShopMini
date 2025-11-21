import 'package:flutter/material.dart';
import '../core/navigation/bottom_nav_item.dart';
import '../core/theme/icons/app_icons.dart';
import '../widgets/navigation/app_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'categories_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

/// Main screen yang mengelola bottom navigation dan page switching
/// 
/// Struktur:
/// - Body: Menampilkan screen sesuai currentRoute
/// - Bottom Nav Bar: Navigation antara Home, Categories, Orders, Profile
class MainScreen extends StatefulWidget {
  /// Initial route (default: /home)
  final String initialRoute;

  const MainScreen({
    this.initialRoute = '/home',
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String _currentRoute;

  // Badge counts untuk notifikasi (contoh: keranjang)
  final Map<String, int> _badgeCounts = {
    '/home': 2,
    '/categories': 0,
    '/orders': 0,
    '/profile': 0,
  };

  // Define bottom navigation items
  late final List<BottomNavItem> _navItems;

  @override
  void initState() {
    super.initState();
    _currentRoute = widget.initialRoute;
    _initializeNavItems();
  }

  void _initializeNavItems() {
    _navItems = [
      BottomNavItem(
        icon: AppIcons.home,
        label: 'Home',
        route: '/home',
      ),
      BottomNavItem(
        icon: AppIcons.category,
        label: 'Categories',
        route: '/categories',
      ),
      BottomNavItem(
        icon: AppIcons.cart,
        label: 'Orders',
        route: '/orders',
      ),
      BottomNavItem(
        icon: AppIcons.user,
        label: 'Profile',
        route: '/profile',
      ),
    ];
  }

  /// Get screen widget berdasarkan route
  Widget _getScreen(String route) {
    switch (route) {
      case '/home':
        return const HomeScreen();
      case '/categories':
        return const CategoriesScreen();
      case '/orders':
        return const OrdersScreen();
      case '/profile':
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  /// Handle navigation saat bottom nav item di-tap
  void _handleNavigation(String route) {
    if (_currentRoute != route) {
      setState(() {
        _currentRoute = route;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_currentRoute),
      bottomNavigationBar: AppBottomNavBar(
        items: _navItems,
        currentRoute: _currentRoute,
        onNavigate: _handleNavigation,
        badgeCounts: _badgeCounts,
        borderRadius: 32,
        elevation: 16,
      ),
    );
  }
}
