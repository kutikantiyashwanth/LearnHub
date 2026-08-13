import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: isDesktop
            ? _buildDesktopLayout()
            : _buildMobileLayout(),
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
              constraints: const BoxConstraints(maxWidth: 420),
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
          const SizedBox(height: 24),
          _buildLogo(),
          const SizedBox(height: 40),
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
          const Text('Skills that move\nyour career forward.',
              style: TextStyle(color: Colors.white, fontSize: 34, height: 1.25, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Text('Join thousands of learners building real, job-ready skills with LearnHub.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 15, height: 1.5)),
          const SizedBox(height: 40),
          _buildStat('10,000+', 'Active Learners'),
          const SizedBox(height: 16),
          _buildStat('200+', 'Expert-led Programs'),
          const SizedBox(height: 16),
          _buildStat('95%', 'Completion Rate'),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Row(
      children: [
        Container(
          width: 6, height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text('$value  ', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
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
          const Text('Welcome back',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text('Log in to continue your learning journey.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 32),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email address',
              prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.textMuted),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter your email';
              if (!v.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 16),
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
              if (v == null || v.isEmpty) return 'Please enter your password';
              if (v.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showForgotPassword(),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _loading ? null : _login,
            child: _loading
                ? const SizedBox(
                    height: 20, width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Log In'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.border)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('or', style: TextStyle(color: AppColors.textMuted)),
              ),
              const Expanded(child: Divider(color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Don't have an account? ",
                    style: TextStyle(color: AppColors.textSecondary)),
                TextButton(
                  onPressed: () => _showSignUp(),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showForgotPassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter your email and we\'ll send you a reset link.',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email address',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Reset link sent to your email!'),
                  backgroundColor: AppColors.accent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }

  void _showSignUp() {
    Navigator.pushReplacementNamed(context, '/signup');
  }
}
