import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/typography/app_typography.dart';
import '../core/theme/icons/app_icons.dart';
import '../data/products/product_models.dart';
import '../data/products/product_search.dart';
import 'product_detail_screen.dart';

class ProductSearchScreen extends StatefulWidget {
  final String initialQuery;
  final String? filterCategory;
  final String? filterSubcategory;
  const ProductSearchScreen({
    super.key,
    required this.initialQuery,
    this.filterCategory,
    this.filterSubcategory,
  });

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<ProductSearchResult> _results = [];
  bool _loading = true;
  late ProductRepository _repo;
  List<Product> _all = [];

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialQuery;
    _repo = ProductRepository();
    _loadAndSearch(widget.initialQuery);
    // fokus agar user bisa ketik ulang
    Future.delayed(const Duration(milliseconds: 200), () => _focusNode.requestFocus());
  }

  Future<void> _loadAndSearch(String q) async {
    setState(() => _loading = true);
    _all = await _repo.loadAll();
    
    // Filter by category if specified
    if (widget.filterCategory != null && widget.filterCategory!.isNotEmpty) {
      _all = _all.where((p) => p.category == widget.filterCategory).toList();
    }
    
    // Filter by subcategory if specified
    if (widget.filterSubcategory != null && widget.filterSubcategory!.isNotEmpty) {
      _all = _all.where((p) => p.subcategory == widget.filterSubcategory).toList();
    }
    
    final engine = ProductSearchEngine(_all);
    _results = q.isEmpty ? _all.map((p) => ProductSearchResult(p, 1.0)).toList() : engine.search(q);
    setState(() => _loading = false);
  }

  void _onSubmit(String value) => _loadAndSearch(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64 + MediaQuery.of(context).padding.top),
        child: _SearchHeader(
          controller: _controller,
          focusNode: _focusNode,
          onSubmitted: _onSubmit,
          onChanged: (v) {},
          onBack: () => Navigator.of(context).pop(),
          categoryFilter: widget.filterCategory,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((widget.filterCategory != null && widget.filterCategory!.isNotEmpty) ||
                (widget.filterSubcategory != null && widget.filterSubcategory!.isNotEmpty)) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (widget.filterCategory != null && widget.filterCategory!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.accentBlue, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(AppIcons.filter, size: 14, color: AppColors.accentBlue),
                          const SizedBox(width: 6),
                          Text(
                            widget.filterCategory!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.filterSubcategory != null && widget.filterSubcategory!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.accentPink.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.accentPink, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.category_outlined, size: 14, color: AppColors.accentPink),
                          const SizedBox(width: 6),
                          Text(
                            widget.filterSubcategory!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                  : _results.isEmpty
                      ? Center(
                          child: Text(
                            _controller.text.isEmpty 
                                ? 'Tidak ada produk dalam kategori ini'
                                : 'Tidak ada hasil untuk "${_controller.text}"',
                            style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                          ),
                        )
                      : GridView.builder(
                          itemCount: _results.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisSpacing: AppSpacing.md,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, i) {
                            final r = _results[i];
                            return _ProductCard(product: r.product);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final VoidCallback onBack;
  final String? categoryFilter;
  const _SearchHeader({
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.onChanged,
    required this.onBack,
    this.categoryFilter,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: top, left: AppSpacing.lg, right: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDeep,
        border: Border(bottom: BorderSide(color: AppColors.surfaceMuted, width: 0.7)),
      ),
      height: 64 + top,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
            onPressed: onBack,
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceBase,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                border: Border.all(color: AppColors.surfaceMuted, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(AppIcons.search, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      textInputAction: TextInputAction.search,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
                      cursorColor: AppColors.accentPink,
                      decoration: InputDecoration(
                        hintText: 'Cari produk atau kategori...',
                        hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Ikon keranjang/bag di kanan agar konsisten dengan home header
          IconButton(
            tooltip: 'Keranjang',
            onPressed: () {},
            icon: const Icon(AppIcons.bag, color: AppColors.textPrimary, size: 22),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
        );
      },
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surfaceElevated,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined, color: AppColors.textSecondary, size: 30),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.star_rounded, size: 14, color: AppColors.accentOrange),
            const SizedBox(width: 4),
            Text(product.rating.toStringAsFixed(1), style: AppTypography.caption.copyWith(color: AppColors.textPrimary)),
            const SizedBox(width: 6),
            Text('(${product.ratingCount})', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(_price(product.price), style: AppTypography.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            Text(_price(product.oldPrice), style: AppTypography.caption.copyWith(color: AppColors.textSecondary, decoration: TextDecoration.lineThrough)),
          ],
        ),
      ],
    ),
    );
  }

  String _price(double v) => v == v.roundToDouble() ? '\$${v.toInt()}' : '\$${v.toStringAsFixed(2)}';
}
