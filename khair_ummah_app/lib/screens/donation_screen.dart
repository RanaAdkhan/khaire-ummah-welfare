import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/bank_card.dart';
import '../services/url_service.dart';
import '../services/storage_service.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Donation Form Controllers
  final _donorNameController = TextEditingController();
  final _donorPhoneController = TextEditingController();
  final _donorAmountController = TextEditingController();
  String _selectedDonationType = 'صدقہ عام';
  String _selectedCategory = 'راشن پیکیج';
  String _selectedPaymentMethod = 'بینک ٹرانسفر';

  // Aid Form Controllers
  final _aidNameController = TextEditingController();
  final _aidPhoneController = TextEditingController();
  final _aidCityController = TextEditingController();
  final _aidAddressController = TextEditingController();
  final _aidProblemController = TextEditingController();
  String _selectedAidCategory = 'راشن کی ضرورت';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _donorNameController.dispose();
    _donorPhoneController.dispose();
    _donorAmountController.dispose();
    _aidNameController.dispose();
    _aidPhoneController.dispose();
    _aidCityController.dispose();
    _aidAddressController.dispose();
    _aidProblemController.dispose();
    super.dispose();
  }

  void _submitDonationForm() async {
    final name = _donorNameController.text.trim();
    final phone = _donorPhoneController.text.trim();
    final amount = _donorAmountController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('براہِ کرم نام اور فون نمبر درج فرمائیں۔')),
      );
      return;
    }

    final refId = "DON-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    final submission = LocalSubmission(
      id: refId,
      type: 'Donation',
      name: name,
      phone: phone,
      category: '$_selectedCategory ($_selectedDonationType)',
      details: 'رقم: $amount | طریقہ: $_selectedPaymentMethod',
      date: DateTime.now().toString().split(' ')[0],
    );

    await StorageService.saveSubmission(submission);

    final msg = """السلام علیکم! میں نے خیراُمہ ویلفیئر سوسائٹی ایپ پر عطیہ جمع کروایا ہے:
📌 ریفرنس: $refId
👤 نام: $name
📱 فون: $phone
📦 شعبہ: $_selectedCategory ($_selectedDonationType)
💵 رقم: ${amount.isEmpty ? 'حسبِ استطاعت' : amount}
💳 طریقہ ادائیگی: $_selectedPaymentMethod""";

    UrlService.openWhatsApp(message: msg);

    _donorNameController.clear();
    _donorPhoneController.clear();
    _donorAmountController.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('عطیہ فارم محفوظ ہو گیا! ریفرنس: $refId'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  void _submitAidForm() async {
    final name = _aidNameController.text.trim();
    final phone = _aidPhoneController.text.trim();
    final city = _aidCityController.text.trim();
    final address = _aidAddressController.text.trim();
    final problem = _aidProblemController.text.trim();

    if (name.isEmpty || phone.isEmpty || problem.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('براہِ کرم نام، فون اور مسئلہ کی تفصیل درج فرمائیں۔')),
      );
      return;
    }

    final refId = "AID-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    final submission = LocalSubmission(
      id: refId,
      type: 'Aid',
      name: name,
      phone: phone,
      category: _selectedAidCategory,
      details: 'شہر: $city | پتہ: $address | مسئلہ: $problem',
      date: DateTime.now().toString().split(' ')[0],
    );

    await StorageService.saveSubmission(submission);

    final msg = """السلام علیکم! خیراُمہ ویلفیئر سوسائٹی پر امداد کی درخواست جمع کروائی گئی ہے:
📌 ریفرنس: $refId
👤 نام: $name
📱 فون: $phone
🏙️ شہر: $city
📦 درکار مدد: $_selectedAidCategory
🏠 پتہ: $address
📝 تفصیل: $problem""";

    UrlService.openWhatsApp(message: msg);

    _aidNameController.clear();
    _aidPhoneController.clear();
    _aidCityController.clear();
    _aidAddressController.clear();
    _aidProblemController.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('امداد کی درخواست موصول ہو گئی! ریفرنس: $refId'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عطیات و مالی تعاون', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.accentGold,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'عطیہ جمع کروائیں'),
            Tab(text: 'بینک اکاؤنٹس'),
            Tab(text: 'امداد کی درخواست'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: Donation Form
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.primary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'آپ کا دیا ہوا ہر ایک روپیہ 100 فیصد مستحقین تک پہنچایا جاتا ہے۔ زکوٰۃ، صدقات اور عطیات کی رسید حاصل کریں۔',
                          style: TextStyle(fontSize: 12, color: AppColors.primaryDark, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Donor Name
                const Text('آپ کا نام:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _donorNameController,
                  decoration: InputDecoration(
                    hintText: 'مثال: محمد احمد',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                // Phone
                const Text('موبائل / واٹس ایپ نمبر:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _donorPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '0300-1234567',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                // Donation Type
                const Text('عطیہ کی قسم:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedDonationType,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'صدقہ عام', child: Text('صدقہ عام')),
                    DropdownMenuItem(value: 'فرض زکوٰۃ', child: Text('فرض زکوٰۃ')),
                    DropdownMenuItem(value: 'فطرانہ و صدقہ فطر', child: Text('فطرانہ و صدقہ فطر')),
                    DropdownMenuItem(value: 'عطیہ برائے تعمیر و فلٹریشن', child: Text('عطیہ برائے تعمیر و فلٹریشن')),
                  ],
                  onChanged: (val) => setState(() => _selectedDonationType = val!),
                ),
                const SizedBox(height: 12),

                // Category
                const Text('کس شعبے میں لگانا چاہتے ہیں؟', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'راشن پیکیج', child: Text('راشن پیکیج')),
                    DropdownMenuItem(value: 'صاف پانی منصوبے', child: Text('صاف پانی منصوبے')),
                    DropdownMenuItem(value: 'روزانہ دسترخوان', child: Text('روزانہ دسترخوان')),
                    DropdownMenuItem(value: 'فری ایمبولینس ریلیف', child: Text('فری ایمبولینس ریلیف')),
                    DropdownMenuItem(value: 'یتیم و بیوہ کفالت', child: Text('یتیم و بیوہ کفالت')),
                    DropdownMenuItem(value: 'فری ڈسپنسری و ادویات', child: Text('فری ڈسپنسری و ادویات')),
                    DropdownMenuItem(value: 'عام فلاحی کام', child: Text('عام فلاحی کام')),
                  ],
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
                const SizedBox(height: 12),

                // Amount
                const Text('رقم (پاکستانی روپے میں):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _donorAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'مثال: 5,000',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _submitDonationForm,
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'عطیہ جمع کریں اور واٹس ایپ رسید بھیجیں',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // TAB 2: Official Bank Accounts
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'آفیشل بینک اور موبائل اکاؤنٹس',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
              ),
              const SizedBox(height: 6),
              const Text(
                'کسی بھی بینک اکاؤنٹ یا ایزی پیسہ/جاز کیش میں رقم ٹرانسفر کے بعد واٹس ایپ پر رسید ضرور ارسال فرمائیں۔',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 14),
              ...AppData.bankAccounts.map((acc) => BankCard(account: acc)),
            ],
          ),

          // TAB 3: Aid Request Form
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.volunteer_activism, color: Color(0xFFD97706)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'اگر آپ یا آپ کا کوئی جاننے والا حقیقی مستحق ہے تو درج ذیل فارم پُر کریں، ہماری ٹیم جانچ پڑتال کے بعد رابطہ کرے گی۔',
                          style: TextStyle(fontSize: 12, color: Color(0xFF78350F), height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                const Text('امداد کے طلبگار کا نام:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _aidNameController,
                  decoration: InputDecoration(
                    hintText: 'مکمل نام درج کریں',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                const Text('رابطہ نمبر / موبائل:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _aidPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '0300-1234567',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                const Text('شہر / علاقہ:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _aidCityController,
                  decoration: InputDecoration(
                    hintText: 'لاہور، قصور وغیرہ',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                const Text('درکار مدد کی نوعیت:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedAidCategory,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'راشن کی ضرورت', child: Text('راشن کی ضرورت')),
                    DropdownMenuItem(value: 'طبی علاج و ادویات', child: Text('طبی علاج و ادویات')),
                    DropdownMenuItem(value: 'یتیم بچے کی کفالت', child: Text('یتیم بچے کی کفالت')),
                    DropdownMenuItem(value: 'تعلیمی اخراجات', child: Text('تعلیمی اخراجات')),
                    DropdownMenuItem(value: 'صاف پانی / ہینڈ پمپ', child: Text('صاف پانی / ہینڈ پمپ')),
                  ],
                  onChanged: (val) => setState(() => _selectedAidCategory = val!),
                ),
                const SizedBox(height: 12),

                const Text('گھر کا مکمل پتہ:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _aidAddressController,
                  decoration: InputDecoration(
                    hintText: 'مکان نمبر، گلی، محلہ',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                const Text('مسئلہ اور حالات کی مختصر تفصیل:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _aidProblemController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'معاشی حالات، کمانے والا فرد، گھر کے افراد کی تعداد وغیرہ',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _submitAidForm,
                    icon: const Icon(Icons.send),
                    label: const Text('درخواست جمع کروائیں', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD97706),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
