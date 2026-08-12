import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class ProgramListScreen extends StatefulWidget {
  const ProgramListScreen({super.key});

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  int _selectedCategory = 0;
  String _searchQuery = '';
  final _searchController = TextEditingController();

  final _categories = const ['All', 'Development', 'Design', 'Marketing', 'Data Science'];

  final List<Map<String, dynamic>> _allPrograms = [
    {'title': 'UI/UX Design Fundamentals', 'rating': '4.8', 'reviews': '210', 'icon': Icons.palette_outlined, 'color': AppColors.categoryColors[0], 'category': 'Design', 'lessons': '20', 'hours': '12', 'level': 'Intermediate'},
    {'title': 'Python for Beginners', 'rating': '4.7', 'reviews': '185', 'icon': Icons.code_rounded, 'color': AppColors.categoryColors[1], 'category': 'Development', 'lessons': '25', 'hours': '15', 'level': 'Beginner'},
    {'title': 'Data Science Essentials', 'rating': '4.6', 'reviews': '160', 'icon': Icons.query_stats_rounded, 'color': AppColors.categoryColors[2], 'category': 'Data Science', 'lessons': '30', 'hours': '20', 'level': 'Intermediate'},
    {'title': 'Digital Marketing Masterclass', 'rating': '4.5', 'reviews': '140', 'icon': Icons.campaign_outlined, 'color': AppColors.categoryColors[3], 'category': 'Marketing', 'lessons': '18', 'hours': '10', 'level': 'Beginner'},
    {'title': 'Flutter Development Basics', 'rating': '4.9', 'reviews': '320', 'icon': Icons.phone_android_rounded, 'color': AppColors.categoryColors[4], 'category': 'Development', 'lessons': '32', 'hours': '20', 'level': 'Beginner'},
    {'title': 'Advanced React JS', 'rating': '4.7', 'reviews': '275', 'icon': Icons.web_rounded, 'color': AppColors.categoryColors[1], 'category': 'Development', 'lessons': '28', 'hours': '18', 'level': 'Advanced'},
    {'title': 'Brand Identity Design', 'rating': '4.6', 'reviews': '98', 'icon': Icons.brush_rounded, 'color': AppColors.categoryColors[0], 'category': 'Design', 'lessons': '15', 'hours': '8', 'level': 'Intermediate'},
    {'title': 'SEO & Content Strategy', 'rating': '4.4', 'reviews': '112', 'icon': Icons.trending_up_rounded, 'color': AppColors.categoryColors[3], 'category': 'Marketing', 'lessons': '14', 'hours': '9', 'level': 'Beginner'},
  ];

  List<Map<String, dynamic>> get _filtered {
    return _allPrograms.where((p) {
      final matchesCategory = _selectedCategory == 0 || p['category'] == _categories[_selectedCategory];
      final matchesSearch = _searchQuery.isEmpty ||
          (p['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Programs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search programs...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, color: AppColors.textMuted),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => _buildChip(
                  _categories[i],
                  i == _selectedCategory,
                  () => setState(() => _selectedCategory = i),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('${_filtered.length} programs found',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 12),
            Expanded(child: _buildGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    if (_filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            const Text('No programs found',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            Text('Try a different search or category',
                style: TextStyle(color: AppColors.textMuted)),
          ],
        ),
      );
    }

    final columns = Responsive.columns(context, mobile: 1, tablet: 2, desktop: 3);
    if (columns == 1) {
      return ListView.separated(
        itemCount: _filtered.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => _ProgramCard(program: _filtered[i]),
      );
    }
    return GridView.builder(
      itemCount: _filtered.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.2,
      ),
      itemBuilder: (_, i) => _ProgramCard(program: _filtered[i]),
    );
  }

  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({required this.program});
  final Map<String, dynamic> program;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/program-detail', arguments: program),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: (program['color'] as Color).withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(program['icon'] as IconData, color: program['color'] as Color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(program['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.star, size: 15),
                      const SizedBox(width: 4),
                      Text('${program['rating']} (${program['reviews']})',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(program['category'] as String,
                            style: const TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
