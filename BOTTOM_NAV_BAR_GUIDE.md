## 📱 AppBottomNavBar - Customizable Navigation Component

### Overview
`AppBottomNavBar` adalah komponen navigasi bottom bar yang fully customizable, reusable, dan maintainable dengan animasi elegant yang modern dan minimalis.

### Fitur Utama

✨ **Animasi Elegant**
- Icon scale-up animation saat aktif (ElasticOut curve - smooth & bouncy)
- Background color transition (300ms)
- Label opacity animation
- Smooth state transitions

🎨 **Design Modern**
- Dark theme dengan accent colors (Orange, Pink, Blue)
- Rounded corners top (customizable, default 24px)
- Shadow elevation untuk depth perception
- Minimalist icon design (Feather icons)

🔧 **Fully Customizable**
- Custom items per page
- Custom background color
- Custom border radius
- Custom elevation
- Custom padding
- Badge support untuk notifikasi

### Struktur Komponen

```
widgets/navigation/
├── bottom_nav_bar_item.dart      # Individual item dengan animasi
└── app_bottom_nav_bar.dart       # Main bar component

core/navigation/
└── bottom_nav_item.dart          # Model/Data class

screens/
├── main_screen.dart              # Wrapper yang manage navigation state
├── home_screen.dart              # Home page
├── categories_screen.dart        # Categories page
├── orders_screen.dart            # Orders page
└── profile_screen.dart           # Profile page
```

### Penggunaan

#### 1. Setup di MainScreen (Screen Manager)

```dart
class MainScreen extends StatefulWidget {
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
  
  // Badge counts untuk notifikasi
  final Map<String, int> _badgeCounts = {
    '/home': 2,
    '/categories': 0,
    '/orders': 0,
    '/profile': 0,
  };

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
```

#### 2. Define BottomNavItem

```dart
const BottomNavItem(
  icon: AppIcons.home,        // Icon dari AppIcons
  label: 'Home',              // Label text
  route: '/home',             // Internal route identifier
  badgeCount: 0,              // Optional: notifikasi
);
```

#### 3. Gunakan AppBottomNavBar

```dart
AppBottomNavBar(
  items: _navItems,                    // List<BottomNavItem>
  currentRoute: _currentRoute,         // String - route aktif
  onNavigate: _handleNavigation,       // Function(String route)
  badgeCounts: _badgeCounts,          // Map<String, int>? - update badge
  borderRadius: 32,                   // Double? - custom border radius
  elevation: 16,                      // Double? - shadow depth
  backgroundColor: Colors.transparent, // Color? - background
  padding: EdgeInsets.all(16),        // EdgeInsets? - custom padding
);
```

### Animasi Detail

#### BottomNavBarItem Animation
```dart
// 1. Scale Animation (Icon)
_scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
  CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
);

// 2. Opacity Animation (Icon)
_opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
  CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
);

// 3. Background Color (Container)
AnimatedContainer(
  duration: const Duration(milliseconds: 400),
  curve: Curves.easeInOut,
  // color transitions smoothly
);

// 4. Label Opacity
AnimatedOpacity(
  opacity: widget.isActive ? 1.0 : 0.7,
  duration: const Duration(milliseconds: 300),
  // opacity transitions
);
```

**Curves Used:**
- `Curves.elasticOut` → Icon scale (bouncy, elegant)
- `Curves.easeInOut` → Color & opacity transitions (smooth)

### Customization Examples

#### Example 1: Custom Per-Page Navigation

```dart
// Untuk Home screen dengan lebih banyak items
void _initializeNavItems() {
  _navItems = [
    BottomNavItem(icon: AppIcons.home, label: 'Home', route: '/home'),
    BottomNavItem(icon: AppIcons.search, label: 'Search', route: '/search'),
    BottomNavItem(icon: AppIcons.cart, label: 'Cart', route: '/cart'),
    BottomNavItem(icon: AppIcons.heart, label: 'Wishlist', route: '/wishlist'),
    BottomNavItem(icon: AppIcons.user, label: 'Profile', route: '/profile'),
  ];
}
```

#### Example 2: Badge Updates

```dart
// Update badge count dynamically
setState(() {
  _badgeCounts['/orders'] = 5; // Cart memiliki 5 items
});

// AppBottomNavBar akan otomatis re-render
```

#### Example 3: Custom Theme

```dart
AppBottomNavBar(
  items: _navItems,
  currentRoute: _currentRoute,
  onNavigate: _handleNavigation,
  backgroundColor: AppColors.accentPink.withValues(alpha: 0.1),
  borderRadius: 16,
  elevation: 24,
  padding: const EdgeInsets.all(AppSpacing.lg),
);
```

### File Locations

```
lib/
├── core/
│   ├── navigation/
│   │   ├── app_router.dart           # Updated with /main route
│   │   └── bottom_nav_item.dart      # NEW: Model class
│   └── theme/
│       └── icons/
│           └── app_icons.dart        # Updated: added home icon
│
├── screens/
│   ├── welcome_screen.dart           # Updated: navigate to /main
│   ├── main_screen.dart              # NEW: Navigation manager
│   ├── home_screen.dart              # Existing
│   ├── categories_screen.dart        # NEW: Categories page
│   ├── orders_screen.dart            # NEW: Orders page
│   └── profile_screen.dart           # NEW: Profile page
│
└── widgets/
    └── navigation/
        ├── bottom_nav_bar_item.dart  # NEW: Individual item
        └── app_bottom_nav_bar.dart   # NEW: Main bar
```

### Architecture Benefits

🏗️ **Clean Architecture**
- Separation of concerns (Item ↔ Bar ↔ MainScreen)
- Model-driven (BottomNavItem)
- Easy to extend

♻️ **Reusable**
- Item dapat digunakan standalone
- Bar sepenuhnya customizable
- Navigation logic terpisah

🧪 **Maintainable**
- Single responsibility per component
- Clear props/parameters
- Documentation integrated

🚀 **Scalable**
- Easy menambah item baru
- Easy customize per page
- Easy integrate dengan state management (Riverpod/Bloc)

### Best Practices

1. **Define Routes Centrally**
   ```dart
   // Gunakan constant untuk consistency
   static const String home = '/home';
   static const String categories = '/categories';
   ```

2. **Update Badge Safely**
   ```dart
   setState(() {
     _badgeCounts['/cart'] = itemCount;
   });
   ```

3. **Validate Route**
   ```dart
   void _handleNavigation(String route) {
     if (_currentRoute != route) {
       setState(() {
         _currentRoute = route;
       });
     }
   }
   ```

4. **Use Constants**
   ```dart
   const double borderRadius = 32;
   const double elevation = 16;
   const Duration animationDuration = Duration(milliseconds: 600);
   ```

### Future Enhancements

- [ ] Slide animation untuk perpindahan antar tab
- [ ] Custom animation duration
- [ ] Support untuk icon dengan filled variant
- [ ] State management integration (Riverpod/Bloc)
- [ ] Accessibility improvements (semantic labels)
- [ ] Custom indicator styles
- [ ] Animated label color transitions
- [ ] Icon rotation animations

---

**Created:** November 22, 2025
**Status:** ✅ Production Ready
**Animations:** ✨ Elegant, Minimalist, Modern
