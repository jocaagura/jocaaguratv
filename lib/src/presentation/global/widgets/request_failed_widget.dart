import 'package:flutter/material.dart';

import '../../../generated/translations.g.dart';

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
          const SizedBox(
            height: 80.0,
          ),
          Text(text ?? texts.misc.requestFailed),
          MaterialButton(
            color: Theme.of(context).canvasColor,
            onPressed: onRetry,
            child: Text(texts.misc.retry),
          ),
        ],
      ),
    );
  }
}
