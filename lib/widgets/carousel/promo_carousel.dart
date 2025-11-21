import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../data/promo/promo_banner_repository.dart';

class PromoBannerCarousel extends StatefulWidget {
  final double aspectRatio; 
  final bool autoPlay;
  final Duration interval;
  final bool showIndicators;
  final double maxHeight; 
  final EdgeInsetsGeometry padding; 

  const PromoBannerCarousel({
    super.key,
    this.aspectRatio = 16 / 9,
    this.autoPlay = true,
    this.interval = const Duration(seconds: 4),
    this.showIndicators = true,
    this.maxHeight = 320,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  late Future<List<PromoBanner>> _future;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _future = PromoBannerRepository().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PromoBanner>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: 160,
            child: Center(
              child: Text('Gagal memuat banner', style: TextStyle(color: Colors.red.shade600)),
            ),
          );
        }
        final data = snapshot.data ?? [];
        if (data.isEmpty) {
          return const SizedBox(height: 0);
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final isTablet = w >= 600 && w < 1024;
            final isDesktop = w >= 1024;

            double viewportFraction;
            double itemGap; 
            if (isDesktop) {
              viewportFraction = 0.55;
              itemGap = 20; 
            } else if (isTablet) {
              viewportFraction = 0.70; 
              itemGap = 12; 
            } else {
              viewportFraction = 0.86; 
              itemGap = 16; 
            }

            final cardWidth = w * viewportFraction;
            double computedHeight = cardWidth / widget.aspectRatio;
            if (computedHeight > widget.maxHeight) {
              computedHeight = widget.maxHeight;
            } else if (computedHeight < 140) {
              computedHeight = 140;
            }

            return Padding(
              padding: widget.padding,
              child: Column(
              children: [
                CarouselSlider.builder(
                  itemCount: data.length,
                  options: CarouselOptions(
                    height: computedHeight,
                    autoPlay: widget.autoPlay,
                    autoPlayInterval: widget.interval,
                    viewportFraction: viewportFraction,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) => setState(() => _current = index),
                  ),
                  itemBuilder: (context, index, realIdx) {
                    final banner = data[index];
                    return Padding(
                      // Gunakan itemGap/2 agar total antar dua slide = itemGap
                      padding: EdgeInsets.symmetric(horizontal: itemGap / 2),
                      child: _BannerCard(
                        banner: banner,
                        active: index == _current,
                        aspectRatio: widget.aspectRatio,
                      ),
                    );
                  },
                ),
                if (widget.showIndicators) ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(data.length, (i) {
                      final active = i == _current;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 6,
                        width: active ? 26 : 10,
                        decoration: BoxDecoration(
                          color: active ? data[i].color : data[i].color.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }),
                  ),
                ],
              ],
            ),
            );
          },
        );
      },
    );
  }
}

class _BannerCard extends StatelessWidget {
  final PromoBanner banner;
  final bool active; // tetap ada jika nanti ingin efek aktif
  final double aspectRatio;

  const _BannerCard({
    required this.banner,
    required this.active,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    // Tidak lagi menggunakan AnimatedScale agar ukuran stabil
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Bungkus dengan ColoredBox agar saat loading tetap konsisten dimensi
            ColoredBox(
              color: banner.color.withOpacity(0.15),
              child: Image.network(
                banner.imageUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(banner.color),
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(Icons.image_not_supported, color: banner.color.withOpacity(0.8), size: 40),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    banner.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
