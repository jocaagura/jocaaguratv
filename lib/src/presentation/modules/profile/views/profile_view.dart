import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../../../global/controllers/theme_controller.dart';
import '../../../global/extensions/build_context_ext.dart';
import '../../../routes/routes.dart';

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
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              SwitchListTile(
                value: !themeController.isDarkMode,
                title: Text(
                  context.darkMode ? 'Turn on Light mode' : 'Turn on Dark mode',
                ),
                onChanged: (bool value) {
                  themeController.toggleTheme();
                },
              ),
              ListTile(
                onTap: () {
                  context.read<SessionController>().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.signIn,
                    (_) => false,
                  );
                },
                title: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
