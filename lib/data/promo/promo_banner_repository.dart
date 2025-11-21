import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class PromoBanner {
  final int id;
  final String title;
  final String subtitle;
  final Color color;
  final String imageUrl;

  PromoBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageUrl,
  });

  factory PromoBanner.fromJson(Map<String, dynamic> json) {
    return PromoBanner(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      color: _parseColor(json['color'] as String),
      imageUrl: json['imageUrl'] as String,
    );
  }
}

Color _parseColor(String hex) {
  var cleaned = hex.replaceAll('#', '').toUpperCase();
  if (cleaned.length == 6) cleaned = 'FF$cleaned';
  return Color(int.parse(cleaned, radix: 16));
}

class PromoBannerRepository {
  static const String assetPath = 'assets/data/promo_banners.json';

  Future<List<PromoBanner>> loadBanners() async {
    final raw = await rootBundle.loadString(assetPath);
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => PromoBanner.fromJson(e as Map<String, dynamic>)).toList();
  }
}
