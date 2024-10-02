
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:okrai/diagnose/care.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:okrai/okraimodels/okra.dart';
import 'package:okrai/okraimodels/okralist.dart';
import 'package:page_transition/page_transition.dart';
import 'Home.dart';


class myokra extends StatefulWidget {
  const myokra({super.key});

  @override
  State<myokra> createState() => _myokraState();
}

class _myokraState extends State<myokra> {
  OkraList okras = OkraList();

Widget listCard(okra okras) => Card(        //box of each item call
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
     
        Image.asset(
          okras.image,
          width: MediaQuery.of(context).size.width,
          height: 190,
          ),
        Text(
          'Status: ${okras.type}',
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, //... if the text is too long
          style: const TextStyle(fontSize: 15),
          ),
          buttons(okras),
      ],
    ),)
);

 Widget buttons(okra okras) => Column(
  children: [
       IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {  Navigator.pushReplacement(context,
                                            PageTransition(type: PageTransitionType.fade, child: care(type: okras.type,img:okras.image)));},
                                      color: const Color(0xff5ac46d),
                                      iconSize: 24,
                                    ),
  ],
 );

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
        GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,   //no of columns
          mainAxisExtent: 360, //size
        ), 
        itemCount: okras.okraList.length,
        itemBuilder: (BuildContext ctx, index){
          return listCard(okras.okraList[index]);
        },
        ),
    );
  }
}
