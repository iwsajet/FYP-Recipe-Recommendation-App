import 'package:flutter/material.dart';

import '../models/ingredient_model.dart';
import 'package:fyp_recipe_app/app_properties.dart';

// ignore: must_be_immutable
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

  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
                            //Clear Data
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
                        child: const Text(
                          "Remove",
                          style: TextStyle(color: AppColor.secondary),
                        )),
                  ],
                ),
              ],
            ),
            TextFormField(
              controller: widget._ingredientController,

              onChanged: (value) => widget.ingredientModel.name = value,
              onSaved: (value) => widget.ingredientModel.name = value!,
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter name";
                return null;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),

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
