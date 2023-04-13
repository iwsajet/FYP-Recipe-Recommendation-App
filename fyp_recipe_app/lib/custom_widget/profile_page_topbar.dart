import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_response.dart';

class ProfileTopBar extends StatefulWidget {
  const ProfileTopBar({
    super.key,
  });

  @override
  State<ProfileTopBar> createState() => _ProfileTopBarState();
}

class _ProfileTopBarState extends State<ProfileTopBar> {
  late String username = '';

  late String pickedImage = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
      pickedImage = prefs.getString('imagePath') ?? '';
    });
  }

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = pickedFile.path;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', pickedFile.path);
    }
  }

  Future<void> _editusername() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: username);
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        username = result;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, value, child) {
      if (value.loginResponse.status == Status.success) {
        final users = value.loginResponse.data!;

        return Stack(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: pickedImage.isNotEmpty
                      ? FileImage(File(pickedImage))
                      : const NetworkImage(
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80')
                          as ImageProvider<Object>,
                ),
                Positioned(
                  bottom: 1,
                  right: 50,
                  child: InkWell(
                    onDoubleTap: _selectImage,
                    // onTap: () {
                    //   showModalBottomSheet(
                    //       context: context,
                    //       builder: ((builder) => const BottomSheet()));
                    // },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        users.fullname,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 95),
                  child: Row(children: [
                    Column(
                      children: [
                        Text(
                          'Username: $username',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: _editusername,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ))
                  ]),
                )
              ],
            ),
          ],
        );
      }
      return  Stack(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: pickedImage.isNotEmpty
                      ? FileImage(File(pickedImage))
                      : const NetworkImage(
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80')
                          as ImageProvider<Object>,
                ),
                Positioned(
                  bottom: 1,
                  right: 50,
                  child: InkWell(
                    onDoubleTap: _selectImage,
                    // onTap: () {
                    //   showModalBottomSheet(
                    //       context: context,
                    //       builder: ((builder) => const BottomSheet()));
                    // },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: const [
                      Text(
                        "Guest",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 95),
                  child: Row(children: [
                    Column(
                      children: [
                        Text(
                          'Username: $username',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: _editusername,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ))
                  ]),
                )
              ],
            ),
          ],
        );
    });
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  late PickedFile imageFile;

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
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 130, top: 30),
      height: AppSizes.s10 * 11,
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
