import 'dart:async';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class HeroCarousel extends StatefulWidget {
  final List<SliderSlide> slides;

  const HeroCarousel({super.key, required this.slides});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % widget.slides.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slides.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: widget.slides.length,
              itemBuilder: (context, index) {
                final slide = widget.slides[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      slide.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.primaryDark,
                        child: const Center(
                          child: Icon(Icons.image, color: Colors.white54, size: 40),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            slide.title,
                            style: const TextStyle(
                              color: AppColors.accentGold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            slide.subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            // Indicator Dots
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.slides.length, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    width: isActive ? 20 : 6,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.accentGold : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
