import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/floating_donate_card.dart';
import '../widgets/stat_counter_card.dart';
import '../services/url_service.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onTabChange;

  const HomeScreen({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with logo and title
          CustomHeader(
            onAdminTap: () => onTabChange(2),
          ),

          // Floating quick donation action
          FloatingDonateCard(
            onDonateTap: () => onTabChange(3),
          ),

          // Auto Hero Slider
          HeroCarousel(slides: AppData.sliderSlides),

          // 9 Major Departments / Services Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'اہم شعبہ جات و خدمات',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                TextButton(
                  onPressed: () => onTabChange(1),
                  child: const Text('سب دیکھیں', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: AppData.projectCategories.length,
              itemBuilder: (context, index) {
                final project = AppData.projectCategories[index];
                return InkWell(
                  onTap: () => onTabChange(1),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              project.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: AppColors.primaryLight,
                                child: const Icon(Icons.favorite, color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project.titleUrdu,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Live Impact Counters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الحمدللہ! اعداد و شمار اور اثرات',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Expanded(
                      child: StatCounterCard(
                        title: 'مستحق خاندان راشن',
                        count: '15,000+',
                        icon: Icons.shopping_bag,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: StatCounterCard(
                        title: 'روزانہ دسترخوان کھانے',
                        count: '185,000+',
                        icon: Icons.restaurant,
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(
                      child: StatCounterCard(
                        title: 'صاف پانی منصوبے',
                        count: '620+',
                        icon: Icons.water_drop,
                        color: Color(0xFF0284C7),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: StatCounterCard(
                        title: 'فری ایمبولینس ریلیف',
                        count: '4,200+',
                        icon: Icons.emergency,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Official Contacts & Social Box
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.primary, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppData.officialAddress,
                        style: TextStyle(fontSize: 13, color: AppColors.textMain, height: 1.4),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => UrlService.makePhoneCall(),
                      icon: const Icon(Icons.phone, size: 16),
                      label: const Text('کال کریں', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => UrlService.openWhatsApp(message: 'السلام علیکم! خیراُمہ ویلفیئر سوسائٹی'),
                      icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 16),
                      label: const Text('واٹس ایپ', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => UrlService.shareApp(),
                      icon: const Icon(Icons.share, size: 16),
                      label: const Text('شیئر', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
