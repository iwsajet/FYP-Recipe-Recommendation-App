// import 'package:flutter/material.dart';

// import '../models/ingredient_model.dart';

// class IngredientRow extends StatefulWidget {
//   const IngredientRow({Key? key}) : super(key: key);

//   @override
//   _IngredientRowState createState() => _IngredientRowState();
// }

// class _IngredientRowState extends State<IngredientRow> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final List<Ingredient> _ingredientsList = [];

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _quantityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _nameController,
//             decoration: InputDecoration(
//               hintText: 'Ingredient name',
//             ),
//           ),
//         ),
//         SizedBox(width: 8.0),
//         Expanded(
//           child: TextField(
//             controller: _quantityController,
//             decoration: InputDecoration(
//               hintText: 'Quantity',
//             ),
//           ),
//         ),
//         SizedBox(width: 8.0),
//         IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () {
//             setState(() {
//                _ingredientsList
//                        .add(Ingredient(quantity: '', name: ''));
//               // Add a new ingredient row
//             });
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.remove),
//           onPressed: () {
//             setState(() {
//                _ingredientsList.removeAt(index);
//               // Remove this ingredient row
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
