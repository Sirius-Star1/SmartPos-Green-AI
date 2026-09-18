import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/summary_card.dart';

/// Model data barang. Data aktual akan diambil dari database.
class Barang {
  final String nama;
  final int harga;
  final int stok;

  Barang({required this.nama, required this.harga, required this.stok});
}

class BarangScreen extends StatefulWidget {
  const BarangScreen({super.key});

  @override
  State<BarangScreen> createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  // TODO: Ganti dengan data barang dari database/API.
  final List<Barang> _barangList = [];
  final TextEditingController _searchController = TextEditingController();

  int get _totalBarang => _barangList.length;
  int get _stokAman => _barangList.where((b) => b.stok > 10).length;
  int get _stokKritis => _barangList.where((b) => b.stok <= 10).length;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatRupiah(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromRight = str.length - i;
      buffer.write(str[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write('.');
    }
    return 'Rp $buffer';
  }

  void _showAddBarangDialog() {
    // TODO: Simpan barang baru ke database melalui API.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Barang'),
        content: const Text(
            'Formulir tambah barang akan terhubung ke database/API di sini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Barang'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: _showAddBarangDialog,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Tambah'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // FIX: Menggunakan SingleChildScrollView agar card tidak tercekik ruang horizontal
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none, // Agar shadow/border card tidak terpotong saat di-scroll
            child: Row(
              children: [
                SizedBox(
                  width: 120, // Tentukan lebar minimum ideal card agar teks muat horizontal
                  child: SummaryCard(
                    icon: Icons.inventory_2_outlined,
                    iconColor: AppColors.primary,
                    title: 'Total Barang',
                    value: '$_totalBarang',
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: SummaryCard(
                    icon: Icons.check_circle_outline,
                    iconColor: AppColors.success,
                    title: 'Stok Aman',
                    value: '$_stokAman',
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: SummaryCard(
                    icon: Icons.error_outline,
                    iconColor: AppColors.danger,
                    title: 'Stok Kritis',
                    value: '$_stokKritis',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Cari barang...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              // TODO: Filter data barang dari database berdasarkan pencarian.
            },
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: const [
                      Expanded(
                          flex: 4,
                          child: Text('NAMA BARANG',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary))),
                      Expanded(
                          flex: 3,
                          child: Text('HARGA',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary))),
                      Expanded(
                          flex: 2,
                          child: Text('STOK',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary))),
                      SizedBox(
                          width: 72,
                          child: Text('AKSI',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary))),
                    ],
                  ),
                ),
                const Divider(height: 1),
                if (_barangList.isEmpty)
                  const EmptyState(message: 'Belum ada data barang')
                else
                  ..._barangList.map((barang) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    barang.nama,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    _formatRupiah(barang.harga),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${barang.stok}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: barang.stok <= 10
                                          ? AppColors.danger
                                          : AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 72,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _CompactIconButton(
                                        icon: Icons.edit_outlined,
                                        color: AppColors.infoBlue,
                                        onPressed: () {
                                          // TODO: Edit data barang via API.
                                        },
                                      ),
                                      _CompactIconButton(
                                        icon: Icons.delete_outline,
                                        color: AppColors.danger,
                                        onPressed: () {
                                          // TODO: Hapus data barang via API.
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                        ],
                      )),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '$_totalBarang dari $_totalBarang barang ditampilkan',
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary),
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

/// Tombol ikon berukuran kecil (tap area dipangkas) supaya muat berdampingan
/// di kolom "Aksi" tanpa membuat baris tabel jadi terlalu lebar/berantakan.
class _CompactIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _CompactIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, size: 17, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
