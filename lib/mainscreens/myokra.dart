// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:okrai/diagnose/care.dart';
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
  List<Map<String, dynamic>> _filteredDataList = []; // For search results
  String _searchQuery = ""; // Store the search query
  final TextEditingController _searchController = TextEditingController(); // Controller for search bar
  List<Map<String, dynamic>> _viewDataList = [];
  bool _isLoading = true;

  void _refreshJournals() async {
    setState(() {
      _isLoading = true; // Show loading indicator while refreshing
    });
    final data = await DatabaseHelper.instance.queryDatabase();
    setState(() {
      _viewDataList = data ?? [];
      _filteredDataList = _viewDataList; // Initially, show all data
      _isLoading = false; // Hide loading indicator after refresh
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Initial data load
  }

// Method to filter the data based on the search query
  void _filterData(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredDataList = _viewDataList; // Show all data when search is empty
      } else {
        _filteredDataList = _viewDataList
            .where((item) =>
                item['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                item['email'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                item['pest'].toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList(); // Filter the data
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
        leading: const Icon(
        Icons.android,
        color: Color(0xff43c175),
        ),
        leadingWidth: 8,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _refreshJournals(); // Call refresh function when button is pressed
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
   
      body: Column(
        children: [
          // Search bar below the AppBar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                _filterData(query); // Filter the data on search query change
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search by name, status, or pest',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // List of data (filtered based on the search query)
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisExtent: 360, // Height of items
                    ),
                    itemCount: _filteredDataList.length, // Use filtered data
                    itemBuilder: (context, index) {
                      final id = _filteredDataList[index]['id'];
                      final imagepath = _filteredDataList[index]['pic'] as String?;
                      final name = _filteredDataList[index]['name'] as String;
                      final email = _filteredDataList[index]['email'] as String;
                      final pest = _filteredDataList[index]['pest'] as String;
                      final date = _filteredDataList[index]['contact'] as String;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: FileImage(File(imagepath!)),
                                width: 150,
                                height: 190,
                                fit: BoxFit.cover,
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
                                          _deleteItem(id);
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
                      );
                    },
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

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.instance.deleteRecord(id);
    await DatabaseHelper.instance.deleteProgress(id);
    _refreshJournals(); // Refresh the list after deleting
  }
}
