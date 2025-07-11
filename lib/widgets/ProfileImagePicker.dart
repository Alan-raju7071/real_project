import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilits/constants/colorconstant.dart';

class ProfileImagePicker extends StatelessWidget {
  final Uint8List? webImageBytes;
  final File? fileImage;
  final VoidCallback onPickImage;

  const ProfileImagePicker({
    super.key,
    required this.webImageBytes,
    required this.fileImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (webImageBytes != null) {
      imageProvider = MemoryImage(webImageBytes!);
    } else if (fileImage != null) {
      imageProvider = FileImage(fileImage!);
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colorconstants.grey300,
          backgroundImage: imageProvider,
          child: (imageProvider == null)
              ? const Icon(Icons.person, size: 50, color: Colorconstants.primarywhite)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: onPickImage,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colorconstants.primarywhite,
              ),
              child: const Icon(Icons.edit, size: 16, color: Colorconstants.primaryblack),
            ),
          ),
        ),
      ],
    );
  }
}
