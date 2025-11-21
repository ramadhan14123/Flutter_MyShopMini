import 'package:flutter/material.dart';

/// Model untuk item bottom navigation bar
/// Setiap item terdiri dari icon, label, dan route
class BottomNavItem {
  /// Icon yang ditampilkan (akan menjadi solid saat aktif)
  final IconData icon;

  /// Label untuk item navigation
  final String label;

  /// Route yang akan dibuka saat item di-tap
  final String route;

  /// Badge count (opsional, e.g. untuk keranjang)
  final int? badgeCount;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
    this.badgeCount,
  });

  /// Copy with method untuk mudah membuat variant
  BottomNavItem copyWith({
    IconData? icon,
    String? label,
    String? route,
    int? badgeCount,
  }) {
    return BottomNavItem(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      route: route ?? this.route,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavItem &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          label == other.label &&
          route == other.route;

  @override
  int get hashCode => icon.hashCode ^ label.hashCode ^ route.hashCode;
}
