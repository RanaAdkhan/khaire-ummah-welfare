class ProjectCategory {
  final String id;
  final String titleUrdu;
  final String titleEng;
  final String icon;
  final String description;
  final String imagePath;
  final int completedCount;
  final String target;
  final double progress;

  ProjectCategory({
    required this.id,
    required this.titleUrdu,
    required this.titleEng,
    required this.icon,
    required this.description,
    required this.imagePath,
    required this.completedCount,
    required this.target,
    required this.progress,
  });
}

class RecordEntry {
  final String id;
  final String year;
  final String categoryUrdu;
  final String title;
  final String count;
  final String location;
  final String amount;
  final String notes;

  RecordEntry({
    required this.id,
    required this.year,
    required this.categoryUrdu,
    required this.title,
    required this.count,
    required this.location,
    required this.amount,
    required this.notes,
  });
}

class BankAccount {
  final String bankName;
  final String accountTitle;
  final String accountNumber;
  final String iban;
  final String icon;
  final String badgeText;

  BankAccount({
    required this.bankName,
    required this.accountTitle,
    required this.accountNumber,
    required this.iban,
    required this.icon,
    required this.badgeText,
  });
}

class SliderSlide {
  final String imagePath;
  final String title;
  final String subtitle;

  SliderSlide({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class LocalSubmission {
  final String id;
  final String type; // 'Donation' or 'Aid'
  final String name;
  final String phone;
  final String category;
  final String details;
  final String date;
  final String? locationUrl;

  LocalSubmission({
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
    required this.category,
    required this.details,
    required this.date,
    this.locationUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'name': name,
    'phone': phone,
    'category': category,
    'details': details,
    'date': date,
    'locationUrl': locationUrl,
  };

  factory LocalSubmission.fromJson(Map<String, dynamic> json) => LocalSubmission(
    id: json['id'] ?? '',
    type: json['type'] ?? '',
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    category: json['category'] ?? '',
    details: json['details'] ?? '',
    date: json['date'] ?? '',
    locationUrl: json['locationUrl'],
  );
}
