import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class ProgramDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? program;
  const ProgramDetailScreen({super.key, this.program});

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  bool _enrolled = false;
  bool _bookmarked = false;

  Map<String, dynamic> get _prog => widget.program ?? {
    'title': 'Flutter Development\nComplete Guide',
    'rating': '4.9',
    'reviews': '320',
    'category': 'Development',
    'lessons': '32',
    'hours': '20',
    'level': 'Beginner',
    'color': AppColors.primary,
    'icon': Icons.phone_android_rounded,
  };

  static const _learnItems = [
    'Flutter Basics & Dart Language',
    'Widgets & State Management',
    'Navigation & Routing',
    'Firebase Integration',
    'Responsive UI Design',
    'Publishing to App Stores',
  ];

  static const _curriculum = [
    {'module': 'Module 1', 'title': 'Getting Started with Flutter', 'lessons': '4'},
    {'module': 'Module 2', 'title': 'Dart Language Fundamentals', 'lessons': '5'},
    {'module': 'Module 3', 'title': 'Widgets Deep Dive', 'lessons': '6'},
    {'module': 'Module 4', 'title': 'State Management', 'lessons': '5'},
    {'module': 'Module 5', 'title': 'Navigation & Routing', 'lessons': '4'},
    {'module': 'Module 6', 'title': 'Firebase Integration', 'lessons': '5'},
    {'module': 'Module 7', 'title': 'UI & Layouts', 'lessons': '3'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final color = (_prog['color'] as Color?) ?? AppColors.primary;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 280 : 220,
            pinned: true,
            backgroundColor: color,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  _bookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() => _bookmarked = !_bookmarked);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_bookmarked ? 'Saved to bookmarks!' : 'Removed from bookmarks'),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, AppColors.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _prog['title'] as String? ?? 'Flutter Development\nComplete Guide',
                            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ResponsiveCenter(
              maxWidth: 900,
              padding: const EdgeInsets.all(24),
              child: isDesktop ? _buildDesktopBody() : _buildMobileBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMeta(),
        const SizedBox(height: 16),
        _buildDescription(),
        const SizedBox(height: 16),
        _buildChips(),
        const SizedBox(height: 24),
        _buildLearnSection(),
        const SizedBox(height: 24),
        _buildCurriculum(),
        const SizedBox(height: 32),
        SizedBox(width: double.infinity, child: _buildEnrollButton()),
      ],
    );
  }

  Widget _buildDesktopBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMeta(),
              const SizedBox(height: 16),
              _buildDescription(),
              const SizedBox(height: 16),
              _buildChips(),
              const SizedBox(height: 24),
              _buildLearnSection(),
              const SizedBox(height: 24),
              _buildCurriculum(),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ready to start?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text('Join ${_prog['reviews']}+ learners already enrolled.',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 20),
                _buildEnrollButton(),
                const SizedBox(height: 12),
                _buildShareButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeta() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: AppColors.star, size: 20),
        const SizedBox(width: 4),
        Text('${_prog['rating']} (${_prog['reviews']} Reviews)',
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(_prog['category'] as String? ?? 'Development',
              style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Learn Flutter from scratch and build beautiful, cross-platform mobile apps with real-world projects. This comprehensive course covers everything from Dart basics to Firebase integration.',
      style: TextStyle(fontSize: 15, height: 1.6, color: AppColors.textSecondary),
    );
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _InfoChip(icon: Icons.menu_book_outlined, label: '${_prog['lessons'] ?? 25} Lessons'),
        _InfoChip(icon: Icons.timer_outlined, label: '${_prog['hours'] ?? 15} Hours'),
        _InfoChip(icon: Icons.emoji_events_outlined, label: '${_prog['level'] ?? 'Beginner'} Level'),
      ],
    );
  }

  Widget _buildLearnSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("What you'll learn",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ..._learnItems.map((text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary))),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCurriculum() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Curriculum',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ..._curriculum.map((m) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.play_circle_outline_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['module']!,
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                    Text(m['title']!,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ],
                ),
              ),
              Text('${m['lessons']} lessons',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildEnrollButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() => _enrolled = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('🎉 Successfully enrolled in program!'),
            backgroundColor: AppColors.accent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            action: SnackBarAction(
              label: 'Go Home',
              textColor: Colors.white,
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _enrolled ? AppColors.accent : AppColors.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_enrolled ? Icons.check_circle_rounded : Icons.school_rounded, size: 18),
          const SizedBox(width: 8),
          Text(_enrolled ? 'Enrolled!' : 'Enrol Now'),
        ],
      ),
    );
  }

  Widget _buildShareButton() {
    return OutlinedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Link copied to clipboard!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.share_rounded, size: 18, color: AppColors.textSecondary),
          SizedBox(width: 8),
          Text('Share Program', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
