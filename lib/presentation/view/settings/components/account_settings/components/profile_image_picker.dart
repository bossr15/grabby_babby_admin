import 'package:flutter/material.dart';

import '../../../../../../core/styles/app_color.dart';
import '../../../../../../core/styles/app_images.dart';
import '../../../../../../initializer.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    super.key,
    this.image,
    required this.onImageChanged,
    this.title,
    this.size = 120.0,
  });

  final String? image;
  final Function(String) onImageChanged;
  final String? title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title ?? 'Your Profile Picture',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (title != null) const SizedBox(height: 8),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                final image = await imagePickerService.uploadImage(context);
                if (image.isNotEmpty) {
                  onImageChanged(image.first);
                }
              },
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                  color: Colors.grey[100],
                ),
                child: _buildImageContent(),
              ),
            ),
          ],
        ),
        if (image != null)
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                final image = await imagePickerService.uploadImage(context);
                if (image.isNotEmpty) {
                  onImageChanged(image.first);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.darkBlue.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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

  Widget _buildImageContent() {
    if (image == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.gallery,
            width: size * 0.4,
            height: size * 0.4,
          ),
          const SizedBox(height: 8),
          Text(
            'Upload your\nphoto',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              image!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    width: size * 0.3,
                    height: size * 0.3,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[400],
                        size: size * 0.3,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Failed to load\nimage',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap:
                      () {}, // This is just for hover effect, actual onTap is on parent
                  hoverColor: Colors.black.withOpacity(0.3),
                  splashColor: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Opacity(
                      opacity: 0.0, // Only visible on hover
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: size * 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
