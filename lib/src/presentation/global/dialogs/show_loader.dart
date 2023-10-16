import 'package:flutter/material.dart';

Future<T> showLoader<T>(BuildContext context, Future<T> future) async {
  final OverlayState overlayState = Overlay.of(context);
  final OverlayEntry entry = OverlayEntry(
    builder: (BuildContext context) => const ColoredBox(
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
  overlayState.insert(
    entry,
  );
  final T result = await future;
  entry.remove();
  return result;
}
