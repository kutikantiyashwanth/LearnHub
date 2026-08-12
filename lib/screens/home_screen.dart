import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  static final List<Map<String, dynamic>> _programs = [
    {'title': 'UI/UX Design Fundamentals', 'rating': '4.8', 'reviews': '230', 'icon': Icons.palette_outlined, 'color': AppColors.categoryColors[0], 'category': 'Design', 'lessons': '20', 'hours': '12', 'level': 'Intermediate'},
    {'title': 'Python for Beginners', 'rating': '4.7', 'reviews': '185', 'icon': Icons.code_rounded, 'color': AppColors.categoryColors[1], 'category': 'Development', 'lessons': '25', 'hours': '15', 'level': 'Beginner'},
    {'title': 'Data Science Essentials', 'rating': '4.6', 'reviews': '160', 'icon': Icons.query_stats_rounded, 'color': AppColors.categoryColors[2], 'category': 'Data Science', 'lessons': '30', 'hours': '20', 'level': 'Intermediate'},
    {'title': 'Digital Marketing Masterclass', 'rating': '4.5', 'reviews': '140', 'icon': Icons.campaign_outlined, 'color': AppColors.categoryColors[3], 'category': 'Marketing', 'lessons': '18', 'hours': '10', 'level': 'Beginner'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: _showNotifications,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Popular Programs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/programs'),
                    child: const Text('See all'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildProgramsGrid(context),
              const SizedBox(height: AppSpacing.lg),
              const Text('Your Achievements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
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
        GestureDetector(
          onTap: _showProfile,
          child: const CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primary,
            child: Text('K',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hi, Kavya 👋',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Text("Let's continue learning today.",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/programs'),
          icon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildContinueLearningCard() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/program-detail', arguments: {
        'title': 'Flutter Development Basics',
        'rating': '4.9',
        'reviews': '320',
        'icon': Icons.phone_android_rounded,
        'color': AppColors.primary,
        'category': 'Development',
        'lessons': '32',
        'hours': '20',
        'level': 'Beginner',
      }),
      child: Container(
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
              child: const Text('IN PROGRESS',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
            ),
            const SizedBox(height: 14),
            const Text('Flutter Development Basics',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Module 6 of 8 · UI & Layouts',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text('75%',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Continue →',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramsGrid(BuildContext context) {
    final columns = Responsive.columns(context, mobile: 1, tablet: 2, desktop: 2);
    if (columns == 1) {
      return Column(
        children: _programs.map((p) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ProgramCard(program: p),
        )).toList(),
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
    final items = [
      {'label': 'Certificates', 'value': '12', 'icon': Icons.verified_outlined},
      {'label': 'Courses', 'value': '8', 'icon': Icons.menu_book_outlined},
      {'label': 'Hours', 'value': '42', 'icon': Icons.timer_outlined},
    ];
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i != 0) const SizedBox(width: 12),
          Expanded(child: _AchievementCard(item: items[i])),
        ],
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _navIndex,
      onTap: (i) {
        setState(() => _navIndex = i);
        if (i == 1) Navigator.pushNamed(context, '/programs');
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'My Learning'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
      ],
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            _notifTile('New lesson available', 'Flutter Development Basics · Module 7 is live!', Icons.play_circle_outline_rounded, AppColors.primary),
            _notifTile('Achievement unlocked!', 'You completed 8 courses. Keep going!', Icons.verified_outlined, AppColors.accent),
            _notifTile('Reminder', 'You haven\'t practiced today. 15 min left in your goal.', Icons.timer_outlined, AppColors.star),
          ],
        ),
      ),
    );
  }

  Widget _notifTile(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
    );
  }

  void _showProfile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 36, backgroundColor: AppColors.primary,
                child: Text('K', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            const Text('Kavya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            Text('kavya@learnhub.com', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
              child: const Text('Log Out'),
            ),
          ],
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
          color: AppColors.surface,
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

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.item});
  final Map<String, dynamic> item;

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
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(item['icon'] as IconData, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 10),
          Text(item['value'] as String,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text(item['label'] as String,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
