import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _buildBaseTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
  }) {
    final baseTheme = ThemeData(useMaterial3: true, colorScheme: colorScheme);

    return baseTheme.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      cardTheme: CardTheme(
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow,
        surfaceTintColor: colorScheme.surface,
        elevation: 3,
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(Colors.transparent),
        checkColor: WidgetStateProperty.all(colorScheme.primary),
        side: WidgetStateBorderSide.resolveWith((states) {
          return BorderSide(
            color:
                states.contains(WidgetState.selected)
                    ? colorScheme.primary
                    : colorScheme.onSurface,
            width: 2,
          );
        }),
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        height: 60,
        elevation: 2,
        iconTheme: WidgetStateProperty.all(
          baseTheme.iconTheme.copyWith(color: colorScheme.onPrimary),
        ),
        labelTextStyle: WidgetStateProperty.all(
          baseTheme.textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        indicatorColor: Colors.amber.shade600,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.onSurface.withOpacity(0.5),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: colorScheme.onPrimary),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0.0,
      ),
    );
  }

  static ThemeData get lightTheme => _buildBaseTheme(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.grey.shade800,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: Colors.red.shade800,
      onError: Colors.white,
      shadow: Colors.grey.shade300,
      tertiary: Colors.red.shade100,
    ),
  );

  static ThemeData get darkTheme => _buildBaseTheme(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
      primary: const Color(0xff222222),
      onPrimary: Colors.white,
      secondary: Colors.grey.shade500,
      onSecondary: Colors.white,
      surface: const Color(0xff222222),
      onSurface: Colors.white,
      error: Colors.grey.shade700,
      onError: Colors.white,
      shadow: Colors.black26,
      tertiary: Colors.grey.shade100,
    ),
  );
}
