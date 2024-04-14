import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff266c2c),
      surfaceTint: Color(0xff266c2c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6db36b),
      onPrimaryContainer: Color(0xff001e04),
      secondary: Color(0xff0e2e10),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff30502e),
      onSecondaryContainer: Color(0xffc7eec0),
      tertiary: Color(0xff000d02),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0e3214),
      onTertiaryContainer: Color(0xff99c298),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff191d17),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      surfaceVariant: Color(0xffdce5d6),
      onSurfaceVariant: Color(0xff40493e),
      outline: Color(0xff717a6d),
      outlineVariant: Color(0xffc0c9bb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inverseOnSurface: Color(0xffeff2e9),
      inversePrimary: Color(0xff8fd88b),
      primaryFixed: Color(0xffaaf5a5),
      onPrimaryFixed: Color(0xff002204),
      primaryFixedDim: Color(0xff8fd88b),
      onPrimaryFixedVariant: Color(0xff055316),
      secondaryFixed: Color(0xffc6edbf),
      onSecondaryFixed: Color(0xff022105),
      secondaryFixedDim: Color(0xffabd1a5),
      onSecondaryFixedVariant: Color(0xff2e4e2d),
      tertiaryFixed: Color(0xffc3edc1),
      onTertiaryFixed: Color(0xff002107),
      tertiaryFixedDim: Color(0xffa8d1a6),
      onTertiaryFixedVariant: Color(0xff2b4f2e),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004e13),
      surfaceTint: Color(0xff266c2c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3e8340),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0e2e10),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff30502e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff000d02),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0e3214),
      onTertiaryContainer: Color(0xffc5efc2),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff191d17),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      surfaceVariant: Color(0xffdce5d6),
      onSurfaceVariant: Color(0xff3d453a),
      outline: Color(0xff596256),
      outlineVariant: Color(0xff747d71),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inverseOnSurface: Color(0xffeff2e9),
      inversePrimary: Color(0xff8fd88b),
      primaryFixed: Color(0xff3e8340),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff24692a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5b7d57),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff436440),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff587e59),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff406442),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002906),
      surfaceTint: Color(0xff266c2c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004e13),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff08280b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2a4a29),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff000d02),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0e3214),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff191d17),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdce5d6),
      onSurfaceVariant: Color(0xff1e261c),
      outline: Color(0xff3d453a),
      outlineVariant: Color(0xff3d453a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffb3feae),
      primaryFixed: Color(0xff004e13),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00350a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2a4a29),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff133315),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff274b2a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0f3416),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8fd88b),
      surfaceTint: Color(0xff8fd88b),
      onPrimary: Color(0xff00390b),
      primaryContainer: Color(0xff3e8340),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xffabd1a5),
      onSecondary: Color(0xff173718),
      secondaryContainer: Color(0xff163617),
      onSecondaryContainer: Color(0xffa1c79c),
      tertiary: Color(0xffa8d1a6),
      onTertiary: Color(0xff143719),
      tertiaryContainer: Color(0xff001b05),
      onTertiaryContainer: Color(0xff84ac84),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff10140f),
      onBackground: Color(0xffe0e4db),
      surface: Color(0xff10140f),
      onSurface: Color(0xffe0e4db),
      surfaceVariant: Color(0xff40493e),
      onSurfaceVariant: Color(0xffc0c9bb),
      outline: Color(0xff8a9386),
      outlineVariant: Color(0xff40493e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inverseOnSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff266c2c),
      primaryFixed: Color(0xffaaf5a5),
      onPrimaryFixed: Color(0xff002204),
      primaryFixedDim: Color(0xff8fd88b),
      onPrimaryFixedVariant: Color(0xff055316),
      secondaryFixed: Color(0xffc6edbf),
      onSecondaryFixed: Color(0xff022105),
      secondaryFixedDim: Color(0xffabd1a5),
      onSecondaryFixedVariant: Color(0xff2e4e2d),
      tertiaryFixed: Color(0xffc3edc1),
      onTertiaryFixed: Color(0xff002107),
      tertiaryFixedDim: Color(0xffa8d1a6),
      onTertiaryFixedVariant: Color(0xff2b4f2e),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff93dc8f),
      surfaceTint: Color(0xff8fd88b),
      onPrimary: Color(0xff001b03),
      primaryContainer: Color(0xff5aa05a),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffafd5a9),
      onSecondary: Color(0xff001b03),
      secondaryContainer: Color(0xff769a72),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffacd5aa),
      onTertiary: Color(0xff001b05),
      tertiaryContainer: Color(0xff739a73),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff10140f),
      onBackground: Color(0xffe0e4db),
      surface: Color(0xff10140f),
      onSurface: Color(0xfff9fcf3),
      surfaceVariant: Color(0xff40493e),
      onSurfaceVariant: Color(0xffc4cebf),
      outline: Color(0xff9ca698),
      outlineVariant: Color(0xff7d8679),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inverseOnSurface: Color(0xff272b25),
      inversePrimary: Color(0xff075417),
      primaryFixed: Color(0xffaaf5a5),
      onPrimaryFixed: Color(0xff001602),
      primaryFixedDim: Color(0xff8fd88b),
      onPrimaryFixedVariant: Color(0xff00400e),
      secondaryFixed: Color(0xffc6edbf),
      onSecondaryFixed: Color(0xff001602),
      secondaryFixedDim: Color(0xffabd1a5),
      onSecondaryFixedVariant: Color(0xff1d3d1d),
      tertiaryFixed: Color(0xffc3edc1),
      onTertiaryFixed: Color(0xff001604),
      tertiaryFixedDim: Color(0xffa8d1a6),
      onTertiaryFixedVariant: Color(0xff1a3d1e),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff1ffea),
      surfaceTint: Color(0xff8fd88b),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff93dc8f),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff1ffea),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffafd5a9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0ffeb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffacd5aa),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff10140f),
      onBackground: Color(0xffe0e4db),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff40493e),
      onSurfaceVariant: Color(0xfff4feee),
      outline: Color(0xffc4cebf),
      outlineVariant: Color(0xffc4cebf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003209),
      primaryFixed: Color(0xffaef9a9),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff93dc8f),
      onPrimaryFixedVariant: Color(0xff001b03),
      secondaryFixed: Color(0xffcaf1c3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffafd5a9),
      onSecondaryFixedVariant: Color(0xff001b03),
      tertiaryFixed: Color(0xffc7f2c5),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffacd5aa),
      onTertiaryFixedVariant: Color(0xff001b05),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
