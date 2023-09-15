import 'package:flutter/material.dart';

class CardPaginationPageWidget extends StatelessWidget {
  const CardPaginationPageWidget({
    required this.currentPage,
    required this.maxItems,
    this.updateFunction = _dummy,
    super.key,
  });

  final int currentPage;
  final int maxItems;
  final void Function(int) updateFunction;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listOfIcons = <Widget>[];
    for (int i = 0; i < maxItems; i++) {
      if (i == currentPage - 1) {
        listOfIcons.add(
          const Icon(
            Icons.circle,
            size: 20.0,
            color: Colors.white,
          ),
        );
      }
      listOfIcons.add(
        InkWell(
          onTap: () {
            updateFunction(i);
          },
          child: const Icon(
            Icons.circle_outlined,
            size: 10.0,
            color: Colors.white,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listOfIcons,
    );
  }
}

void _dummy(int i) {}
