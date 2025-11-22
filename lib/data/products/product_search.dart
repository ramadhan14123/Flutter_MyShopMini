import 'product_models.dart';

class ProductSearchResult {
  final Product product;
  final double score; // higher is better
  const ProductSearchResult(this.product, this.score);
}

class ProductSearchEngine {
  final List<Product> products;
  ProductSearchEngine(this.products);

  // Main search entry: returns sorted results
  List<ProductSearchResult> search(String query, {int maxResults = 50}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];

    final tokens = _tokenize(q);
    final List<ProductSearchResult> out = [];

    for (final p in products) {
      final name = p.name.toLowerCase();
      final category = p.category.toLowerCase();

      double score = 0;
      int strongMatches = 0; // jumlah token yang benar-benar relevan

      // Exact full query boosts (harus sangat relevan)
      if (name.contains(q)) {
        score += 6;
        strongMatches++;
      }
      if (category.contains(q)) {
        score += 5;
        strongMatches++;
      }

      for (final t in tokens) {
        // direct contains token
        if (name.contains(t)) {
          score += 2.4;
          strongMatches++;
        }
        if (category.contains(t)) {
          score += 2.2;
          strongMatches++;
        }

        // Fuzzy only jika token cukup panjang dan jarak sangat kecil
        final maxDist = _allowedDistance(t.length); // adapt threshold
        final dName = _levenshteinLimited(t, name, maxDist);
        if (dName != null) {
          score += _fuzzyScore(t.length, dName) * 1.25;
          if (dName <= 1) strongMatches++; // dianggap kuat jika sangat dekat
        }
        final dCat = _levenshteinLimited(t, category, maxDist);
        if (dCat != null) {
          score += _fuzzyScore(t.length, dCat) * 1.1;
          if (dCat <= 1) strongMatches++;
        }
      }

      // Bonus rating kecil (tidak membuat kata tidak relevan jadi muncul)
      score += (p.rating / 5.0) * 1.2;

      // Filter: butuh minimal 1 strong match dan skor dasar memadai
      if (strongMatches >= 1 && score > 2.2) {
        out.add(ProductSearchResult(p, score));
      }
    }

    out.sort((a, b) => b.score.compareTo(a.score));
    if (out.length > maxResults) return out.sublist(0, maxResults);
    return out;
  }

  List<String> _tokenize(String s) => s.split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();

  // Distance threshold adaptif (lebih ketat)
  int _allowedDistance(int len) {
    if (len <= 3) return 0; // kata sangat pendek harus exact
    if (len <= 5) return 1; // toleransi 1
    return 2; // maksimum untuk kata lebih panjang
  }

  double _fuzzyScore(int tokenLen, int distance) {
    if (distance == 0) return 3.0;
    final maxDist = _allowedDistance(tokenLen);
    if (distance > maxDist) return 0.0;
    return (maxDist - distance) / maxDist * 2.2; // skala baru sedikit lebih besar untuk jarak kecil
  }

  // Basic Levenshtein distance
  // Menghitung jarak minimal terhadap substring, berhenti jika jarak sudah di bawah threshold
  int? _levenshteinLimited(String pattern, String text, int maxAllowed) {
    final m = pattern.length;
    final n = text.length;
    if (m == 0 || n == 0) return null;
    int best = maxAllowed + 1; // mulai lebih besar sedikit
    for (int start = 0; start <= n - m; start++) {
      final window = text.substring(start, start + m);
      final d = _levenshteinDirect(pattern, window);
      if (d < best) best = d;
      if (best <= 0) break; // perfect match
    }
    return best <= maxAllowed ? best : null;
  }

  int _levenshteinDirect(String a, String b) {
    final m = a.length;
    final n = b.length;
    List<int> prev = List<int>.generate(n + 1, (i) => i);
    List<int> curr = List<int>.filled(n + 1, 0);
    for (int i = 1; i <= m; i++) {
      curr[0] = i;
      for (int j = 1; j <= n; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        curr[j] = _min3(
          prev[j] + 1,
          curr[j - 1] + 1,
          prev[j - 1] + cost,
        );
      }
      final tmp = prev;
      prev = curr;
      curr = tmp;
    }
    return prev[n];
  }

  int _min3(int a, int b, int c) => a < b ? (a < c ? a : c) : (b < c ? b : c);
}
