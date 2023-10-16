import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getTheme(bool isDarkMode) {
  return isDarkMode
      ? ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          appBarTheme: const AppBarTheme(
            color: AppColors.primaryDark,
            elevation: 0.0,
          ),
          scaffoldBackgroundColor: AppColors.primaryDarkLight,
        )
      : ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          switchTheme: SwitchThemeData(
            thumbColor:
                MaterialStateProperty.all<Color>(AppColors.primaryDarkLight),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.primaryDark,
          ),
        );
}
