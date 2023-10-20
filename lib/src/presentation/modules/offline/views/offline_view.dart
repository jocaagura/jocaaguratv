import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../routes/routes.dart';

class OfflineView extends StatefulWidget {
  const OfflineView({super.key});

  @override
  State<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  late StreamSubscription<bool> streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = context
        .read<ConnectivityRepository>()
        .onInternetChanged
        .listen((bool isConnected) {
      if (isConnected) {
        Navigator.pushReplacementNamed(
          context,
          Routes.splash,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Offline'),
      ),
    );
  }
}
