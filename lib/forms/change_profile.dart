import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image/image.dart' as image_resized;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eventend/utilities/day_selector.dart';
import 'package:eventend/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/user_class.dart';
import '../utilities/personalization.dart';
import '../widgets/text_description_form.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ChangeProfile extends StatefulWidget {
  final Account account;
  const ChangeProfile({required this.account, super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

enum Category { individual, organization }

class _ChangeProfileState extends State<ChangeProfile> {
  bool changeName = false;
  bool changeEmail = false;
  bool changeProfileLink = false;
  bool changeLocation = false;
  bool changePhone = false;
  bool changeWebsite = false;
  bool openDays = false;
  bool changeDescription = false;
  DayIdentifier dayIdentifier = DayIdentifier();
  Category? _category;
  int? categoryOption;
  bool isImageSet = false;
  ImagePicker imgPicker = ImagePicker();
  Uint8List? resizedImage;
  File? fileImage;
  String? tempDirString;

  File? imgFile;
  Future<void> getImageGallery() async {
    if (tempDirString != null) {
      Directory dir = Directory(tempDirString!);
      dir.deleteSync(recursive: true);
    }
    setState(() {
      fileImage = null;
      imgFile = null;
    });
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
    final file = await File('${tempDir.path}/image.png').create();
    if (resizedImage != null) {
      file.writeAsBytesSync(resizedImage!);
    }
    setState(() {
      fileImage = file;
    });
  }

  updateProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    var url = Uri.parse("https://eventend.pythonanywhere.com/user_update/");
    final req = http.MultipartRequest('PUT', url);
    Map<String, String> headers = {
      "Authorization": "Token ${widget.account.token}"
    };
    req.headers.addAll(headers);
    req.fields['email'] = sharedPreferences.getString("email")!;
    req.fields['username'] = sharedPreferences.getString("username")!;
    req.fields['category'] = categoryOption.toString();
    req.fields['weekday_from'] =
        sharedPreferences.getInt("weekday_from")!.toString();
    req.fields['weekday_to'] =
        sharedPreferences.getInt("weekday_to")!.toString();
    req.fields['location'] = sharedPreferences.getString("location")!;
    req.fields['from_hour'] = sharedPreferences.getString("from_hour")!;
    req.fields['to_hour'] = sharedPreferences.getString("to_hour")!;
    req.fields['social_media_link'] =
        sharedPreferences.getString("social_media_link")!;
    req.fields['description'] = sharedPreferences.getString("description")!;
    req.fields['phone_number'] = sharedPreferences.getString("phone_number")!;
    req.fields['long'] = sharedPreferences.getDouble("long")!.toString();
    req.fields['lat'] = sharedPreferences.getDouble("lat")!.toString();
    if (fileImage != null) {
      req.files.add(await http.MultipartFile.fromPath(
          'profile_picture', fileImage!.path));
    }

    try {
      final res = await req.send();
      var response = await http.Response.fromStream(res);
      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse != null) {
          sharedPreferences.setString("token", jsonResponse['token']);
          sharedPreferences.setString("email", jsonResponse['email']);
          sharedPreferences.setString("username", jsonResponse['username']);
          sharedPreferences.setInt("category", jsonResponse['category']);
          sharedPreferences.setInt(
              "weekday_from", jsonResponse['weekday_from']);
          sharedPreferences.setInt("weekday_to", jsonResponse['weekday_to']);
          sharedPreferences.setString("location", jsonResponse['location']);
          sharedPreferences.setString("from_hour", jsonResponse['from_hour']);
          sharedPreferences.setString("to_hour", jsonResponse['to_hour']);
          sharedPreferences.setString(
              "social_media_link", jsonResponse['social_media_link']);
          sharedPreferences.setString(
              "description", jsonResponse['description']);
          sharedPreferences.setString(
              "phone_number", jsonResponse['phone_number']);
          sharedPreferences.setDouble("long", jsonResponse['long']);
          sharedPreferences.setDouble("lat", jsonResponse['lat']);

          sharedPreferences.setString(
              'profile_picture', jsonResponse['profile_picture']);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      } else {}
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    String weekDayFrom = dayIdentifier.getDay((widget.account.weekdayFrom));
    String weekDayTo = dayIdentifier.getDay(widget.account.weekdayTo);
    String categoryChosen =
        widget.account.category == 1 ? 'Individual' : 'Organization';
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Profile', style: pageTitle),
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
      bottomSheet: Container(
        color: ThemeApplication.lightTheme.backgroundColor,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ThemeApplication.lightTheme.backgroundColor2
                    .withOpacity(0.7),
                onPressed: () {
                  categoryOption ??= widget.account.category;
                  updateProfile();
                },
                child: Text(
                  "Update",
                  style: headline2Profile,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        thickness: 10,
        radius: const Radius.circular(5),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: MediaQuery.of(context).size.width * 0.5 - 70.5,
                        child:
                            //image option for change
                            Builder(builder: (context) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(369),
                                child: isImageSet == false
                                    ? widget.account.profilePicture != ''
                                        ? Image.network(
                                            'https://eventend.pythonanywhere.com${widget.account.profilePicture}',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                  child: Text('Loading...'));
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                              Icons.person,
                                              size: 100,
                                            ),
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: ThemeApplication
                                                .lightTheme.backgroundColor2
                                                .withOpacity(0.6),
                                            size: 100,
                                          )
                                    : imgFile == null
                                        ? Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                2, 5, 2, 3),
                                            child: ClipOval(
                                                child: Material(
                                              color: ThemeApplication
                                                  .lightTheme.backgroundColor
                                                  .withOpacity(0.3),
                                              child: Icon(
                                                Icons.person,
                                                size: 100,
                                                color: ThemeApplication
                                                    .lightTheme
                                                    .backgroundColor2,
                                              ),
                                            )),
                                          )
                                        : Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              image: DecorationImage(
                                                  image: FileImage(fileImage!),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                              ),
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: ThemeApplication
                                          .lightTheme.backgroundColor2,
                                      borderRadius: BorderRadius.circular(80)),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          getImageGallery();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: ThemeApplication
                                            .lightTheme.backgroundColor,
                                        size: 22,
                                      )),
                                ),
                              )
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        widget.account.name,
                        style: headline1,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          changeName = !changeName;
                        });
                      },
                      icon: changeName == true
                          ? Icon(
                              Icons.close,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            )
                          : Icon(
                              Icons.edit_outlined,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: changeName == false
                      ? const SizedBox()
                      : FormTextWidget(
                          data: widget.account.name,
                          fromType: 'name',
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          widget.account.socialMediaLink,
                          style: headline2detail,
                          maxLines: 3,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changeProfileLink = !changeProfileLink;
                          });
                        },
                        icon: changeProfileLink == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: changeProfileLink == false
                      ? const SizedBox()
                      : FormTextWidget(
                          data: widget.account.socialMediaLink,
                          fromType: 'media_link'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.7),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Account Email Address',
                        style: headline1detail,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changeEmail = !changeEmail;
                          });
                        },
                        icon: changeEmail == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.account.email,
                        style: headline2Detail,
                      ),
                      changeEmail == false
                          ? const SizedBox()
                          : FormTextWidget(
                              data: widget.account.email, fromType: 'email'),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.access_time,
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.7),
                  ),
                  title: Text(
                    'Category',
                    style: headline1detail,
                  ),
                  subtitle: Text(
                    categoryChosen,
                    style: headline2Detail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<Category>(
                          contentPadding: EdgeInsets.zero,
                          value: Category.individual,
                          dense: true,
                          tileColor: ThemeApplication.lightTheme.backgroundColor
                              .withOpacity(0.5),
                          groupValue: _category,
                          activeColor:
                              ThemeApplication.lightTheme.backgroundColor2,
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                              categoryOption = 1;
                            });
                          },
                          title: Text(
                            'Individual',
                            style: headlineForTile,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<Category>(
                          contentPadding: EdgeInsets.zero,
                          value: Category.organization,
                          groupValue: _category,
                          activeColor:
                              ThemeApplication.lightTheme.backgroundColor2,
                          dense: true,
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                              categoryOption = 2;
                            });
                          },
                          tileColor: ThemeApplication.lightTheme.backgroundColor
                              .withOpacity(0.5),
                          title: Text(
                            'Organization',
                            style: headlineForTile,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.access_time,
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.7),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Open Days',
                        style: headline1detail,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            openDays = !openDays;
                          });
                        },
                        icon: openDays == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$weekDayFrom - '
                        '$weekDayTo',
                        style: headline2Detail,
                      ),
                      openDays == false
                          ? const SizedBox()
                          : Column(
                              children: [
                                FormTextWidget(
                                    data: weekDayFrom, fromType: 'weekday'),
                                const SizedBox(
                                  height: 2,
                                ),
                                FormTextWidget(
                                    data: weekDayTo, fromType: 'weekdayTo'),
                              ],
                            ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${widget.account.fromHour} - ${widget.account.toHour}',
                        style: headline2Detail,
                      ),
                      openDays == false
                          ? const SizedBox()
                          : Column(
                              children: [
                                FormTextWidget(
                                    data: widget.account.fromHour,
                                    fromType: 'hour'),
                                const SizedBox(
                                  height: 2,
                                ),
                                FormTextWidget(
                                    data: widget.account.toHour,
                                    fromType: 'hour_to'),
                              ],
                            ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.7),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Business Location',
                        style: headline1detail,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changeLocation = !changeLocation;
                          });
                        },
                        icon: changeLocation == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.account.location,
                        style: headline2Detail,
                      ),
                      changeLocation == false
                          ? const SizedBox()
                          : FormTextWidget(
                              data: widget.account.location,
                              fromType: 'location'),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.call,
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.7),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: headline1detail,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changePhone = !changePhone;
                          });
                        },
                        icon: changePhone == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.account.phoneNumber,
                        style: headline2Detail,
                      ),
                      changePhone == false
                          ? const SizedBox()
                          : FormTextWidget(
                              data: widget.account.phoneNumber,
                              fromType: 'phone_number'),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.web,
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.7),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Website Link',
                        style: headline1detail,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changeWebsite = !changeWebsite;
                          });
                        },
                        icon: changeWebsite == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.account.long.toString(),
                        style: headline2Detail,
                      ),
                      changeWebsite == false
                          ? const SizedBox()
                          : FormTextWidget(
                              data: widget.account.long, fromType: 'long'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Text(
                          'Brief Description',
                          style: headline1,
                          maxLines: 6,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              changeDescription = !changeDescription;
                            });
                          },
                          icon: changeDescription == true
                              ? Icon(
                                  Icons.close,
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor2,
                                )
                              : Icon(
                                  Icons.edit_outlined,
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor2,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.account.description,
                    style: commonTextMain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: changeDescription == false
                      ? const SizedBox()
                      : DescriptionFormTextWidget(
                          data: widget.account.description,
                        ),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
