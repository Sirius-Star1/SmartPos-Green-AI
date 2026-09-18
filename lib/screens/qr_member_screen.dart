import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_colors.dart';

class QrMemberScreen extends StatelessWidget {
  const QrMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Ganti seluruh nilai berikut dengan data member dari database/API.
    const String memberName = '-';
    const String memberId = '-';
    const String memberLevel = '-';
    const int ecoPoints = 0;
    const int pointsToNextLevel = 0;
    const double progress = 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('QR Member')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tunjukkan kartu digital Anda untuk mendapatkan poin',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.softGreenBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.eco, size: 16, color: AppColors.primary),
                        SizedBox(width: 6),
                        Text('KARTU MEMBER DIGITAL',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                      ],
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Salin ID member ke clipboard.
                      },
                      icon: const Icon(Icons.copy, size: 14),
                      label: const Text('Salin ID', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nama :', style: TextStyle(fontSize: 13)),
                    const Text(memberName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('ID :', style: TextStyle(fontSize: 13)),
                    const Text(memberId,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.primary.withOpacity(0.4),
                        style: BorderStyle.solid),
                  ),
                  child: QrImageView(
                    // TODO: Ganti dengan ID member unik dari database.
                    data: memberId,
                    version: QrVersions.auto,
                    size: 160,
                    eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square, color: AppColors.primary),
                    dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Level :', style: TextStyle(fontSize: 13)),
                    const Text(memberLevel,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Eco Points :', style: TextStyle(fontSize: 13)),
                      Text('$ecoPoints pts',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primary)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Member aktif sejak -',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Menuju level berikutnya',
                        style: TextStyle(fontSize: 13)),
                    Text('$ecoPoints / $pointsToNextLevel pts',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.border,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Data poin akan tersinkron otomatis dari sistem',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text('© Tim SAHARA 2026 | Inovasi Digital Berkelanjutan',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}
