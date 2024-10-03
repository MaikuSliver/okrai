
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'db_helper.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

/////////////////////////////////////////////////////////////
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
///////////////////////////////////////////////////////////////

  List<Map<String, dynamic>> _viewDataList = [];
  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await DatabaseHelper.instance.queryDatabase();
    setState(() {
      _viewDataList = data ?? [];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }
///////////////////////////////////////////////////////////////////////////////////////////
  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController updateEmailController = TextEditingController();//status
  final TextEditingController updateContactController = TextEditingController(); //date
  var updatePic;

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal = _viewDataList.firstWhere((element) => element['id'] == id);
      updatePic = existingJournal['pic'];
      updateNameController.text = existingJournal['name'];
      updateEmailController.text = existingJournal['email']; //status
      updateContactController.text = existingJournal['contact']; //date
    }


    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Center(
                child: InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(child: Image.file(File(updatePic))),
                  ),
                ),
              ),

              TextField(
                controller: updateNameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: updateEmailController,
                decoration: const InputDecoration(hintText: 'Email'), //status
              ),
              TextField(
                controller: updateContactController,
                decoration: const InputDecoration(hintText: 'Contact'), //date
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _updateItem(id);
                  updateNameController.text = '';
                  updateEmailController.text = ''; //status
                  updateContactController.text = ''; //date
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green, // Change text color
                ),
                child: Text(id == null ? 'Create New' : 'Update',
                  style: const TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateItem(int? id) async {
    if (_image != null) {
      // Save the image to the app's documents directory
      final appDocDir = await getApplicationDocumentsDirectory();
      final imagePath = '${appDocDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
      await _image!.copy(imagePath);

      await DatabaseHelper.instance.updateRecord(
        {



          DatabaseHelper.columnId: id,
          DatabaseHelper.columnImagePath: imagePath,
          DatabaseHelper.columnName: updateNameController.text,
          DatabaseHelper.columnEmail: updateEmailController.text,
          DatabaseHelper.columnContact: updateContactController.text,
        },
      );
    }
    _refreshJournals(); // Refresh the list after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("ViewPage update and delete"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _viewDataList.length,
        itemBuilder: (context, index) {
          final id = _viewDataList[index]['id'].toString();
          final imagepath = _viewDataList[index]['pic']as String?;
          final name = _viewDataList[index]['name'] as String?;
          final email = _viewDataList[index]['email'] as String?;

          return Card(
            margin: const EdgeInsets.all(15),
            child: ListTile(
              leading: CircleAvatar(
                radius: 17,
                child: imagepath != null
                    ? Image.file(
                  File(imagepath),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(
                  Icons.image,
                  size: 50,
                ),
              ),

              title: Text(name ?? 'No Name'),
              subtitle: Text(email ?? 'No Email'),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showForm(int.parse(id));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Implement delete functionality
                        // Call _deleteItem with the current id
                        _deleteItem(int.parse(id));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
          
        },
      ),
    );
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.instance.deleteRecord(id);
    _refreshJournals(); // Refresh the list after deleting
  }
}