// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:okrai/diagnose/progress.dart';
import 'package:okrai/okraimodels/okralist.dart';
import 'package:page_transition/page_transition.dart';

import '../okraimodels/okra.dart';

class care extends StatefulWidget {
  const care({Key? key, 
  required this.type, 
  required this.img, 
  required this.id, 
  required this.name, 
  required this.pest, 
  required this.date}) : super(key: key);

final int id;
final String name;
final String type;
final String img;
final String pest;
final String date;

  @override
  State<care> createState() => _careState();
}
OkraList okrainfos = OkraList();
class _careState extends State<care> {

late String okratype;
late String okraimg;
late int okraid;
late String okraname;
late String okrapest;
late String okradate;

@override
  void initState() {
    super.initState();
    okratype = widget.type;
    okraimg = widget.img;
    okraid =  widget.id;
    okraname = widget.name;
    okrapest = widget.pest;
    okradate = widget.date;
      // Set okrainfoid based on okraname
    if (okratype.toLowerCase() == 'early blight disease') {
      okrainfoid = 0;
    } else if (okratype.toLowerCase() == 'leaf curl disease') {
      okrainfoid = 1;
    } else if (okratype.toLowerCase() == 'yellow vein mosaic disease') {
      okrainfoid = 2;
    }  else {
      okrainfoid = 3; // Default value for any other cases
    }
  }
    late int okrainfoid;


@override
Widget build(BuildContext context) {
    final okra okrainfoss = okrainfos.okraList[okrainfoid];
return Scaffold(
backgroundColor: const Color(0xffffffff),
appBar: 
AppBar(
elevation:3,
centerTitle:false,
automaticallyImplyLeading: false,
backgroundColor:const Color(0xffffffff),
shape:const RoundedRectangleBorder(
borderRadius:BorderRadius.zero,
),
title: const Text(
"Okrai Care",
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff63b36f),
),
),
leading: IconButton(
  icon: const Icon(Icons.arrow_back),color: const Color(0xff63b36f), onPressed: () {
  Navigator.pop(context);
},
),
),
body:SizedBox(
height:MediaQuery.of(context).size.height,
width:MediaQuery.of(context).size.width,
child:
Stack(
alignment:Alignment.topLeft,
children: [
Padding(
padding:const EdgeInsets.fromLTRB(16, 16, 16, 80),
child:SingleChildScrollView(
child:
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children: [
Padding(
padding:const EdgeInsets.symmetric(vertical: 16,horizontal:0),
child:Align(
alignment:Alignment.center,
child:///***If you have exported images you must have to copy those images in assets/images directory.
Image(
image: FileImage(File(okraimg)),
height:150,
width:150,
fit:BoxFit.cover,
),
),
),
Padding(
padding:const EdgeInsets.symmetric(vertical: 16,horizontal:0),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
"Status: ${okrainfoss.hstatus}",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff000000),
),
),
),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.end,
mainAxisSize:MainAxisSize.max,
children:[

const Text(
"Added: ",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:10,
color:Color(0xff000000),
),
),
Text(
okradate,
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:10,
color:Color(0xff000000),
),
),
],),
],),),
const Padding(
padding:EdgeInsets.fromLTRB(0, 0, 0, 5),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Text(
"Type of Disease:",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
],),),
 Padding(
padding:const EdgeInsets.fromLTRB(0, 0, 0, 5),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[
Text(
okratype,
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
],),),
const Padding(
padding:EdgeInsets.symmetric(vertical: 5,horizontal:0),
child:Text(
"How-tos:",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
const Padding(
padding:EdgeInsets.fromLTRB(0, 5, 0, 0),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: 
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Icon(
Icons.water_drop_rounded,
color:Color(0xff395cb5),
size:24,
),
],),),
Expanded(
flex: 1,
child: 
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Icon(
Icons.energy_savings_leaf_rounded,
color:Color(0xff66bd73),
size:24,
),
],),),
],),),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: 
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Text(
"Water",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
],),),
Expanded(
flex: 1,
child: 
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Text(
"Fertilization",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
],),),
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: 
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Text(
okrainfoss.water,
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:10,
color:Color(0xff7c7979),
),
),
],),),
Expanded(
flex: 1,
child: 
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Text(
okrainfoss.fertilization,
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:10,
color:Color(0xff9e9292),
),
),
],),),
],),
Padding(
padding:const EdgeInsets.symmetric(vertical: 5,horizontal:0),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Padding(
padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
child:Align(
alignment:Alignment.center,
child:MaterialButton(
onPressed:(){

//to do


},
color:const Color(0xff67bd74),
elevation:0,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(60.0),
side:const BorderSide(color:Color(0xff808080),width:1),
),
padding:const EdgeInsets.all(16),
textColor:const Color(0xffffffff),
height:40,
minWidth:140,
child:const Text("Set Reminders", style: TextStyle( fontSize:14,
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
),),
),
),
),
),
],),),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(0, 10, 0, 5),
child:Text(
"Description:",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
okrainfoss.description,
textAlign: TextAlign.justify,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(0, 10, 0, 5),
child:Text(
"What to do?",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
 okrainfoss.whattodo,
textAlign: TextAlign.justify,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(0, 10, 0, 5),
child:Text(
"Pest Type:",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Text(
okrainfoss.pest,
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
],),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(0, 10, 0, 5),
child:Text(
"Treatment:",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
okrainfoss.treatment,
textAlign: TextAlign.justify,
overflow:TextOverflow.clip,
style:const TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
],),
],),),),
Padding(
padding:const EdgeInsets.all(16),
child:Align(
alignment:Alignment.bottomCenter,
child:MaterialButton(
  onPressed: () {
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Progress(
      id:okraid,
      name:okraname,
      type:okratype,
      img:okraimg,
      pest:okrapest,
      date:okradate,
      progresshealth: okrainfoss.progress,
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
child:const Text("Diagnose", style: TextStyle( fontSize:16,
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
),),
),
),
),
],),),
)
;}
}
