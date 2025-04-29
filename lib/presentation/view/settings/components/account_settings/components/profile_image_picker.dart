import 'package:flutter/material.dart';

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
    return Column(
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
            try {
              final image = await imagePickerService.uploadImage();
              if (image != null) {
                onImageChanged(image);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to upload image: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
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
            // Network image with error handling
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
            // Overlay for hover effect
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
