import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final picker = ImagePicker();

  Future<XFile?> getImage(ImageSource source) async {
    return await picker.pickImage(source: source);
  }

  Future<List<XFile>?> getImages() async {
    final files = await picker.pickMultiImage();
    return files.isNotEmpty ? files : null;
  }

  Future<Either<XFile, List<XFile>>?> showOptions(
    BuildContext context, {
    bool isMulti = false,
  }) async {
    if (isMulti) {
      final files = await getImages();
      return Right(files ?? []);
    }

    final file = await getImage(ImageSource.gallery);
    return file != null ? Left(file) : null;
  }

  Future<List<String>> uploadImage(
    BuildContext context, {
    bool isMulti = false,
  }) async {
    final result = await showOptions(context, isMulti: isMulti);
    if (result == null) return [];

    List<String> urls = [];

    if (result.isLeft()) {
      final file = result.fold((l) => l, (_) => null);
      if (file != null) {
        final url = await getImageUrl(file);
        urls.add(url);
      }
    } else {
      final files = result.fold((_) => null, (r) => r);
      if (files != null) {
        for (final file in files) {
          final url = await getImageUrl(file);
          urls.add(url);
        }
      }
    }

    return urls;
  }

  Future<String> getImageUrl(XFile file) async {
    final path = "images/${DateTime.now().millisecondsSinceEpoch}_${file.name}";
    final ref = FirebaseStorage.instance.ref().child(path);

    UploadTask uploadTask;

    final bytes = await file.readAsBytes();
    uploadTask = ref.putData(
      bytes,
      SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.name},
      ),
    );

    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
