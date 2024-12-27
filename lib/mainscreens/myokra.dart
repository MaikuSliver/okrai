// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:okrai/diagnose/care.dart';
import 'package:okrai/mainscreens/Harvest.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import '../database/db_helper.dart';
import 'Home.dart';
import 'dart:io';

class myokra extends StatefulWidget {
  const myokra({super.key});

  @override
  State<myokra> createState() => _myokraState();
}

class _myokraState extends State<myokra> {
  List<Map<String, dynamic>> _filteredDataList = [];
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _viewDataList = [];
  bool _isLoading = true;

  void _refreshJournals() async {
    setState(() {
      _isLoading = true;
    });
    final data = await DatabaseHelper.instance.queryDatabase();
    setState(() {
      _viewDataList = data ?? [];
      _filteredDataList = _viewDataList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  void _filterData(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredDataList = _viewDataList;
      } else {
        _filteredDataList = _viewDataList
            .where((item) =>
                item['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                item['email'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                item['pest'].toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'My Okra List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xff43c175),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                _filterData(query);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search by name, status, or pesticide',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _refreshJournals(); // Refresh when pulled down
              },
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 326,
                      ),
                      itemCount: _filteredDataList.length,
                      itemBuilder: (context, index) {
                        final id = _filteredDataList[index]['id'];
                        final imagepath = _filteredDataList[index]['pic'] as String?;
                        final name = _filteredDataList[index]['name'] as String;
                        final email = _filteredDataList[index]['email'] as String;
                        final pest = _filteredDataList[index]['pest'] as String;
                        final date = _filteredDataList[index]['contact'] as String;

                        return Container(
                          margin: const EdgeInsets.all(10),
                           decoration: BoxDecoration(
      border: Border.all(color: const Color(0xff43c175), width: 1), // Green border
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    child: Image(
                                      image: FileImage(File(imagepath!)),
                                      width: 150,
                                      height: 190,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'Name: $name',
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'Status: $email',
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.arrow_forward),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: care(
                                                    type: email,
                                                    img: imagepath,
                                                    id: id,
                                                    name: name,
                                                    pest: pest,
                                                    date: date,
                                                  ),
                                                ),
                                              );
                                            },
                                            color: const Color(0xff5ac46d),
                                            iconSize: 24,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              _confirmDelete(id);
                                            },
                                            color: const Color.fromARGB(255, 255, 0, 0),
                                            iconSize: 24,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: const Home()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.show_chart, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Harvest())),
              ),
              IconButton(
                icon: const Icon(Icons.energy_savings_leaf),
                color: const Color(0xff44c377),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: const myokra()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: const settings()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

void _confirmDelete(int id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this okra plant?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _deleteItem(id); // Call delete function
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

Future<void> _deleteItem(int id) async {
  await DatabaseHelper.instance.deleteRecord(id);
  await DatabaseHelper.instance.deleteProgress(id);
  _refreshJournals();

  // Show SnackBar for successful deletion
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        "Okra plant successfully deleted!",
        style: TextStyle(color: Colors.white), // White text color
      ),
      duration: const Duration(seconds: 2), // Duration of the SnackBar
      backgroundColor: const Color(0xff57c26b), // Green background color
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

}
