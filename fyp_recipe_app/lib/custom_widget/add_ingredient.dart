import 'package:flutter/material.dart';

class IngredientRow extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController nameController;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;

  const IngredientRow({
    Key? key,
    required this.quantityController,
    required this.nameController,
    required this.onAddPressed,
    required this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: TextFormField(
            controller: quantityController,
            decoration: const InputDecoration(
              labelText: "Quantity",
            ),
            maxLength: 80,
          ),
        ),
        SizedBox(
          width: 120,
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Ingredients",
            ),
            maxLength: 80,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onAddPressed,
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onRemovePressed,
        ),
      ],
    );
  }
}
