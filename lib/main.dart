import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/program_detail_screen.dart';
import 'screens/program_list_screen.dart';
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
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/programs': (_) => const ProgramListScreen(),
        '/program-detail': (_) => const ProgramDetailScreen(),
      },
    );
  }
}