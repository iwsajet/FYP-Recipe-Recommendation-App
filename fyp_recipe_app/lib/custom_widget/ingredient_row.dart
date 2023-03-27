import 'package:flutter/material.dart';

import '../models/ingredient_model.dart';
import 'package:fyp_recipe_app/app_properties.dart';
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
class IngredientFormItemWidget extends StatefulWidget {
  IngredientFormItemWidget({
    Key? key,
    required this.ingredientModel,
    required this.onRemove,
    required this.index,
  }) : super(key: key);

  final int index;
  final Ingredient ingredientModel;
  final Function onRemove;
  final state = _IngredientFormItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _ingredientController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool isValidated() => state.validate();
}

class _IngredientFormItemWidgetState extends State<IngredientFormItemWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ingredient - ${widget.index}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColor.secondary),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //Clear All forms Data
                            widget.ingredientModel.name = "";
                            widget.ingredientModel.quantity = "";
                            widget._ingredientController.clear();
                            widget._quantityController.clear();
                            widget._emailController.clear();
                          });
                        },
                        child: const Text(
                          "Clear",
                          style: TextStyle(color: AppColor.secondary),
                        )),
                    TextButton(
                        onPressed: () => widget.onRemove(),
                        child: Text(
                          "Remove",
                          style: TextStyle(color: AppColor.secondary),
                        )),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: widget._ingredientController,
              // initialValue: widget.contactModel.name,
              onChanged: (value) => widget.ingredientModel.name = value,
              onSaved: (value) => widget.ingredientModel.name = value!,
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter name";
                return null;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                // border: OutlineInputBorder(),
                hintText: "Enter Ingrdient Name",
                labelText: "Ingredient Name",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: widget._quantityController,
              onChanged: (value) => widget.ingredientModel.quantity = value,
              onSaved: (value) => widget.ingredientModel.name = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Quantity is Not Valid";
                }
                return null;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                // border: OutlineInputBorder(),
                hintText: "Enter Quantity",
                labelText: "Quantity",
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    bool? validate = formKey.currentState?.validate();
    if (validate ?? false) formKey.currentState?.save();
    return validate ?? false;
  }
}
