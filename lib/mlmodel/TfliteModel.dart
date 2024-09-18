import 'dart:io';
import 'package:okrai/mainscreens/Home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:page_transition/page_transition.dart';
import '../mainscreens/myokra.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {

  late File _image;
  late List _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assextts/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 0.0,
      imageStd: 1.0,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }
  Future<void> pickImageWithPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    PermissionStatus storagePermissionStatus = await Permission.storage.status;

    if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
      // Permissions are already granted, proceed to pick file
      pickImageC();
      pickImage();
    } else {
      Map<Permission, PermissionStatus> permissionStatuses = await [
        Permission.camera,
        Permission.storage,
      ].request();

      if (permissionStatuses[Permission.camera]!.isGranted &&
          permissionStatuses[Permission.storage]!.isGranted) {
        // Permissions granted, proceed to pick file
        pickImageC();
        pickImage();
      } else {
        // Permissions denied, handle accordingly (show an error message, request again, or emit your bloc state.)
        // ...
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Okrai Scan",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff58c36c),
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),color: const Color(0xff63b36f), onPressed: () {
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Home()));
        }
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(0),
              shrinkWrap: false,
              physics: const ScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: pickImage,
                        color: const Color(0xff57c26b),
                        iconSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        icon: const Icon(Icons.photo_camera),
                        onPressed: pickImageC,
                        color: const Color(0xff59be6c),
                        iconSize: 24,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        width: 200,
                        height: 450,
                        decoration: BoxDecoration(
                          color: const Color(0x1f000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                          border:
                          Border.all(color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: ListView(
                          children: [
                            (imageSelect) ? Container(
                              margin: const EdgeInsets.all(10),
                              child: Image.file(_image),
                            ) : Container(
                              margin: const EdgeInsets.all(10),
                              child: const Opacity(
                                opacity: 0.8,
                                child: Center(
                                  child: Text("No image selected"),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: (imageSelect) ? _results.map((result) {
                                  return Card(
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Text(
                                        "Your okra plant result is ${result['label']} with ${result['confidence'].toStringAsFixed(2)}",
                                        style: const TextStyle(color: Colors.black,
                                            fontSize: 20),
                                      ),
                                    ),
                                  );
                                }).toList() : [],

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Align(
                          alignment: const Alignment(0.0, 0.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const myokra()));
                            },
                            color: const Color(0xff67bb74),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              side: const BorderSide(
                                  color: Color(0xff808080), width: 1),
                            ),
                            padding: const EdgeInsets.all(16),
                            textColor: const Color(0xffffffff),
                            height: 40,
                            minWidth: 140,
                            child: const Text(
                              "Add this Plant",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,maxHeight: 400, maxWidth: 400
    );
    File images = File(image!.path);
    imageClassification(images);
  }

  Future pickImageC() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera, maxHeight: 400, maxWidth: 400
    );
    File imageC = File(photo!.path);
    imageClassification(imageC);
  }
}