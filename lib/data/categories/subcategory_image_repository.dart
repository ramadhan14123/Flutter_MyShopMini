import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class SubcategoryImageRepository {
  static const assetPath = 'assets/data/subcategory_images.json';
  static Map<String, String>? _cache;

  Future<Map<String, String>> loadAll() async {
    if (_cache != null) return _cache!;
    final s = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> raw = jsonDecode(s) as Map<String, dynamic>;
    _cache = raw.map((k, v) => MapEntry(k, v.toString()));
    return _cache!;
  }

  String getImageUrl(String subcategory, Map<String, String> imageMap) {
    return imageMap[subcategory] ?? imageMap['default'] ?? '';
  }
}
