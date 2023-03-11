import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image/image.dart' as image_resized;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageSelector {
  bool isImageSet = false;
  ImagePicker imgPicker = ImagePicker();
  late Uint8List resizedImage;

  File? imgFile;
  Future<File> getImageGallery() async {
    var pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imgFile = File(pickedFile.path);
      final image =
          image_resized.decodeImage(io.File(pickedFile.path).readAsBytesSync());
      final resizeImage = image_resized.copyResize(
        image!,
        width: 400,
        height: 400,
      );
      resizedImage = Uint8List.fromList(image_resized.encodePng(resizeImage));
      isImageSet = true;
    } else {}
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(resizedImage);
    return file;
  }
}
