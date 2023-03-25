import 'package:flutter/material.dart';

class KebabMenuWidget extends StatelessWidget {
  final VoidCallback onReportClicked;

  const KebabMenuWidget({super.key, required this.onReportClicked});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: onReportClicked,
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
//to use KebadMenuWidget(onReportClicked: (){handelReport})