import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class StorageService {
  static const String _storageKey = 'khair_ummah_submissions';

  static Future<void> saveSubmission(LocalSubmission submission) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getSubmissions();
    list.insert(0, submission);

    final jsonList = list.map((item) => item.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  static Future<List<LocalSubmission>> getSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    final rawString = prefs.getString(_storageKey);
    if (rawString == null || rawString.isEmpty) return [];

    try {
      final List<dynamic> decoded = jsonDecode(rawString);
      return decoded.map((item) => LocalSubmission.fromJson(item)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> clearSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
