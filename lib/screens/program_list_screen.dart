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
  final _categories = const [
    'All',
    'Development',
    'Design',
    'Marketing',
    'Data Science'
  ];

  final List<_Program> _programs = [
    _Program('UI/UX Design Fundamentals', '4.8', '210',
        Icons.palette_outlined, AppColors.categoryColors[0]),
    _Program('Python for Beginners', '4.7', '185', Icons.code_rounded,
        AppColors.categoryColors[1]),
    _Program('Data Science Essentials', '4.6', '160',
        Icons.query_stats_rounded, AppColors.categoryColors[2]),
    _Program('Digital Marketing Masterclass', '4.5', '140',
        Icons.campaign_outlined, AppColors.categoryColors[3]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Programs')),
      body: ResponsiveCenter(
        padding:
            EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search programs...',
                prefixIcon:
                    const Icon(Icons.search_rounded, color: AppColors.textMuted),
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
                itemBuilder: (context, i) => _buildCategoryChip(
                  _categories[i],
                  i == _selectedCategory,
                  () => setState(() => _selectedCategory = i),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildProgramGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramGrid(BuildContext context) {
    final columns =
        Responsive.columns(context, mobile: 1, tablet: 2, desktop: 3);
    if (columns == 1) {
      return ListView.separated(
        itemCount: _programs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _ProgramCard(program: _programs[i]),
      );
    }
    return GridView.builder(
      itemCount: _programs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.2,
      ),
      itemBuilder: (context, i) => _ProgramCard(program: _programs[i]),
    );
  }

  Widget _buildCategoryChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        alignment: Alignment.center,
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

class _Program {
  final String title;
  final String rating;
  final String reviews;
  final IconData icon;
  final Color color;
  const _Program(this.title, this.rating, this.reviews, this.icon, this.color);
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({required this.program});
  final _Program program;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/program-detail'),
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
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: program.color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(program.icon, color: program.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.star, size: 16),
                      const SizedBox(width: 4),
                      Text('${program.rating} (${program.reviews})',
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}