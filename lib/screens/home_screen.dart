import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<_Program> _programs = [
    _Program('UI/UX Design Fundamentals', '4.8', '230',
        Icons.palette_outlined, AppColors.categoryColors[0]),
    _Program('Python for Beginners', '4.7', '185', Icons.code_rounded,
        AppColors.categoryColors[1]),
    _Program('Data Science Essentials', '4.6', '160',
        Icons.query_stats_rounded, AppColors.categoryColors[2]),
    _Program('Digital Marketing Masterclass', '4.5', '140',
        Icons.campaign_outlined, AppColors.categoryColors[3]),
  ];

  static const _sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.horizontalPadding(context),
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              const SizedBox(height: AppSpacing.lg),
              _buildContinueLearningCard(),
              const SizedBox(height: AppSpacing.lg),
              const Text('Popular Programs', style: _sectionTitle),
              const SizedBox(height: AppSpacing.md),
              _buildProgramsGrid(context),
              const SizedBox(height: AppSpacing.lg),
              const Text('Your Achievements', style: _sectionTitle),
              const SizedBox(height: AppSpacing.md),
              _buildAchievements(),
              SizedBox(height: isMobile ? 96 : AppSpacing.xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isMobile ? _buildBottomNav() : null,
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primary,
          child: Text('K',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, Kavya 👋',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 2),
              Text("Let's continue learning today.",
                  style:
                      TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueLearningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'IN PROGRESS',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5),
            ),
          ),
          const SizedBox(height: 14),
          const Text('Flutter Development Basics',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Module 6 of 8 · UI & Layouts',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85), fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text('75%',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgramsGrid(BuildContext context) {
    final columns = Responsive.columns(context, mobile: 1, tablet: 2, desktop: 2);
    if (columns == 1) {
      return Column(
        children: _programs
            .map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ProgramCard(program: p),
                ))
            .toList(),
      );
    }
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 3.6,
      children: _programs.map((p) => _ProgramCard(program: p)).toList(),
    );
  }

  Widget _buildAchievements() {
    const items = [
      _Achievement('Certificates', '12', Icons.verified_outlined),
      _Achievement('Courses', '8', Icons.menu_book_outlined),
      _Achievement('Hours', '42', Icons.timer_outlined),
    ];
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i != 0) const SizedBox(width: 12),
          Expanded(child: _AchievementCard(achievement: items[i])),
        ],
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined), label: 'Explore'),
        BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), label: 'My Learning'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
      ],
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
          color: AppColors.surface,
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

class _Achievement {
  final String label;
  final String value;
  final IconData icon;
  const _Achievement(this.label, this.value, this.icon);
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.achievement});
  final _Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(achievement.icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 10),
          Text(achievement.value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          Text(achievement.label,
              style:
                  const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}