import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/summary_card.dart';

class AiAnalyticsScreen extends StatelessWidget {
  const AiAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.eco, size: 18, color: AppColors.primary),
            SizedBox(width: 6),
            Text('AI Analytics'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.infoBlue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Beta',
                    style: TextStyle(color: AppColors.infoBlue, fontSize: 12)),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Diperbarui: -',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              TextButton.icon(
                onPressed: () {
                  // TODO: Panggil endpoint AI Analytics untuk memperbarui rekomendasi.
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Perbarui'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.softGreenBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 16, color: AppColors.primary),
                        SizedBox(width: 6),
                        Text('AI Recommendation',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.copy, size: 14),
                      label: const Text('Salin', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const EmptyState(
                  message: 'Rekomendasi AI akan muncul setelah data penjualan tersedia',
                  icon: Icons.psychology_alt_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.trending_up,
                  iconColor: AppColors.success,
                  title: 'Proyeksi Penjualan',
                  value: 'Rp 0',
                  subtitle: 'estimasi besok',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.bolt,
                  iconColor: AppColors.infoBlue,
                  title: 'Jam Puncak',
                  value: '-',
                  subtitle: 'siapkan kasir ekstra',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.infoBlue.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.infoBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.inventory_2_outlined,
                      color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fitur Masa Depan',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('Chat AI langsung · Prediksi 30 hari · Auto-reorder',
                          style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
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
