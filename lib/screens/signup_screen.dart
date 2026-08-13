import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _loading = false;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please agree to the Terms & Conditions'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _loading = false);
    // Show success then go to home
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('🎉 Account created successfully!'),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(child: _buildBrandPanel()),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                child: _buildForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLogo(),
          const SizedBox(height: 32),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildBrandPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(56),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(Icons.auto_stories_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text('LearnHub',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Start your learning\njourney today.',
              style: TextStyle(color: Colors.white, fontSize: 34, height: 1.25, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Text('Create a free account and get access to 200+ expert-led programs.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 15, height: 1.5)),
          const SizedBox(height: 40),
          _buildFeature(Icons.check_circle_rounded, 'Free access to 10+ starter programs'),
          const SizedBox(height: 14),
          _buildFeature(Icons.check_circle_rounded, 'Track your progress & earn certificates'),
          const SizedBox(height: 14),
          _buildFeature(Icons.check_circle_rounded, 'Learn at your own pace, anytime'),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 20),
        const SizedBox(width: 12),
        Text(text, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 14)),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: const Icon(Icons.auto_stories_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        const Text('LearnHub',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Create your account',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text('Join thousands of learners on LearnHub.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 28),

          // Full name
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'Full name',
              prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.textMuted),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your name';
              if (v.trim().length < 2) return 'Name must be at least 2 characters';
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email address',
              prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.textMuted),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter your email';
              if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter a password';
              if (v.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Confirm password
          TextFormField(
            controller: _confirmController,
            obscureText: _obscureConfirm,
            decoration: InputDecoration(
              hintText: 'Confirm password',
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                ),
                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please confirm your password';
              if (v != _passwordController.text) return 'Passwords do not match';
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Terms checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: _agreeTerms,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _agreeTerms = v ?? false),
              ),
              Expanded(
                child: Wrap(
                  children: [
                    Text('I agree to the ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Terms of Service',
                          style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                    Text(' and ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Privacy Policy',
                          style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sign up button
          ElevatedButton(
            onPressed: _loading ? null : _signUp,
            child: _loading
                ? const SizedBox(height: 20, width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Create Account'),
          ),
          const SizedBox(height: 24),

          // Already have account
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text('Already have an account? ',
                    style: TextStyle(color: AppColors.textSecondary)),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text('Log In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
