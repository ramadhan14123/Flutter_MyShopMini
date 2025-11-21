# 🚀 AppBottomNavBar - Quick Reference

## ⚡ Quick Start

### 1. Navigation Items

```dart
// Define in MainScreen
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
  // ... more items
];
```

### 2. Add Bottom Bar

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _getScreen(_currentRoute),
    bottomNavigationBar: AppBottomNavBar(
      items: _navItems,
      currentRoute: _currentRoute,
      onNavigate: _handleNavigation,
      badgeCounts: _badgeCounts,
    ),
  );
}
```

### 3. Handle Navigation

```dart
void _handleNavigation(String route) {
  if (_currentRoute != route) {
    setState(() {
      _currentRoute = route;
    });
  }
}
```

## 🎨 Customization

### Colors
```dart
AppBottomNavBar(
  backgroundColor: AppColors.surfaceBase.withValues(alpha: 0.6),
  // Automatically uses dark theme accent colors
);
```

### Size & Shape
```dart
AppBottomNavBar(
  borderRadius: 32,      // Top corners
  elevation: 16,         // Shadow depth
  padding: EdgeInsets.all(16),
);
```

### Badges
```dart
final Map<String, int> _badgeCounts = {
  '/home': 2,      // 2 items in cart
  '/orders': 0,    // No new orders
};
```

## 📊 Animation Curves

| Animation | Type | Curve | Duration |
|-----------|------|-------|----------|
| Icon Scale | Scale | ElasticOut | 600ms |
| Icon Opacity | Opacity | EaseInOut | 600ms |
| Background | Color | EaseInOut | 400ms |
| Label | Opacity | EaseInOut | 300ms |

## 🎯 File Reference

| File | Purpose |
|------|---------|
| `bottom_nav_item.dart` | Model (data class) |
| `bottom_nav_bar_item.dart` | Individual item widget |
| `app_bottom_nav_bar.dart` | Main bar container |
| `main_screen.dart` | Navigation state manager |

## ✨ Key Features

- ✅ **Smooth Animations**: Scale + Opacity + Color transitions
- ✅ **Badge Support**: Show notifications
- ✅ **Fully Customizable**: Colors, size, shape, padding
- ✅ **Dark Theme**: Modern orange/pink/blue accents
- ✅ **Reusable**: Multiple pages, different items
- ✅ **Clean Code**: Separation of concerns
- ✅ **Type Safe**: Model-driven with Dart generics

## 🔧 Common Tasks

### Update Badge Count
```dart
setState(() {
  _badgeCounts['/cart'] = cartItems.length;
});
```

### Add New Navigation Item
```dart
_navItems.add(
  BottomNavItem(
    icon: AppIcons.search,
    label: 'Search',
    route: '/search',
  ),
);
```

### Change Active Item Color
Edit `BottomNavBarItem.build()`:
```dart
color: widget.isActive
    ? AppColors.accentPink  // Change this
    : AppColors.textSecondary,
```

### Add More Pages
1. Create new screen: `lib/screens/new_screen.dart`
2. Add item to `_navItems`
3. Add case to `_getScreen()`

## 🎓 Example: Adding Wishlist Page

```dart
// 1. Create screen
// lib/screens/wishlist_screen.dart

// 2. Update MainScreen
_navItems.add(
  BottomNavItem(
    icon: AppIcons.heart,
    label: 'Wishlist',
    route: '/wishlist',
  ),
);

// 3. Add to _getScreen()
case '/wishlist':
  return const WishlistScreen();

// 4. Add to _badgeCounts
_badgeCounts['/wishlist'] = 0;
```

## 📱 Display

When item is active:
- Icon: Orange color (#FF6A3D)
- Icon: Scales 0.8 → 1.0 with bounce
- Background: Light surface with opacity
- Label: Full white, bold
- Badge: Shows count if > 0

When item is inactive:
- Icon: Muted gray (#D1CEDA)
- Background: Transparent
- Label: Muted gray, normal weight
- Badge: Hidden if count = 0

## 🚀 Performance

- Single animation controller per item (efficient)
- Const constructors (immutable)
- GPU-accelerated curves (60fps)
- Only rebuilds on state change

## 📚 Documentation

- `BOTTOM_NAV_BAR_GUIDE.md` - Complete guide
- `BOTTOM_NAV_BAR_ARCHITECTURE.md` - Architecture & flows
- Code comments - Inline documentation

---

**Status:** ✅ Production Ready | **Version:** 1.0 | **Last Updated:** Nov 22, 2025
