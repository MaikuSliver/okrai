// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable
import 'dart:io';
//import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';
import '../database/db_helper.dart';
import '../mainscreens/myokra.dart';

class Update extends StatefulWidget {
  const Update({Key? key, 
    required this.id, 
    required this.name, 
    required this.type, 
    required this.img, 
    required this.pest, 
    required this.date}) : super(key: key);

  final int id;
  final String name;
  final String type;
  final String img;
  final String pest;
  final String date;

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late String okratype;
  late String okraimg;
  late int okraid;
  late String okraname;
  late String okrapest;
  late String okradate;

  var nameController = TextEditingController();
  var emailController = TextEditingController(); //status
  var contactController = TextEditingController(); //date
  var pestController = TextEditingController(); //pesticide
  var updatePic;

  String? okraPlantResult;
  late File _image;
  late List _results;
  bool imageSelect = false;
  bool isButtonEnabled = false; // State for button enabled/disabled

  void _validateForm() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          contactController.text.isNotEmpty &&
          pestController.text.isNotEmpty &&
          imageSelect && 
          okraPlantResult != "Unknown"; // Ensure the result is not "Unknown"
    });
  }

  @override
  void initState() {
    super.initState();
    okratype = widget.type;
    okraimg = widget.img;
    okraid =  widget.id;
    okraname = widget.name;
    okrapest = widget.pest;
    okradate = widget.date;

    nameController.text = okraname;
    pestController.text = okrapest;
    String todayDate = "${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}";
    contactController.text = todayDate; // Set today's date as the initial value

    nameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    contactController.addListener(_validateForm);
    pestController.addListener(_validateForm);

    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt"))!;
   // print("Models loading status: $res");
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

      if (_results.isNotEmpty) {
        okraPlantResult = _results[0]['label']; // Set the result label
      } else {
        okraPlantResult = "Unknown";
      }

      _validateForm(); // Validate form again after image classification
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        leadingWidth: 8,
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Center(
          child: Text(
            "Okrai Scan",
             style: TextStyle(color:Color(0xff44c377), fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xff63b36f), 
            onPressed: () {
              Navigator.pop(context);
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
            child: Container(
                margin: const EdgeInsets.all(10), // Adjust the margin as needed
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Add green border
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
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
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                        border: Border.all(
              color: const Color(0xff44c377), // Green border
              width: 1,
                        ),
                      ),
                          child: ListView(
                            children: [
                              (imageSelect) ? 
                              Container(
                                margin: const EdgeInsets.all(5), // Reduced margin
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
                                    okraPlantResult = result['label'];
                                    return Card(
  child: Container(
    padding: const EdgeInsets.all(10), // Add padding for better appearance
    decoration: BoxDecoration(
      color: result['label'] == 'Healthy' 
          ? const Color(0xff44c377) // Green background
          : const Color(0xffff0000), // Red background
      borderRadius: BorderRadius.circular(12), // Curved edges
    ),
    child: Center(
      child: Text(
        'Your okra plant result is ${result['label']}!',
        style: const TextStyle(
          color: Colors.white, // White text
          fontSize: 20,
        ),
        textAlign: TextAlign.center, // Center the text
      ),
    ),
  ),
);
                                  }).toList() : [],
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(15),
                                  child: TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                    hintText: "Name",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44c377), // Green border
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44c377),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(15),
                                  child: TextField(
                                    controller: pestController,
                                    decoration: const InputDecoration(
                                    hintText: "Use Pesticide",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44c377), // Green border
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44c377),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(15),
                                child: TextFormField(
                                  controller: contactController,
                                  decoration: const InputDecoration(
                                    hintText: "Date",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44c377), // Green border
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44c377),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
              
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
                                      setState(() {
                                        contactController.text =
                                            formattedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                                 Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(15),
                              child: const Text(
            'Note: Please ensure that the okra leaf is fully captured in the photo to obtain accurate results.'),
                            ),
                            ],
                          ),
                        ),

                      ),
                    ],
                  ),
                  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                margin: const EdgeInsets.only(top: 10), // Margin added here
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          // Save the image to the app's documents directory
                          final appDocDir = await getApplicationDocumentsDirectory();
                          final imagePath = '${appDocDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
                          await _image.copy(imagePath);
                
                          // Insert record into SQLite with the image path
                          await DatabaseHelper.instance.updateRecord({
                            DatabaseHelper.columnId: okraid,
                            DatabaseHelper.columnName: nameController.text,
                            DatabaseHelper.columnEmail: okraPlantResult, // status
                            DatabaseHelper.columnContact: contactController.text, // date
                            DatabaseHelper.columnImagePath: imagePath,
                            DatabaseHelper.columnPest: pestController.text,
                          });
                
                          await DatabaseHelper.instance.insertProgress({
                            DatabaseHelper.plantId: okraid,  // Use the new plant ID here
                            DatabaseHelper.progressDate: contactController.text, // date
                            DatabaseHelper.progressImages: imagePath,
                            DatabaseHelper.progressPest: pestController.text,
                          });
                
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Plant updated successfully!',
                                style: TextStyle(color: Colors.white), // White text color
                              ),
                              duration: const Duration(seconds: 3),
                              backgroundColor: const Color(0xff57c26b), // Green background color
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                
                           Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(type: PageTransitionType.fade, child: const myokra()),
                  (Route<dynamic> route) => false, // Removes all previous routes
                );
                        }
                      : null, // Disable if form is invalid
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonEnabled
                        ? const Color(0xff57c26b)
                        : Colors.grey, // Change color based on state
                  ),
                  child: const Text(
                    "Update this Plant",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  // Future<void> pickImageWithPermission() async {
  //   PermissionStatus cameraPermissionStatus = await Permission.camera.status;
  //   PermissionStatus storagePermissionStatus = await Permission.storage.status;

  //   if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
  //     // Permissions are already granted, proceed to pick file
  //     pickImageC();
  //     pickImage();
  //   } else {
  //     Map<Permission, PermissionStatus> permissionStatuses = await [
  //       Permission.camera,
  //       Permission.storage,
  //     ].request();

  //     if (permissionStatuses[Permission.camera]!.isGranted &&
  //         permissionStatuses[Permission.storage]!.isGranted) {
  //       // Permissions granted, proceed to pick file
  //       pickImageC();
  //       pickImage();
  //     } else {
  //       // Permissions denied, handle accordingly (show an error message, request again, or emit your bloc state.)
  //       // ...
  //     }
  //   }
  // }

