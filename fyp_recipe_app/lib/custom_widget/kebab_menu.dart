import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../network/api_response.dart';
import '../provider/report_provider.dart';

class KebabMenuWidget extends StatefulWidget {
  const KebabMenuWidget({
    required this.recipeId,
    super.key,
  });

  final String recipeId;

  @override
  State<KebabMenuWidget> createState() => _KebabMenuWidgetState();
}

class _KebabMenuWidgetState extends State<KebabMenuWidget> {
  late final TextEditingController fullnameController;

  late final TextEditingController reportController;

  late final ReportProvider reportProvider;

  void reportListner() async {
    if (reportProvider.reportResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(reportProvider.reportResponse.error.toString())));
    } else if (reportProvider.reportResponse.status == Status.success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Report has been sent.")));
    }
  }

  @override
  void initState() {
    fullnameController = TextEditingController();
    reportController = TextEditingController();
    reportProvider = context.read<ReportProvider>();
    reportProvider.addListener(reportListner);
    super.initState();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    reportController.dispose();
    reportProvider.removeListener(reportListner);
    super.dispose();
  }

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
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            context.read<ReportProvider>().report(
                                  fullname: fullnameController.text,
                                  report: reportController.text,
                                  recipeId: widget.recipeId,
                                );
                          },
                          child: const Text('Submit'),
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
