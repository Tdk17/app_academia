import 'package:flutter/material.dart';

class AppTheme {
  static const bg = Color(0xFF080A0D);
  static const surface = Color(0xFF11151A);
  static const surfaceAlt = Color(0xFF171C22);
  static const accent = Color(0xFFFFB547);
  static const accentStrong = Color(0xFFFF8A1F);
  static const success = Color(0xFF55D98A);
  static const muted = Color(0xFF8D98A5);
  static const border = Color(0xFF252C34);

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme.copyWith(
        primary: accent,
        secondary: accentStrong,
        surface: surface,
      ),
      scaffoldBackgroundColor: bg,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
      ),
      dividerColor: border,
    );
  }
}

class AppBackdrop extends StatelessWidget {
  final Widget child;
  const AppBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF080A0D), Color(0xFF11151A), Color(0xFF080A0D)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -120,
            right: -90,
            child: _Glow(size: 320, color: Color(0x20FFB547)),
          ),
          const Positioned(
            bottom: -160,
            left: -120,
            child: _Glow(size: 380, color: Color(0x12008CFF)),
          ),
          child,
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  final double size;
  final Color color;
  const _Glow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

class ResponsiveFrame extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const ResponsiveFrame({super.key, required this.child, this.maxWidth = 1320});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
