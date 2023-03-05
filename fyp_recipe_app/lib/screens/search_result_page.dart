import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(),
      body: SingleChildScrollView(
        child: ListView(),
      ),
    );
  }
}

// class DropdownButtonExample extends StatefulWidget {
//   DropdownButtonExample({super.key});
//   List<String> list = <String>['By Rating', 'By Preparation Time'];

//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(
//         Icons.arrow_drop_down,
//         size: 37,
//         color: Colors.white,
//       ),
//       elevation: 4,
//       style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
//       underline: Container(
//         height: 2.5,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
