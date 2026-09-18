import 'package:flutter/material.dart';
import 'package:smartpos_green_ai/screens/tutorial_screen.dart';
import '../theme/app_colors.dart';
import '../widgets/summary_card.dart';
import 'green_impact_screen.dart';
import 'qr_member_screen.dart';
import 'transaction_screen.dart';
import 'ai_analytics_screen.dart';
import 'barang_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            // TODO: Ganti 'logo_smartpos.png' sesuai nama file logo Anda
            // di folder assets/images/.
            Image.asset(
              'assets/logo.jpeg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('SmartPOS',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // TODO: Tampilkan notifikasi dari backend.
            },
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary,
            child: Text('--',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dashboard Utama',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.softGreenBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Live',
                    style: TextStyle(color: AppColors.primary, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Menu ikon fitur utama
          GridView.count(
            crossAxisCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
            childAspectRatio: 0.68,
            children: [
              _FeatureIcon(
                icon: Icons.eco_outlined,
                label: 'Green\nImpact',
                color: AppColors.primary,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GreenImpactScreen())),
              ),
              _FeatureIcon(
                icon: Icons.qr_code_2,
                label: 'QR\nMember',
                color: AppColors.purple,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const QrMemberScreen())),
              ),
              _FeatureIcon(
                icon: Icons.receipt_long_outlined,
                label: 'Transaksi',
                color: AppColors.orange,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TransactionScreen())),
              ),
              _FeatureIcon(
                icon: Icons.smart_toy_outlined,
                label: 'AI\nAnalytics',
                color: AppColors.infoBlue,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AiAnalyticsScreen())),
              ),
              _FeatureIcon(
                icon: Icons.inventory_2_outlined,
                label: 'Barang',
                color: AppColors.primaryDark,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BarangScreen())),
              ),
              _FeatureIcon(
                icon: Icons.book_outlined, // Atau Icons.school_outlined
                label: 'Tutorial',
                color: AppColors.purple, // Sesuaikan warna tema Anda
                onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const TutorialScreen())),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TAMPILKAN:',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: () {},
                child: const Text('Lihat semua'),
              ),
            ],
          ),

          // Ringkasan bisnis - nilai dikosongkan, siap diisi dari database
          SummaryCard(
            icon: Icons.shopping_cart_outlined,
            iconColor: AppColors.primary,
            title: 'Total Penjualan Hari Ini',
            value: 'Rp 0',
            subtitle: '0% vs kemarin',
          ),
          const SizedBox(height: 12),
          SummaryCard(
            icon: Icons.receipt_outlined,
            iconColor: AppColors.primary,
            title: 'Transaksi Hari Ini',
            value: '0',
            subtitle: 'transaksi selesai',
          ),
          const SizedBox(height: 12),
          SummaryCard(
            icon: Icons.people_outline,
            iconColor: AppColors.primary,
            title: 'Pelanggan Eco Member',
            value: '0',
            subtitle: 'member aktif',
          ),
          const SizedBox(height: 12),
          SummaryCard(
            icon: Icons.description_outlined,
            iconColor: AppColors.primary,
            title: 'Struk Digital Bulan Ini',
            value: '0',
            subtitle: 'hemat kertas ~0 lembar',
          ),

          const SizedBox(height: 20),
          const Text('WIDGET TAMBAHAN:',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          _SectionCard(
            title: 'Produk Terlaris',
            icon: Icons.trending_up,
            iconColor: AppColors.primary,
            child: const EmptyState(message: 'Belum ada data penjualan'),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Stok Menipis',
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.warning,
            child: const EmptyState(message: 'Belum ada data stok'),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('by Tim SAHARA',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ),
          const Center(
            child: Text('IGNITE FEST 2026 · SmartPOS v1.0',
                style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FeatureIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 9.5,
                height: 1.15,
                color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
