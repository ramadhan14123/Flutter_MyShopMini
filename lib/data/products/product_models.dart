import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Product {
  final int id;
  final String name;
  final String category;
  final String subcategory;
  final double price;
  final double oldPrice;
  final double rating;
  final int ratingCount;
  final String thumbnail;
  final List<String> images;
  final String description;
  final Map<String, String> details;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.ratingCount,
    required this.thumbnail,
    required this.images,
    required this.description,
    required this.details,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        subcategory: json['subcategory'] as String? ?? '',
        price: (json['price'] as num).toDouble(),
        oldPrice: (json['oldPrice'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
        ratingCount: (json['ratingCount'] as num).toInt(),
        thumbnail: json['thumbnail'] as String,
        images: (json['images'] as List<dynamic>).cast<String>(),
        description: json['description'] as String,
        details: (json['details'] as Map<String, dynamic>).map((k, v) => MapEntry(k, v.toString())),
      );
}

class ProductRepository {
  static const assetPath = 'assets/data/products.json';
  List<Product>? _cache;

  Future<List<Product>> loadAll() async {
    if (_cache != null) return _cache!;
    final s = await rootBundle.loadString(assetPath);
    final List<dynamic> raw = jsonDecode(s) as List<dynamic>;
    _cache = raw.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    return _cache!;
  }
}
