import 'package:flutter/material.dart';

class ImageViewerScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageViewerScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          'تصویر ${_currentIndex + 1} از ${widget.images.length}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final path = widget.images[index];
          return Center(
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: Image.asset(
                path,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white, size: 60),
              ),
            ),
          );
        },
      ),
    );
  }
}
