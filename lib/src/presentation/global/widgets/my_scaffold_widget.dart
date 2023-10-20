import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/connectivity_repository.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    required this.body,
    this.appBar,
    super.key,
  });

  final Widget body;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    final ConnectivityRepository connectivityRepository = context.read();

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
            Expanded(
              child: body,
            ),
            StreamBuilder<bool>(
              stream: connectivityRepository.onInternetChanged,
              builder: (_, AsyncSnapshot<bool> snapshot) {
                return AnimatedSwitcher(
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  duration: const Duration(milliseconds: 200),
                  child: snapshot.data == false
                      ? ColoredBox(
                          color: Theme.of(context).colorScheme.error,
                          child: Center(
                            child: Text(
                              'No internet',
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
