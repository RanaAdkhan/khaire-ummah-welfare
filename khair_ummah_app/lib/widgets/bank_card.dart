import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class BankCard extends StatelessWidget {
  final BankAccount account;

  const BankCard({super.key, required this.account});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label کاپی ہو گیا!'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobileAccount = account.icon == 'mobile';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMobileAccount ? const Color(0xFFFED7AA) : const Color(0xFFBFDBFE),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isMobileAccount ? const Color(0xFFFFEDD5) : const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isMobileAccount ? Icons.phone_android : Icons.account_balance,
                      color: isMobileAccount ? const Color(0xFFEA580C) : const Color(0xFF1D4ED8),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    account.bankName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  account.badgeText,
                  style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: Color(0xFFF1F5F9)),

          // Title
          Row(
            children: [
              const Text('عنوانِ اکاؤنٹ: ', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              Text(
                account.accountTitle,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textMain),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Account Number
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('اکاؤنٹ نمبر:', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                    SelectableText(
                      account.accountNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => _copyToClipboard(context, account.accountNumber, 'اکاؤنٹ نمبر'),
                  icon: const Icon(Icons.copy, size: 18, color: AppColors.primary),
                  tooltip: 'کاپی کریں',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          if (account.iban.startsWith('PK')) ...[
            const SizedBox(height: 8),
            // IBAN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('IBAN نمبر:', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                        SelectableText(
                          account.iban,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _copyToClipboard(context, account.iban, 'IBAN نمبر'),
                    icon: const Icon(Icons.copy, size: 18, color: AppColors.primary),
                    tooltip: 'کاپی کریں',
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
