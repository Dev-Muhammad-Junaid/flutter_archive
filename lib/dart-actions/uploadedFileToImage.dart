import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Future<String?> convertUploadedFileToImage(File? uploadedFile) async {
  if (uploadedFile == null || uploadedFile.bytes == null) {
    return null;
  }
  final Uint8List bytes = uploadedFile.bytes!;
  final String base64Image = base64Encode(bytes);
  return base64Image;
}

