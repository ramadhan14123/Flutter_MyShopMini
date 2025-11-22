import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class DealProduct {
  final int id;
  final String title;
  final String imageUrl;
  final String discountText;
  final Color accentColor;

  DealProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.discountText,
    required this.accentColor,
  });

  factory DealProduct.fromJson(Map<String, dynamic> json) => DealProduct(
        id: json['id'] as int,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
        discountText: json['discountText'] as String,
        accentColor: _parseColor(json['accentColor'] as String),
      );
}

Color _parseColor(String hex) {
  var cleaned = hex.replaceAll('#', '').toUpperCase();
  if (cleaned.length == 6) cleaned = 'FF$cleaned';
  return Color(int.parse(cleaned, radix: 16));
}

class DealRepository {
  static const String assetPath = 'assets/data/deals.json';

  Future<List<DealProduct>> loadDeals() async {
    final s = await rootBundle.loadString(assetPath);
    final List<dynamic> raw = jsonDecode(s) as List<dynamic>;
    return raw.map((e) => DealProduct.fromJson(e as Map<String, dynamic>)).toList();
  }
}
