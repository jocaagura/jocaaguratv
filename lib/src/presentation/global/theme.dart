import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData getTheme(bool isDarkMode) {
  return isDarkMode
      ? ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            ThemeData.dark().textTheme.copyWith(
                  titleSmall: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryDark,
            iconTheme: IconThemeData(
              color: AppColors.canvasColor,
            ),
            elevation: 0.0,
          ),
          scaffoldBackgroundColor: AppColors.primaryDarkLight,
        )
      : ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            ThemeData.light().textTheme.copyWith(
                  titleSmall: const TextStyle(
                    color: AppColors.canvasColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
          ),
          switchTheme: SwitchThemeData(
            thumbColor:
                MaterialStateProperty.all<Color>(AppColors.primaryDarkLight),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.canvasColor,
          ),
        );
}
