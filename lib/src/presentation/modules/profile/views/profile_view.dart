import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/theme_controller.dart';
import '../../../global/extensions/build_context_ext.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.read<ThemeController>();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Center(
            child: SwitchListTile(
              value: !themeController.isDarkMode,
              title: Text(
                context.darkMode ? 'Turn on Light mode' : 'Turn on Dark mode',
              ),
              onChanged: (bool value) {
                themeController.toggleTheme();
              },
            ),
          ),
        ),
      ),
    );
  }
}
