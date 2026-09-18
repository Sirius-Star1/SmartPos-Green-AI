import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Model Data Tutorial (Sesuaikan dengan payload JSON dari Backend Anda)
class TutorialVideo {
  final String id;
  final String title;
  final String duration;
  final String views;
  final String tag;
  final String colorHex;
  final bool isPopular;

  TutorialVideo({
    required this.id,
    required this.title,
    required this.duration,
    required this.views,
    required this.tag,
    required this.colorHex,
    this.isPopular = false,
  });
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  
  // Tampungan data kosongan dari database/API
  List<String> _categories = ['Semua']; 
  List<TutorialVideo> _fetchedVideos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTutorialData();
  }

  // TODO: Hubungkan fungsi ini dengan Repository / API Service Anda
  Future<void> _fetchTutorialData() async {
    setState(() => _isLoading = true);
    try {
      // API call logic di sini...
      // await _tutorialRepository.getTutorials();
    } catch (e) {
      // Handle error backend di sini
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Memisahkan video populer untuk Hero Card di bagian bawah
    final popularVideo = _fetchedVideos.firstWhere(
      (v) => v.isPopular, 
      orElse: () => TutorialVideo(id: '', title: '', duration: '', views: '', tag: '', colorHex: '0xFF000000'),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Tutorial SmartPOS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Belajar menggunakan SmartPOS Green AI',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchTutorialData,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            // 1. SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari tutorial...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                onChanged: (value) {
                  // TODO: Trigger pencarian lokal atau hit API search
                },
              ),
            ),
            const SizedBox(height: 16),

            // 2. HORIZONTAL CATEGORY FILTER
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: _categories.map((categoryName) {
                  final isSelected = _selectedCategory == categoryName;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(categoryName),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : Colors.grey.shade200,
                        ),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = categoryName;
                          // TODO: Filter data video berdasarkan kategori terpilih
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // 3. SEMUA VIDEO HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Semua Video',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text('${_fetchedVideos.length} video',
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. LIST VIDEO TUTORIAL (STATE LOGIC BACKEND)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : _fetchedVideos.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Icon(Icons.video_library_outlined, size: 40, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('Belum ada video tutorial tersedia', 
                                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _fetchedVideos.length,
                            separatorBuilder: (_, __) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final video = _fetchedVideos[index];
                              final colorHex = int.parse(video.colorHex);
                              
                              return ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Color(colorHex).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Color(colorHex),
                                    size: 24,
                                  ),
                                ),
                                title: Text(
                                  video.title,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 12, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(video.duration, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                      const SizedBox(width: 12),
                                      Text(video.views, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(colorHex).withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    video.tag,
                                    style: TextStyle(fontSize: 10, color: Color(colorHex), fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
            const SizedBox(height: 24),

            // 5. PALING BANYAK DITONTON (FEATURED HERO CARD FROM BACKEND)
            if (!_isLoading && popularVideo.id.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    SizedBox(width: 6),
                    Text('Paling Banyak Ditonton',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        color: const Color(0xFF1B5E20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time, color: Colors.white, size: 10),
                                    const SizedBox(width: 4),
                                    Text(popularVideo.duration, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularVideo.title,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text('★ Populer',
                                      style: TextStyle(fontSize: 9, color: Colors.orange, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 8),
                                Text(popularVideo.views, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Action tonton video dari API
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1B5E20),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                icon: const Icon(Icons.play_arrow, size: 16),
                                label: const Text('Tonton Sekarang',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // 6. FOOTER COPYRIGHT (Di luar block if agar selalu muncul di bawah)
            const Center(
              child: Text(
                '© Tim SAHARA 2026 | Inovasi Digital Berkelanjutan',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}