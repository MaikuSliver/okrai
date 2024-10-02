///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';


class splash extends StatelessWidget {
  const splash({super.key});


@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xffffffff),
body:Container(
margin:const EdgeInsets.all(0),
padding:const EdgeInsets.all(0),
width:MediaQuery.of(context).size.width,
height:MediaQuery.of(context).size.height,
decoration: BoxDecoration(
color:const Color(0xffffffff),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.zero,
border:Border.all(color:const Color(0x4d9e9e9e),width:1),
),
child:

const Stack(
alignment:Alignment.center,
children: [
///***If you have exported images you must have to copy those images in assets/images directory.
Image(
image:AssetImage("assets/images/GUL-AI__1_-removebg-preview.png"),
height:200,
width:200,
fit:BoxFit.cover,
),
],),
),
)
;}
}