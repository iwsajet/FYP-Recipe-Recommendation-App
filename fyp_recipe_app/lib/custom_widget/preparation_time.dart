import 'package:flutter/material.dart';

class PrepTimeIcon extends StatelessWidget {
  const PrepTimeIcon({super.key, required this.prepTime});
  final String prepTime;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Row(
        children:[const Icon(Icons.timer,),
        Text(prepTime)]
      ),
    );
  }
}