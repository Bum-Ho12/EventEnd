import 'package:eventend/providers/service_create_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/service_class.dart';
import '../utilities/personalization.dart';
import '../widgets/service_post_text_widget.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  late final String name;
  late final String about;
  late final double price;
  late final String portfolio;
  late final String location;
  PlatformFile? permit;
  bool? isPicked;
  bool? isSent;
  Future<void> getPermit() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (file != null) {
      permit = file.files.first;
      setState(() {
        isPicked = true;
      });
    }
  }

  Future<void> deletePermit() async {
    setState(() {
      permit = null;
      isPicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ServiceCreateProvider serviceAssignProvider =
        Provider.of<ServiceCreateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Service', style: pageTitle),
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
      body: Center(
        child: Padding(
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
                            : 20),
                    const ServiceTextFieldForProductWidget(
                      content: 'Title',
                      iconForForm: '',
                    ),
                    const ServiceTextFieldForProductWidget(
                      content: 'Website/Portfolio',
                      iconForForm: '',
                    ),
                    const ServiceTextFieldForProductWidget(
                      content: 'Price',
                      iconForForm: '',
                    ),
                    const ServiceTextFieldForProductWidget(
                      content: 'Description',
                      iconForForm: '',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isPicked == true
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2
                                    .withOpacity(0.7),
                                onPressed: () {
                                  getPermit();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Add Permit or supporting file",
                                      style: headline2Profile,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.attach_file,
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
                    isPicked == true
                        ? Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 0.2,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2
                                    .withOpacity(0.1),
                              ),
                            ),
                            child: Text(
                              '${permit!.name}.${permit!.extension}',
                              style: commonText,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    isPicked == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor2
                                      .withOpacity(0.7),
                                  onPressed: () {
                                    deletePermit();
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
                                          "Delete File",
                                          style: headline2Profile,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        : const SizedBox(),
                  ]),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: ThemeApplication.lightTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  final concert = ServiceCreate(
                    title: serviceAssignProvider.title,
                    description: serviceAssignProvider.description,
                    price: serviceAssignProvider.price,
                    webLink: serviceAssignProvider.webLink,
                  );
                  sendPost(concert);
                  if (isSent == true) {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(Navigator.defaultRouteName),
                    );
                  }
                },
                color: ThemeApplication.lightTheme.backgroundColor2,
                child: Text('Post', style: headline2Profile),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendPost(concert) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    const url = 'https://eventend.pythonanywhere.com/service_create/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('POST', uri);
    Map<String, String> headers = {"Authorization": "Token $token"};
    req.headers.addAll(headers);
    req.fields['title'] = concert.title;
    req.fields['long'] = '24.00000';
    req.fields['lat'] = '13.00000';
    req.fields['description'] = concert.description;
    req.fields['price'] = concert.price.toString();
    req.fields['web_link'] = concert.webLink;
    if (permit != null) {
      req.files.add(await http.MultipartFile.fromPath('permit', permit!.path!));
    }
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 201) {
      isSent = true;
    } else {
      isSent = false;
    }
  }
}
