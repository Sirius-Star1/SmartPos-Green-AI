import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'transaction_screen.dart';

enum JenisStruk { kertas, digital }

class DigitalReceiptScreen extends StatefulWidget {
  final List<CartItem> items;
  final int total;

  const DigitalReceiptScreen({
    super.key,
    this.items = const [],
    this.total = 0,
  });

  @override
  State<DigitalReceiptScreen> createState() => _DigitalReceiptScreenState();
}

class _DigitalReceiptScreenState extends State<DigitalReceiptScreen> {
  JenisStruk _jenisStruk = JenisStruk.digital;

  String _formatRupiah(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromRight = str.length - i;
      buffer.write(str[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write('.');
    }
    return 'Rp$buffer';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Digital Receipt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 28),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text('-',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Transaksi Berhasil',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('No. TRX-000000-0000',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textSecondary)),
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
                const SizedBox(height: 12),
                if (widget.items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Belum ada item transaksi',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  )
                else
                  ...widget.items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name),
                                Text('x${item.quantity}',
                                    style: const TextStyle(
                                        fontSize: 11, color: AppColors.textSecondary)),
                              ],
                            ),
                            Text(_formatRupiah(item.total)),
                          ],
                        ),
                      )),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total :', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(_formatRupiah(widget.total),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.primary)),
                  ],
                ),
              ],
            ),
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
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Pilih Jenis Struk',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                RadioListTile<JenisStruk>(
                  value: JenisStruk.kertas,
                  groupValue: _jenisStruk,
                  onChanged: (v) => setState(() => _jenisStruk = v!),
                  title: const Text('Cetak Kertas'),
                  subtitle: const Text('Struk fisik via printer',
                      style: TextStyle(fontSize: 11)),
                  secondary: const Icon(Icons.print_outlined),
                ),
                RadioListTile<JenisStruk>(
                  value: JenisStruk.digital,
                  groupValue: _jenisStruk,
                  onChanged: (v) => setState(() => _jenisStruk = v!),
                  title: const Text('Struk Digital'),
                  subtitle: const Text('+0 Eco Points · hemat kertas',
                      style: TextStyle(fontSize: 11)),
                  secondary: const Icon(Icons.eco_outlined, color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Generate QR struk digital & simpan transaksi ke database.
              },
              icon: const Icon(Icons.qr_code_2),
              label: const Text('Generate QR'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text('Struk digital akan menambah +0 Eco Points ke akun Anda',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('© Tim SAHARA 2026 | Inovasi Digital Berkelanjutan',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}
