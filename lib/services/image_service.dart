import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../core/constants/constants.dart';

class ImagePickRepository {
  static const url = "$apiUrl/bucket/upload-file";
  Future<String?> uploadImage() async {
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);

      var file = await _pickFile();
      if (file == null) return null;
      request.files.add(file);

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);

        log('FILE UPLOADED: ${responseJson['fileUrl']}');
        return responseJson['fileUrl'] as String;
      } else {
        final responseBody = await response.stream.bytesToString();
        log('Upload failed with status ${response.statusCode}: $responseBody');
        return null;
      }
    } catch (e) {
      log('Error uploading file: $e');
      return null;
    }
  }

  Future<http.MultipartFile?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'pdf',
        'doc',
        'docx',
        'xlsx'
      ],
    );

    if (result != null) {
      var file = result.files.single;
      var bytes = file.bytes;

      if (bytes == null) {
        throw Exception('Could not read file bytes');
      }

      return http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: file.name,
      );
    } else {
      return null;
    }
  }

  // Optional: Add a method to upload multiple files if needed
  Future<List<String>> uploadMultipleImages() async {
    try {
      List<String> uploadedUrls = [];
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'pdf',
          'doc',
          'docx',
          'xlsx'
        ],
      );

      if (result != null) {
        for (var file in result.files) {
          var uri = Uri.parse(url);
          var request = http.MultipartRequest('POST', uri);

          if (file.bytes != null) {
            request.files.add(http.MultipartFile.fromBytes(
              'file',
              file.bytes!,
              filename: file.name,
            ));

            var response = await request.send();

            if (response.statusCode == 200) {
              final responseBody = await response.stream.bytesToString();
              final responseJson = jsonDecode(responseBody);
              uploadedUrls.add(responseJson['fileUrl']);
            } else {
              throw Exception(
                  'Failed to upload file ${file.name}. Status Code: ${response.statusCode}');
            }
          }
        }
        return uploadedUrls;
      } else {
        throw Exception('No files selected');
      }
    } catch (e) {
      log('Error uploading multiple files: $e');
      rethrow;
    }
  }
}
