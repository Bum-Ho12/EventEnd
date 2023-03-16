import 'package:eventend/providers/service_create_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/service_class.dart';
import '../utilities/personalization.dart';
import '../widgets/service_put_form_text_widget.dart';
import '../widgets/snack_bar.dart';

class UpdateService extends StatefulWidget {
  final String id;
  final String permit;
  const UpdateService({required this.id, required this.permit, super.key});

  @override
  State<UpdateService> createState() => _UpdateServiceState();
}

class _UpdateServiceState extends State<UpdateService> {
  PlatformFile? permit;
  bool? isPicked;
  bool? isSent;
  TextEditingController _description = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _webLink = TextEditingController();
  @override
  void initState() {
    final ServiceCreateProvider serviceProvider =
        Provider.of<ServiceCreateProvider>(context, listen: false);
    super.initState();
    _description = TextEditingController(text: serviceProvider.description);
    _title = TextEditingController(text: serviceProvider.title);
    _price = TextEditingController(text: serviceProvider.price.toString());
    _webLink = TextEditingController(text: serviceProvider.webLink);
  }

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
        title: Text('Update Service', style: pageTitle),
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
                    PutServiceTextFieldForProductWidget(
                      content: 'Title',
                      iconForForm: '',
                      controller: _title,
                    ),
                    PutServiceTextFieldForProductWidget(
                      content: 'Website/Portfolio',
                      iconForForm: '',
                      controller: _webLink,
                    ),
                    PutServiceTextFieldForProductWidget(
                        content: 'Price', iconForForm: '', controller: _price),
                    PutServiceTextFieldForProductWidget(
                      content: 'Description',
                      iconForForm: '',
                      controller: _description,
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
                                      "Change Permit or file",
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
                        : widget.permit.isNotEmpty
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
                                  widget.permit,
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
                  sendPost(concert, context);
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

  Future<void> sendPost(service, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    const url = 'https://eventend.pythonanywhere.com/service_update/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('PUT', uri);
    Map<String, String> headers = {"Authorization": "Token $token"};
    req.headers.addAll(headers);
    req.fields['id'] = widget.id;
    req.fields['title'] = service.title;
    req.fields['long'] = '24.00000';
    req.fields['lat'] = '13.00000';
    req.fields['description'] = service.description;
    req.fields['price'] = service.price.toString();
    req.fields['web_link'] = service.webLink;
    if (permit != null) {
      req.files.add(await http.MultipartFile.fromPath('permit', permit!.path!));
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
