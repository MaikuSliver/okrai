// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:okrai/diagnose/progress.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:page_transition/page_transition.dart';

class care extends StatefulWidget {
  const care({Key? key, required this.type, required this.img}) : super(key: key);

final String type;
final String img;

  @override
  State<care> createState() => _careState();
}

class _careState extends State<care> {

late String okratype;
late String okraimg;

@override
  void initState() {
    super.initState();
    okratype = widget.type;
    okraimg = widget.img;
  }

  
@override
Widget build(BuildContext context) {
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
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const myokra()));
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
image:AssetImage(okraimg),
height:150,
width:150,
fit:BoxFit.cover,
),
),
),
const Padding(
padding:EdgeInsets.symmetric(vertical: 16,horizontal:0),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
"Status: Diseased",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
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

Text(
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
"05/29/24",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
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
"Every 2 Days",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
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
"Every 2 Weeks",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
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
onPressed:(){},
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
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
'Leaf spots of early blight are circular, up to 12 mm in diameter, '
'brown, and often show a circular pattern, which distinguishes this '
'disease from other leaf spots on Okra.',
textAlign: TextAlign.justify,
overflow:TextOverflow.clip,
style:TextStyle(
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
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
  "*Use resistant varieties (e.g. Rio Grande).\n\n"
    "*Use certified disease-free seeds. If using own seeds, hot water treat the seeds.\n\n"
    "*Use disease-free plants.\n\n"
    "*Do not plant plant consecutively okra crops on the same land.\n\n"
    "*Practise rotation with non-solanaceous crops (e.g. brassicas, legumes, small grains).\n\n"
    "*Stake and prune indeterminate varieties.\n\n"
    "*If disease is endemic, applied preventative sprays of copper compounds (e.g. copper hydroxide).",
textAlign: TextAlign.justify,
overflow:TextOverflow.clip,
style:TextStyle(
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
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Text(
"Fungal",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
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
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Text(
'For best control, apply copper-based fungicides '
'early, two weeks before disease normally appears or when weather '
'forecasts predict a long period of wet weather. Alternatively, begin '
'treatment when disease first appears, and repeat every 7-10 days for as long as needed.',
textAlign: TextAlign.justify,
overflow:TextOverflow.clip,
style:TextStyle(
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
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const Progress()));
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