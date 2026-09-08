import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../data/app_data.dart';
import '../services/url_service.dart';

class CustomHeader extends StatelessWidget {
  final VoidCallback? onAdminTap;

  const CustomHeader({super.key, this.onAdminTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Contact & Call Buttons
              Row(
                children: [
                  IconButton(
                    onPressed: () => UrlService.makePhoneCall(),
                    icon: const Icon(Icons.phone_in_talk, color: Colors.white, size: 22),
                    tooltip: 'کال کریں',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.18),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => UrlService.openWhatsApp(message: 'السلام علیکم! خیراُمہ ویلفیئر سوسائٹی'),
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366), size: 22),
                    tooltip: 'واٹس ایپ',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.18),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),

              // Website Live Link Button
              InkWell(
                onTap: () => UrlService.openWebsite(),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.35)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.language, color: AppColors.accent, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Live Website',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Logo and Title
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: AppColors.accent, width: 2.5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.volunteer_activism, color: AppColors.primary, size: 30),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            AppData.appNameUrdu,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            AppData.appSubtitle,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFD1FAE5),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
