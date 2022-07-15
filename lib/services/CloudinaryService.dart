import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
class CloudinaryService{
  Future getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result;
    } else {
      // User canceled the picker
    }
  }

  Future uploadToCloudinary(ByteData byteData, String pdfName) async {
    final cloudinary = CloudinaryPublic('richkazz', 'eene8be4', cache: false);

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(byteData,
            identifier: pdfName, resourceType: CloudinaryResourceType.Auto),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    }
  }
}