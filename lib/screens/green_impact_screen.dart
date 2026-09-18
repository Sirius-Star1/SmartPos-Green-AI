import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GreenImpactScreen extends StatelessWidget {
  const GreenImpactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Green Impact Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 32),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text('Dampak Lingkungan Anda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Setiap struk digital yang Anda cetak membantu mengurangi emisi karbon dan menjaga bumi tetap hijau.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.softGreenBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.eco_outlined, color: AppColors.primary, size: 16),
                    SizedBox(width: 6),
                    Text('RINGKASAN DAMPAK HIJAU',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 12),
                _ImpactRow(
                  icon: Icons.description_outlined,
                  title: 'Struk Digital',
                  subtitle: 'struk paperless hari ini',
                  value: '0',
                ),
                const Divider(),
                _ImpactRow(
                  icon: Icons.eco,
                  title: 'Kertas Dihemat',
                  subtitle: 'setara 0 rim kertas',
                  value: '0 lembar',
                ),
                const Divider(),
                _ImpactRow(
                  icon: Icons.public,
                  title: 'Pengurangan Emisi',
                  subtitle: 'emisi karbon dicegah',
                  value: '0 kg CO₂',
                ),
                const Divider(),
                _ImpactRow(
                  icon: Icons.emoji_events_outlined,
                  title: 'Badge',
                  subtitle: 'status keanggotaan hijau',
                  value: '-',
                  valueColor: AppColors.primary,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.emoji_events,
                            color: Colors.white, size: 16),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Badge akan muncul setelah data tersambung ke sistem',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatBox(label: 'Bulan Ini', value: '0', unit: 'struk digital'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBox(label: 'Total Dihemat', value: '0 kg', unit: 'emisi CO₂ bulan ini'),
              ),
            ],
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

class _ImpactRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final Color? valueColor;

  const _ImpactRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13)),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: valueColor ?? AppColors.textPrimary)),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _StatBox({required this.label, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary)),
          Text(unit,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
