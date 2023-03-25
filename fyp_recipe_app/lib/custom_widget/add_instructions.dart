import 'package:flutter/material.dart';

class AddInstructions extends StatelessWidget {
  final TextEditingController ingredientController;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;
  const AddInstructions({
    Key? key,
    required this.ingredientController,
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
            controller: ingredientController,
            decoration: const InputDecoration(
              labelText: "Instruction",
            ),
            maxLength: 50,
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
