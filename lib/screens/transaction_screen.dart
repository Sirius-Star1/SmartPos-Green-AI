import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/summary_card.dart';
import 'digital_receipt_screen.dart';

/// Model item keranjang sederhana. Nantinya diisi dari database produk.
class CartItem {
  final String name;
  final int price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});

  int get total => price * quantity;
}

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // TODO: Ganti dengan data keranjang transaksi dari backend/database.
  final List<CartItem> _cartItems = [];

  int get _subtotal => _cartItems.fold(0, (sum, item) => sum + item.total);
  int get _ppn => 0; // TODO: Hitung PPN sesuai aturan bisnis (jika ada).
  int get _grandTotal => _subtotal + _ppn;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Halaman Transaksi'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.softGreenBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('${_cartItems.length} item',
                    style: const TextStyle(color: AppColors.primary, fontSize: 12)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Kasir: -', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                Text('#-', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
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
                          const Row(
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 18),
                              SizedBox(width: 8),
                              Text('Pilih Barang',
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // TODO: Ambil daftar produk dari database untuk ditambahkan ke keranjang.
                            },
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Tambah'),
                          ),
                        ],
                      ),
                      const Divider(),
                      if (_cartItems.isEmpty)
                        const EmptyState(
                          message: 'Belum ada barang dipilih',
                          icon: Icons.shopping_cart_outlined,
                        )
                      else
                        ..._cartItems.map((item) => _CartItemTile(
                              item: item,
                              formatRupiah: _formatRupiah,
                              onIncrement: () => setState(() => item.quantity++),
                              onDecrement: () => setState(() {
                                if (item.quantity > 1) item.quantity--;
                              }),
                              onDelete: () => setState(() => _cartItems.remove(item)),
                            )),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal', style: TextStyle(fontSize: 13)),
                          Text(_formatRupiah(_subtotal)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('PPN (0%)', style: TextStyle(fontSize: 13)),
                          Text(_formatRupiah(_ppn)),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Grand Total',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(_formatRupiah(_grandTotal),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DigitalReceiptScreen(
                                  items: _cartItems,
                                  total: _grandTotal,
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('[ BAYAR ] — ${_formatRupiah(_grandTotal)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Tunai · QRIS · Transfer Bank',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final String Function(int) formatRupiah;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const _CartItemTile({
    required this.item,
    required this.formatRupiah,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.softGreenBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.local_cafe_outlined,
                        size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 8),
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
                onPressed: onDelete,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Harga : ${formatRupiah(item.price)}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, size: 18),
                      onPressed: onDecrement,
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add_circle,
                          size: 18, color: AppColors.primary),
                      onPressed: onIncrement,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
