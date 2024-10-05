
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
  





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('My Okra List', 
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)), 
      backgroundColor: const Color(0xff43c175),
      leading: const Icon(Icons.android, color:Color(0xff43c175),),
      leadingWidth: 8,
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
                  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: const Home()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.energy_savings_leaf),
                color: Colors.green,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: const myokra()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: const settings()));
                },
              ),
            ],
          ),
        ),
      ),
      body: 
      _isLoading? const Center(child: CircularProgressIndicator())
      :GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,   //no of columns
          mainAxisExtent: 360, //size
        ), 
        itemCount: _viewDataList.length,
        itemBuilder: (context, index){
          final id = _viewDataList[index]['id'];
          final imagepath = _viewDataList[index]['pic']as String?;
          final name = _viewDataList[index]['name'] as String;
          final email = _viewDataList[index]['email'] as String;
           final pest = _viewDataList[index]['pest'] as String;
           final date = _viewDataList[index]['contact'] as String; //status
    
return Card(        //box of each item call
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
     
        Image(
          image: FileImage(File(imagepath!)),
          width: MediaQuery.of(context).size.width,
          height: 190,
          ),
        Text(
          'Name: $name',
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, //... if the text is too long
          style: const TextStyle(fontSize: 15),
          ),
          Text(
          'Status: $email',
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, //... if the text is too long
          style: const TextStyle(fontSize: 15),
          ),
            Column(
  children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: care(
                        type: email,
                        img: imagepath,
                        id: id, 
                        name: name,
                        pest: pest,
                        date: date,
                        )));},
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
    ),)
);
        },
        ),
    );
  }
   Future<void> _deleteItem(int id) async {
    await DatabaseHelper.instance.deleteRecord(id);
    await DatabaseHelper.instance.deleteProgress(id);
    _refreshJournals(); // Refresh the list after deleting
  }
}
