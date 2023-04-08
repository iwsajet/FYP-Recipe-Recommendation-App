import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../network/api_response.dart';
import '../provider/sort_provider.dart';

class SortByDropdown extends StatefulWidget {
  const SortByDropdown({super.key});

  @override
  _SortByDropdownState createState() => _SortByDropdownState();
}

class _SortByDropdownState extends State<SortByDropdown> {
  String? dropdownValue;
  late final SortProvider sortProvider;
  @override
  void initState() {
    sortProvider = context.read<SortProvider>();
    sortProvider.addListener(sortListener);
    super.initState();
  }

  void sortListener() async {
    if (sortProvider.sortResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(sortProvider.sortResponse.error.toString())));
    } else if (sortProvider.sortResponse.status == Status.success) {
      ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Soted.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Sort by preparation time', 'Sort by rating']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
