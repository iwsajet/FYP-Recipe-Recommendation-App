import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80'),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: const [Text("Jane Doe"), Text('@janedoe')],
              ),
            )
          ],
        ),
        Positioned(
          bottom: 2,
          right: 90,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) => const BottomSheet()));
            },
            child: Icon(Icons.camera_alt),
          ),
        ),
      ],
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  late PickedFile imageFile;
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  Future pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(
        () {
          pickedImage = tempImage;
        },
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.s10,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 130,top: 30),
      height: AppSizes.s10 * 0.15,
      child: Column(children: [
        const Text(
          "Choose image from",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: AppSizes.s10),
          child: Row(
            children: [
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera")),
              const SizedBox(
                width: 10,
              ),
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("from Gallery"))
            ],
          ),
        )
      ]),
    );
  }
}
