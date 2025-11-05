import 'package:flutter/material.dart';
import 'package:yollr/features/auth/age_entry_screen.dart';
import 'package:yollr/features/auth/grade_entry_screen.dart';
import 'package:yollr/features/auth/profile_photo_screen.dart';
import 'package:yollr/features/auth/profile_setup_screen.dart';
import 'package:yollr/features/auth/school_entry_screen.dart';
import 'package:yollr/features/auth/splash_screen.dart';
import 'package:yollr/features/billing/billing_subscription_screen.dart';
import 'package:yollr/features/inbox/inbox_screen.dart';
import 'package:yollr/features/ob/follow_friends_screen.dart';
import 'package:yollr/features/pools/loading_pools_screen.dart';
import 'package:provider/provider.dart';
import 'package:yollr/features/result/result_screen.dart';

import 'core/theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Yollr',
          theme: themeProvider.themeData,
          // home: const LoadingPoolsScreen(),
          // home: const SplashScreen(),
          home: const ResultScreen(),
        );
      },
    );
  }
}
