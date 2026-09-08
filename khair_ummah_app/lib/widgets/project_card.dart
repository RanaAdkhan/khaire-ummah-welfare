import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../services/url_service.dart';

class ProjectCard extends StatelessWidget {
  final ProjectCategory project;
  final VoidCallback onDonate;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onDonate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    project.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.primary,
                      child: const Center(
                        child: Icon(Icons.volunteer_activism, color: Colors.white54, size: 48),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black87, Colors.transparent],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.titleUrdu,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                                ),
                              ),
                              Text(
                                project.titleEng,
                                style: const TextStyle(
                                  color: Color(0xFFFDE68A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.accent),
                          ),
                          child: Text(
                            '${project.completedCount}+ مکمل',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMain,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Target & Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ہدف و پیشرفت:',
                      style: TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      project.target,
                      style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: project.progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.greenAccent),
                  ),
                ),
                const SizedBox(height: 14),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onDonate,
                        icon: const Icon(Icons.volunteer_activism, size: 16),
                        label: const Text('اس پروجیکٹ میں حصہ لیں', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        UrlService.openWhatsApp(
                          message: "السلام علیکم! مجھے '${project.titleUrdu}' کے بارے میں معلومات حاصل کرنی ہے۔",
                        );
                      },
                      icon: const Icon(Icons.chat, color: Color(0xFF25D366)),
                      tooltip: 'واٹس ایپ پر رابطہ',
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFDCFCE7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
