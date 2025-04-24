import 'package:flutter/material.dart';

import '../../../../../../core/styles/app_images.dart';
import '../../../../../../initializer.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker(
      {super.key, this.image, required this.onImageChanged});
  final String? image;
  final Function(String) onImageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Profile Picture',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final image = await imagePickerService.uploadImage();
            if (image != null) {
              onImageChanged(image);
            }
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                style: BorderStyle.solid,
              ),
              color: Colors.grey[100],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image != null
                      ? Image.network(
                          "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png")
                      : Image.asset(AppImages.gallery),
                  const SizedBox(height: 8),
                  if (image == null)
                    Text(
                      'Upload your\nphoto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
