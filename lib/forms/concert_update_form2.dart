import 'package:eventend/classes/concert_class.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image/image.dart' as image_resized;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../providers/concert_create_provider.dart';
import '../utilities/personalization.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/put_form_text_widget.dart';
import '../widgets/snack_bar.dart';

class ConcertUpdateFormSecond extends StatefulWidget {
  final String concertPicture;
  final String id;
  const ConcertUpdateFormSecond(
      {required this.concertPicture, required this.id, super.key});

  @override
  State<ConcertUpdateFormSecond> createState() =>
      _ConcertUpdateFormSecondState();
}

class _ConcertUpdateFormSecondState extends State<ConcertUpdateFormSecond> {
  TextEditingController _fromHour = TextEditingController();
  TextEditingController _toHour = TextEditingController();
  TextEditingController _description = TextEditingController();
  @override
  void initState() {
    final ConcertCreateProvider concertProvider =
        Provider.of<ConcertCreateProvider>(context, listen: false);
    super.initState();
    _description = TextEditingController(text: concertProvider.description);
    _fromHour = TextEditingController(text: concertProvider.fromHour);
    _toHour = TextEditingController(text: concertProvider.toHour);
  }

  bool isImageSet = false;
  ImagePicker imgPicker = ImagePicker();
  Uint8List? resizedImage;
  File? fileImage;
  String? tempDirString;
  File? imgFile;
  bool? isSent;

  Future<void> getImageGallery() async {
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
    tempDirString = tempDir.path;
    final file =
        await File('${tempDir.path}/image.png').create(recursive: true);
    if (resizedImage != null) {
      file.writeAsBytesSync(resizedImage!);
    }
    setState(() {
      fileImage = file;
    });
  }

  Future<void> deleteImage() async {
    Directory dir = Directory(tempDirString!);
    dir.deleteSync(recursive: true);
    setState(() {
      fileImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ConcertCreateProvider concertAssignProvider =
        Provider.of<ConcertCreateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Concert', style: pageTitle),
        backgroundColor: ThemeApplication.lightTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ThemeApplication.lightTheme.backgroundColor2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.01
                        : 10),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Time in Hours(24-hour Format)',
                      style: headline1detail),
                )),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: PutTextFieldForProductWidget(
                        content: 'From:',
                        iconForForm: '',
                        initialValue: _fromHour,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: PutTextFieldForProductWidget(
                        content: 'To:',
                        iconForForm: '',
                        initialValue: _toHour,
                      ),
                    ),
                  ],
                ),
                PutTextFieldForProductWidget(
                  content: 'Description',
                  iconForForm: '',
                  initialValue: _description,
                ),
                const SizedBox(
                  height: 20,
                ),
                fileImage != null
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.7),
                            onPressed: () {
                              getImageGallery();
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Change Concert Image",
                                  style: headline2Profile,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.add_a_photo,
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                fileImage != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(fileImage!),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ],
                      )
                    : widget.concertPicture.isNotEmpty
                        ? SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              'https://eventend.pythonanywhere.com${widget.concertPicture}',
                              fit: BoxFit.fill,
                              height: 200,
                              width: 200,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: Text('Loading...'));
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Error Loading the image!'),
                            ),
                          )
                        : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                fileImage != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              color: ThemeApplication
                                  .lightTheme.backgroundColor2
                                  .withOpacity(0.7),
                              onPressed: () {
                                deleteImage();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      size: 24,
                                      color: ThemeApplication
                                          .lightTheme.backgroundColor,
                                    ),
                                    Text(
                                      "Delete Image",
                                      style: headline2Profile,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 70,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: ThemeApplication.lightTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () {
                  final concert = ConcertCreate(
                    title: concertAssignProvider.title,
                    eventDate: concertAssignProvider.eventDate,
                    fromHour: concertAssignProvider.fromHour,
                    toHour: concertAssignProvider.toHour,
                    location: concertAssignProvider.location,
                    description: concertAssignProvider.description,
                    price: concertAssignProvider.price,
                    webLink: concertAssignProvider.webLink,
                  );
                  sendPost(concert, context);
                },
                color: ThemeApplication.lightTheme.backgroundColor2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('POST', style: headline2Profile),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendPost(concert, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    const url = 'https://eventend.pythonanywhere.com/concert_update/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('PUT', uri);
    Map<String, String> headers = {"Authorization": "Token $token"};
    req.headers.addAll(headers);
    req.fields['id'] = widget.id;
    req.fields['title'] = concert.title;
    req.fields['event_date'] = concert.eventDate;
    req.fields['from_hour'] = concert.fromHour;
    req.fields['to_hour'] = concert.toHour;
    req.fields['location'] = concert.location;
    req.fields['long'] = '24.00000';
    req.fields['lat'] = '13.00000';
    req.fields['description'] = concert.description;
    req.fields['price'] = concert.price.toString();
    req.fields['web_link'] = concert.webLink;
    if (fileImage != null) {
      req.files.add(await http.MultipartFile.fromPath(
          'concert_picture', fileImage!.path));
    }
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 201) {
      isSent = true;
      if (isSent == true) {
        setState(() {
          Navigator.popUntil(
            context,
            ModalRoute.withName(Navigator.defaultRouteName),
          );

          SnackNotification.snackCaller(context, 'Successfully updated Post');
        });
      }
    } else {
      isSent = false;
    }
  }
}
