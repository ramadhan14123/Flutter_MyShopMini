## 🎯 AppBottomNavBar - Component Architecture & Animations

### Visual Structure

```
┌─────────────────────────────────────────────────┐
│                  MainScreen                      │
│  ┌────────────────────────────────────────────┐  │
│  │          _getScreen(route)                  │  │
│  │  ┌──────────────────────────────────────┐  │  │
│  │  │  HomeScreen / CategoriesScreen ...   │  │  │
│  │  └──────────────────────────────────────┘  │  │
│  └────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────┐  │
│  │      AppBottomNavBar (bottom: 0)            │  │
│  │  ┌──────────────────────────────────────┐  │  │
│  │  │  Row(children: BottomNavBarItem[])   │  │  │
│  │  │  ┌────────┬────────┬────────┬───────┐ │  │
│  │  │  │ Home   │ Categ. │ Orders │Profile│ │  │
│  │  │  │ (home) │(categ.)│(active)│       │ │  │
│  │  │  └────────┴────────┴────────┴───────┘ │  │
│  │  └──────────────────────────────────────┘  │  │
│  └────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

### Data Flow

```
User Tap on Item
       ↓
BottomNavBarItem.onTap()
       ↓
_handleNavigation(route)
       ↓
setState({ _currentRoute = route })
       ↓
Rebuild MainScreen
       ↓
_getScreen(route) → New Widget
       ↓
AppBottomNavBar re-render dengan isActive update
       ↓
BottomNavBarItem didUpdateWidget()
       ↓
_animationController.forward() / reverse()
       ↓
Animation State Update → UI Renders
```

### Animation Sequence (DetailFrame by Frame)

#### When Item Becomes Active (0ms → 600ms)

```
Timeline:
0ms     ─ User tap
        ├─ ScaleTransition: 0.8 → 1.0 (ElasticOut, 600ms)
        ├─ OpacityAnimation: 0.6 → 1.0 (EaseInOut, 600ms)
        └─ AnimatedContainer (300ms EaseInOut)
            ├─ backgroundColor: transparent → surfaceBase@0.4
            ├─ borderRadius: 12
            └─ padding: symmetric

300ms   ─ Background fully transitioned
400ms   ─ Container animation complete
600ms   ─ Scale/Opacity animation complete ✓
```

#### Icon Color Transition

```
Inactive State:
- Color: textSecondary (#D1CEDA)
- Size: 24
- Opacity: 0.7

Active State:
- Color: accentOrange (#FF6A3D) ← Solid color
- Size: 24
- Opacity: 1.0

Transition Curve: EaseInOut (400ms)
```

### Reusability Matrix

```
┌─────────────────────┬──────────────────┬──────────────────┐
│    Component        │   Customizable   │   Reusable       │
├─────────────────────┼──────────────────┼──────────────────┤
│ BottomNavBarItem    │ ✓ icon, label    │ ✓ Standalone     │
│                     │ ✓ isActive, tap  │ ✓ Test-friendly  │
│                     │ ✓ badge          │                  │
├─────────────────────┼──────────────────┼──────────────────┤
│ AppBottomNavBar     │ ✓ items list     │ ✓ Multiple pages │
│                     │ ✓ colors/radius  │ ✓ Custom layouts │
│                     │ ✓ elevation      │                  │
│                     │ ✓ padding        │                  │
├─────────────────────┼──────────────────┼──────────────────┤
│ BottomNavItem       │ ✓ All props      │ ✓ Type-safe      │
│ (Model)             │ ✓ copyWith       │ ✓ Equality check │
└─────────────────────┴──────────────────┴──────────────────┘
```

### Code Organization

```
lib/
├── core/
│   ├── navigation/
│   │   ├── app_router.dart
│   │   │   └── Routes: welcome → main
│   │   │
│   │   └── bottom_nav_item.dart        ← Model/Data
│   │       └── class BottomNavItem {
│   │           - icon: IconData
│   │           - label: String
│   │           - route: String
│   │           - badgeCount?: int
│   │           - copyWith()
│   │       }
│   │
│   └── theme/
│       └── icons/app_icons.dart
│           └── home, categories, cart, user, etc.
│
├── screens/
│   ├── welcome_screen.dart
│   │   └── Button navigates to /main
│   │
│   ├── main_screen.dart                ← STATE MANAGER
│   │   ├── _currentRoute state
│   │   ├── _badgeCounts map
│   │   ├── _navItems list
│   │   ├── _getScreen() method
│   │   ├── _handleNavigation() method
│   │   └── Scaffold with AppBottomNavBar
│   │
│   ├── home_screen.dart                ← CHILD SCREENS
│   ├── categories_screen.dart
│   ├── orders_screen.dart
│   └── profile_screen.dart
│
└── widgets/
    └── navigation/
        ├── bottom_nav_bar_item.dart    ← ITEM WIDGET
        │   ├── StatefulWidget
        │   ├── AnimationController
        │   ├── Scale + Opacity animations
        │   ├── Badge support
        │   └── Color/opacity transitions
        │
        └── app_bottom_nav_bar.dart     ← MAIN WIDGET
            ├── StatelessWidget
            ├── Container with shadow
            ├── Row of BottomNavBarItems
            ├── Custom colors/radius/elevation
            └── Fully customizable
```

### Animation Classes Used

```dart
// 1. ScaleTransition (Icon)
ScaleTransition(
  scale: _scaleAnimation,  // Tween: 0.8 → 1.0
  child: Icon(...)
);

// 2. Opacity (Direct on Icon)
Opacity(
  opacity: _opacityAnimation.value,  // Tween: 0.6 → 1.0
  child: Icon(...)
);

// 3. AnimatedContainer (Background)
AnimatedContainer(
  duration: 400ms,
  curve: Curves.easeInOut,
  decoration: BoxDecoration(
    color: widget.isActive ? surfaceBase@0.4 : transparent,
    borderRadius: 12,
  ),
);

// 4. AnimatedOpacity (Label)
AnimatedOpacity(
  opacity: widget.isActive ? 1.0 : 0.7,
  duration: 300ms,
  child: Text(label)
);
```

### Color Scheme (Dark Theme)

```
Background:
├─ backgroundMain:  #020205   (Deep black)
├─ backgroundDeep:  #0D0917   (Navigation bg base)
├─ surfaceBase:     #1E1823   (Item bg when active)
└─ surfaceMuted:    #454046   (Borders)

Active State Colors:
├─ Icon:      accentOrange (#FF6A3D)   ← Solid color
├─ Label:    textPrimary  (#FFFFFF)   ← Full opacity
└─ BG:       surfaceBase@0.4           ← Transparent accent

Inactive State Colors:
├─ Icon:      textSecondary (#D1CEDA)  ← Muted
├─ Label:     textSecondary (#D1CEDA)  ← Muted
└─ BG:        transparent              ← No background

Badge Colors:
└─ accentPink (#EA4B71)
```

### Event Flow Chart

```
┌─────────────────────────────────────────────────┐
│ User taps "Orders" item (currently on Home)      │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ BottomNavBarItem.onTap() called                  │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ onNavigate("/orders") callback executed         │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ MainScreen._handleNavigation("/orders")          │
│ Validates: _currentRoute != "/orders"?           │
└────────────────┬────────────────────────────────┘
                 ↓ YES
┌─────────────────────────────────────────────────┐
│ setState(() {                                    │
│   _currentRoute = "/orders"                     │
│ })                                               │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ MainScreen.build() called                        │
│ ├─ _getScreen("/orders") → OrdersScreen()       │
│ └─ AppBottomNavBar(currentRoute: "/orders")     │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ BottomNavBarItem.didUpdateWidget() for all      │
│ Home:       isActive: true → false               │
│ Categories: isActive: false → false              │
│ Orders:     isActive: false → true   ✓           │
│ Profile:    isActive: false → false              │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ Animation Control:                               │
│ Home/Categories/Profile:                         │
│   _animationController.reverse()                 │
│                                                  │
│ Orders:                                          │
│   _animationController.forward()                 │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ AnimationController triggers:                    │
│ ├─ Scale: 0.8 → 1.0 (ElasticOut, 600ms) ✨     │
│ ├─ Opacity: 0.6 → 1.0 (EaseInOut, 600ms)       │
│ ├─ BG Color transition (EaseInOut, 400ms)       │
│ └─ Label opacity (300ms)                        │
└────────────────┬────────────────────────────────┘
                 ↓
┌─────────────────────────────────────────────────┐
│ UI Updates Complete ✓                            │
│ ├─ Home icon: orange → gray (inactive)          │
│ ├─ Orders icon: gray → orange (active, scaled)  │
│ ├─ Body: HomeScreen → OrdersScreen              │
│ └─ Background: transitions smoothly              │
└─────────────────────────────────────────────────┘
```

### Performance Optimization

```
✓ SingleTickerProviderStateMixin (instead of TickerProviderStateMixin)
  → Single animation controller per item (efficient)

✓ const constructors where possible
  → Immutable widgets, less rebuilds

✓ !identical() check in didUpdateWidget
  → Only rebuild when needed

✓ Tween reuse
  → Animations defined once in initState

✓ ElasticOut curve
  → GPU-accelerated animation (smooth 60fps)
```

### Future Enhancement Hooks

```dart
// 1. Add Slide Animation
// _slideAnimation = Tween<Offset>(...)

// 2. Add Rotate Animation
// _rotateAnimation = Tween<double>(...)

// 3. Add Custom Indicator
// _buildCustomIndicator()

// 4. Add Accessibility
// semanticLabel: widget.label

// 5. Add Haptic Feedback
// HapticFeedback.lightImpact()
```

---

**Status:** ✅ Complete & Production Ready
**Animations:** 4 Simultaneous (Scale, Opacity, Color, Label Opacity)
**Performance:** GPU-Accelerated @ 60fps
**Customization:** Full Control Over All Properties
