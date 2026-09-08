import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KhairUmmahApp());
}

class KhairUmmahApp extends StatelessWidget {
  const KhairUmmahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'خیراُمہ ویلفیئر سوسائٹی',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      locale: const Locale('ur', 'PK'),
      supportedLocales: const [
        Locale('ur', 'PK'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const MainNavigationScreen(),
    );
  }
}
