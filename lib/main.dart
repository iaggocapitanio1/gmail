import 'package:flutter/material.dart';
import 'package:gmail/pages/compose.dart';
import 'package:gmail/pages/home-page.dart';
import 'package:gmail/pages/mail-page.dart';
import 'package:gmail/pages/splash-screen.dart';
import 'package:gmail/theme/theme-provider.dart';
import 'package:gmail/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ), // Ensure provider is added
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gmail Clone',
      themeMode: themeProvider.themeMode, // Uses the theme mode from provider
      theme: AppTheme.lightTheme, // Your light theme
      darkTheme: AppTheme.darkTheme, // Your dark theme
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/HomePage': (context) => const HomePage(),
        '/compose': (context) => const Compose(),
        MailPage.routeName: (context) => const MailPage(),
      },
    );
  }
}
