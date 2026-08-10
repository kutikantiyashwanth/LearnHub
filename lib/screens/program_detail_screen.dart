import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class ProgramDetailScreen extends StatelessWidget {
  const ProgramDetailScreen({super.key});

  static const _learnItems = [
    'Flutter Basics & Dart Language',
    'Widgets & State Management',
    'Navigation & Routing',
    'Firebase Integration',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 260 : 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.heroGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: const Text(
                        'Flutter Development\nComplete Guide',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
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
              child:
                  isDesktop ? _buildDesktopBody(context) : _buildMobileBody(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBody(BuildContext context) {
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
        const SizedBox(height: 32),
        SizedBox(width: double.infinity, child: _buildEnrollButton(context)),
      ],
    );
  }

  Widget _buildDesktopBody(BuildContext context) {
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text('Join 230+ learners already enrolled in this program.',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 20),
                _buildEnrollButton(context),
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
        const Text('4.8 (230 Reviews)',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20)),
          child: const Text('Development',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Learn Flutter from scratch and build beautiful, cross-platform mobile apps with real-world projects.',
      style: TextStyle(fontSize: 15, height: 1.6, color: AppColors.textSecondary),
    );
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const [
        _InfoChip(icon: Icons.menu_book_outlined, label: '25 Lessons'),
        _InfoChip(icon: Icons.timer_outlined, label: '15 Hours'),
        _InfoChip(icon: Icons.emoji_events_outlined, label: 'Beginner Level'),
      ],
    );
  }

  Widget _buildLearnSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("What you'll learn",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ..._learnItems.map(_buildLearnItem),
      ],
    );
  }

  Widget _buildLearnItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 15, color: AppColors.textPrimary))),
        ],
      ),
    );
  }

  Widget _buildEnrollButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enrolled in program!'),
            backgroundColor: AppColors.accent,
          ),
        );
      },
      child: const Text('Enroll Now'),
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
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}