import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class ImagePickRepository {
  Future<List<String>> uploadImages() async {
    try {
      var uri = Uri.parse('');
      var request = http.MultipartRequest('POST', uri);

      var file = await _pickFile();
      request.files.add(file);

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);

        if (responseJson['status'] == 'success') {
          log('FILE UPLOADED');
          return List<String>.from(responseJson['data']);
        } else {
          throw Exception(
              'Failed to upload images: ${responseJson['message']}');
        }
      } else {
        throw Exception(
            'Failed to upload images. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<http.MultipartFile> _pickFile() async {
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
      file.extension;
      var bytes = file.bytes;

      return http.MultipartFile.fromBytes(
        'files',
        bytes!,
        filename: file.name,
      );
    } else {
      throw Exception('No file selected');
    }
  }
}
