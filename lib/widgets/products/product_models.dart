import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HotProduct {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final int discountPercent; // derived but stored to simplify rendering
  final double rating; // 0-5
  final int ratingCount;
  final bool topSeller;

  const HotProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.discountPercent,
    required this.rating,
    required this.ratingCount,
    required this.topSeller,
  });

  factory HotProduct.fromJson(Map<String, dynamic> json) => HotProduct(
        id: json['id'] as int,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
        price: (json['price'] as num).toDouble(),
        oldPrice: (json['oldPrice'] as num).toDouble(),
        discountPercent: (json['discountPercent'] as num).toInt(),
        rating: (json['rating'] as num).toDouble(),
        ratingCount: (json['ratingCount'] as num).toInt(),
        topSeller: (json['topSeller'] as bool?) ?? false,
      );
}

class HotSellingRepository {
  static const String assetPath = 'assets/data/hot_selling.json';

  Future<List<HotProduct>> load() async {
    final s = await rootBundle.loadString(assetPath);
    final List<dynamic> raw = jsonDecode(s) as List<dynamic>;
    return raw.map((e) => HotProduct.fromJson(e as Map<String, dynamic>)).toList();
  }
}

class RecommendedRepository {
  static const String assetPath = 'assets/data/recommended.json';

  Future<List<HotProduct>> load() async {
    final s = await rootBundle.loadString(assetPath);
    final List<dynamic> raw = jsonDecode(s) as List<dynamic>;
    return raw.map((e) => HotProduct.fromJson(e as Map<String, dynamic>)).toList();
  }
}
