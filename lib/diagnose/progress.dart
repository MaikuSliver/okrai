import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:okrai/mlmodel/update.dart';
import 'package:page_transition/page_transition.dart';

import '../database/db_helper.dart';

class Progress extends StatefulWidget {
  const Progress({super.key, 
  required this.id, 
  required this.name, 
  required this.type, 
  required this.img, 
  required this.pest, 
  required this.date, 
  required this.progresshealth});

final int id;
final String name;
final String type;
final String img;
final String pest;
final String date;
final double progresshealth;

  @override
  State<Progress> createState() => _ProgressState();
}



class _ProgressState extends State<Progress> {

   List<Map<String, dynamic>> _viewDataList = [];
  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await DatabaseHelper.instance.queryProgress(okraid);
    setState(() {
      _viewDataList = data ?? [];
      _isLoading = false;
    });
  }
  
late String okratype;
late String okraimg;
late int okraid;
late String okraname;
late String okrapest;
late String okradate;
late double okraprogress;
late double okrapercent;

@override
  void initState() {
    super.initState();
    okratype = widget.type;
    okraimg = widget.img;
    okraid =  widget.id;
    okraname = widget.name;
    okrapest = widget.pest;
    okradate = widget.date;
    okraprogress = widget.progresshealth;
    okrapercent =widget.progresshealth*100;
     _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Center(
        child: Text('Heal Progress', 
          style: TextStyle(color:Color(0xff63b36f), fontWeight: FontWeight.bold),),
      ),
      backgroundColor:Colors.white ,
      leading: IconButton(
  icon: 
  const Icon(Icons.arrow_back),color: const Color(0xff63b36f), onPressed: () {Navigator.pop(context);
},
), leadingWidth: 8,),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
              margin: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Center(
                   child: SizedBox(
                     height: 170, // Sets the height of the Circular Progress container
                     width: 170, // Sets the width of the Circular Progress container
                     child: Stack(
                       alignment: Alignment.center, // Centers all children inside the Stack
                       children: [
                         SizedBox(
                           height: 150, // Sets the radius of the circular progress
                           width: 150,
                           child: CircularProgressIndicator(
                             value: okraprogress, // Sets the progress value (0.0 to 1.0)
                             strokeWidth: 15, // Sets the circle width
                             backgroundColor: Colors.black26,
                             valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff63b36f)),
                           ),
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Icon(
                               Icons.sentiment_very_satisfied,
                               color: Color(0xff63b36f),
                               size:40,
                             ),
                             const SizedBox(height: 8),
                             Text(
                               '${okrapercent.toString()}%',
                               style: const TextStyle(
                                 color: Color(0xff63b36f),
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20,
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
              const SizedBox(height: 10,),
              const Center(child: Text('Great! Keep it up', style: TextStyle(fontWeight: FontWeight.bold),)),
               const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15) ,
                child: const Column(
                  children: [
                    Text('Logs', style: TextStyle(fontWeight: FontWeight.bold,),
                    ),
                  ],
                )
                ),
                    Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                  GFItemsCarousel(
  rowCount: 3, // Display 3 images per row
  children: _viewDataList.map((data) {
    String imagePath = data['images']; // Get the image path from data
    String date = data['date']; // Assuming you have a date key in your data
   //  String idplant = data['plantid'].toString(); 
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          _isLoading
            ? const CircularProgressIndicator():
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.file(
              File(imagePath), // Display the image using File
              fit: BoxFit.cover,
               width: 150,
          height: 170,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0, // Align to the left
            right: 0, // Align to the right
            child: Container(
              color: Colors.black54, // Background color for better readability
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.center, // Center the text
              child: Text(
                date, // Display the date
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }).toList(),
),
                  ],
                ),
              ),
                   Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  const Text(
                    'Pesticides Used',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._viewDataList.map((data) {
                    String pesticide = data[DatabaseHelper.progressPest] ?? "No pesticide used"; // Get pesticide data
                     String date = data[DatabaseHelper.progressDate] ?? "No pesticide used"; // Get pesticide data
                    return ListTile(
                      title: Center(
                        child: Text(
                          pesticide,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      leading: Text(date,
                          style: const TextStyle(color: Colors.black),), // Optional icon
                    );
                  }).toList(),
                ],
              ),
            ),
             Padding(
padding:const EdgeInsets.all(16),
child:Align(
alignment:Alignment.bottomCenter,
child:MaterialButton(
  onPressed: () {
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Update(
      id:okraid,
      name:okraname,
      type:okratype,
      img:okraimg,
      pest:okrapest,
      date:okradate,
    )));
  },
color:const Color(0xff67bd74),
elevation:0,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(12.0),
side:const BorderSide(color:Color(0xffffffff),width:1),
),
padding:const EdgeInsets.all(16),
textColor:const Color(0xffffffff),
height:50,
minWidth:MediaQuery.of(context).size.width,
child:const Text("Update Status", style: TextStyle( fontSize:16,
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
),),
),
),
),

              ],
            ),
          ),
      ),
    );
  }
}