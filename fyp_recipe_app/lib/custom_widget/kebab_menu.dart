import 'package:flutter/material.dart';

class KebabMenuWidget extends StatelessWidget {
  final Future<void> Function(String,String) onReportSubmitted;
  final fullnameController = TextEditingController();
  final reportController = TextEditingController();

  KebabMenuWidget({required this.onReportSubmitted});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String reportMessage = '';

                    return AlertDialog(
                      title: const Text('Report'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: fullnameController,
                            decoration: const InputDecoration(
                              labelText: 'Full name',
                              hintText: 'Enter your name',
                            ),
                          ),
                          TextField(
                            controller: reportController,
                            decoration: const InputDecoration(
                              labelText: 'Report details',
                              hintText: 'Enter report details',
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                       TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final fullname = fullnameController.text;
                            final report = reportController.text;
                            await onReportSubmitted(fullname, report)
                                .then((_) => Navigator.pop(context));
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
