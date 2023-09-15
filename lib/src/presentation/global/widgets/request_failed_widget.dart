import 'package:flutter/material.dart';

class RequestFailedWidget extends StatelessWidget {
  const RequestFailedWidget({required this.onRetry, super.key, this.text});

  final VoidCallback onRetry;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: <Widget>[
          Text(text ?? 'Request Failed'),
          MaterialButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
