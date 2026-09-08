import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../data/app_data.dart';

class UrlService {
  static Future<bool> openWhatsApp({required String message, String? phone}) async {
    final targetPhone = phone ?? AppData.officialWhatsApp;
    final encodedMsg = Uri.encodeComponent(message);
    final url = Uri.parse("https://wa.me/$targetPhone?text=$encodedMsg");

    try {
      if (await canLaunchUrl(url)) {
        return await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
    return false;
  }

  static Future<bool> makePhoneCall([String? phone]) async {
    final targetPhone = phone ?? AppData.officialPhone;
    final url = Uri.parse("tel:$targetPhone");

    try {
      if (await canLaunchUrl(url)) {
        return await launchUrl(url);
      }
    } catch (_) {}
    return false;
  }

  static Future<bool> openWebsite([String? urlString]) async {
    final url = Uri.parse(urlString ?? AppData.websiteUrl);
    try {
      if (await canLaunchUrl(url)) {
        return await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
    return false;
  }

  static void shareApp() {
    Share.share(
      "خیراُمہ ویلفیئر سوسائٹی (دارالتقویٰ) آفیشل موبائل ایپ:\n${AppData.websiteUrl}\nرابطہ و واٹس ایپ: ${AppData.officialPhoneDisplay}",
      subject: "خیراُمہ ویلفیئر سوسائٹی",
    );
  }
}
