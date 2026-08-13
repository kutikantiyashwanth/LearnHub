import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/program_detail_screen.dart';
import 'screens/program_list_screen.dart';
import 'screens/signup_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const LearnHubApp());

class LearnHubApp extends StatelessWidget {
  const LearnHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return _fade(const LoginScreen());
          case '/signup':
            return _fade(const SignUpScreen());
          case '/home':
            return _fade(const HomeScreen());
          case '/programs':
            return _slide(const ProgramListScreen());
          case '/program-detail':
            final program = settings.arguments as Map<String, dynamic>?;
            return _slide(ProgramDetailScreen(program: program));
          default:
            return _fade(const LoginScreen());
        }
      },
    );
  }

  PageRoute _fade(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: const Duration(milliseconds: 250),
      );

  PageRoute _slide(Widget page) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
          child: c,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      );
}
