import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../services/url_service.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  String _selectedYear = 'تمام سال';
  String _searchQuery = '';
  final List<String> _years = ['تمام سال', '2026', '2025', '2024'];

  List<RecordEntry> get _filteredRecords {
    return AppData.annualRecords.where((r) {
      final matchesYear = _selectedYear == 'تمام سال' || r.year == _selectedYear;
      final matchesSearch = _searchQuery.isEmpty ||
          r.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.categoryUrdu.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.location.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesYear && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سالانہ پروجیکٹ ریکارڈ بک', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            onPressed: () {
              UrlService.openWhatsApp(
                message: 'السلام علیکم! مجھے خیراُمہ ویلفیئر سوسائٹی کے سالانہ آڈٹ اور پراجیکٹ رپورٹس درکار ہیں۔',
              );
            },
            icon: const Icon(Icons.download, color: Colors.white),
            tooltip: 'رپورٹ حاصل کریں',
          ),
        ],
      ),
      body: Column(
        children: [
          // Year Selection Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                const Text('سال منتخب کریں: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _years.map((year) {
                        final isSelected = _selectedYear == year;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ChoiceChip(
                            label: Text(year),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) setState(() => _selectedYear = year);
                            },
                            selectedColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textMain,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'ریکارڈ یا پروجیکٹ تلاش کریں...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),

          // Record list
          Expanded(
            child: _filteredRecords.isEmpty
                ? const Center(
                    child: Text('کوئی ریکارڈ نہیں ملا۔', style: TextStyle(color: AppColors.textMuted)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredRecords.length,
                    itemBuilder: (context, index) {
                      final record = _filteredRecords[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    record.categoryUrdu,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    record.year,
                                    style: const TextStyle(
                                      color: Color(0xFFD97706),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              record.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              record.notes,
                              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                            ),
                            const Divider(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.people, size: 16, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Text(
                                      record.count,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      record.location,
                                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
