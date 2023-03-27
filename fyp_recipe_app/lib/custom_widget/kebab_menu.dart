import 'package:flutter/material.dart';

class KebabMenuWidget extends StatelessWidget {
  final Future<void> Function(String) onReportSubmitted;

  KebabMenuWidget({required this.onReportSubmitted});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.report),
              title: Text('Report'),
              onTap: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String reportMessage = '';

                    return AlertDialog(
                      title: Text('Report'),
                      content: TextField(
                        decoration: InputDecoration(hintText: 'Enter your report'),
                        onChanged: (value) => reportMessage = value,
                      ),
                    
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('Submit'),
                          onPressed: () => Navigator.of(context).pop(reportMessage),
                        ),
                      ],
                    );
                  },
                );

                if (result != null) {
                  onReportSubmitted(result);
                }
              },
            ),
          ),
        ];
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
