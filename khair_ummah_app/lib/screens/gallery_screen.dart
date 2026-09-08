import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'image_viewer_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تصویری گیلری و تصویری ثبوت', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: AppData.galleryImages.length,
        itemBuilder: (context, index) {
          final imagePath = AppData.galleryImages[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewerScreen(
                    images: AppData.galleryImages,
                    initialIndex: index,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.image, color: AppColors.primary),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.fullscreen, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
