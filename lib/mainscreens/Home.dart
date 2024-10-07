// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:okrai/mainscreens/Disease.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/okrainfo.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import '../database/db_helper.dart';
import '../mlmodel/TfliteModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String description='This tool aids farmers in preserving their harvests. This app has a useful'
"built-in camera that enables the farmer to take a picture of the crop that"
" is ill and send it for diagnosis.";

class _HomeState extends State<Home> {
  
int _totalScans = 0;
  bool _isLoading = true; // To handle loading state

  @override
  void initState() {
    super.initState();
    _refreshScans(); // Call to fetch total rows
  }

  void _refreshScans() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    // Fetch the total rows
    _totalScans = await DatabaseHelper.instance.countTotalRows();

    setState(() {
      _isLoading = false; // Stop loading
    });
  }


@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xffffffff),
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
         icon: const Icon(Icons.home),color: Colors.green, onPressed: () {
         Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Home()));
        },
        ),
        IconButton(
         icon: const Icon(Icons.energy_savings_leaf),color: Colors.grey, onPressed: () {
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const myokra()));
         },
        ),
        IconButton(
         icon: const Icon(Icons.settings),color: Colors.grey, onPressed: () {
         Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const settings()));
        },
        ),
       ],
      ),
     ),
    ),
body:

Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [

Expanded(
flex: 1,
child:
ListView(
scrollDirection: Axis.vertical,
padding:const EdgeInsets.all(0),
shrinkWrap:false,
physics:const ScrollPhysics(),
children:[

Container(
  margin: const EdgeInsets.only(top: 15),
  child:   const Row(
  mainAxisAlignment:MainAxisAlignment.start,
  crossAxisAlignment:CrossAxisAlignment.center,
  mainAxisSize:MainAxisSize.max,
  children:[
  Image(
  image:AssetImage("assets/images/GUL-AI__1_-removebg-preview.png"),
  height:55,
  width:100,
  fit:BoxFit.fitWidth,
  ),
  ],),
),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Container(
margin:const EdgeInsets.all(0),
padding:const EdgeInsets.all(0),
width:200,
height:80,
decoration: BoxDecoration(
color:const Color(0xff43c175),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.zero,
border:Border.all(color:const Color(0x4d9e9e9e),width:1),
),
child:

Card(
margin:const EdgeInsets.fromLTRB(12, 5, 190, 5),
color:const Color(0xffffffff),
shadowColor:const Color(0xff000000),
elevation:1,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(4.0),
side: const BorderSide(color:Color(0x4d9e9e9e), width:1),
),
child:

Column(

children:[

Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:const EdgeInsets.fromLTRB(10 , 0, 0, 0),
child:///***If you have exported images you must have to copy those images in assets/images directory.
IconButton(
 icon: Image.asset(
  'assets/images/pest.png',
  height: 25,
  width: 50,
  fit: BoxFit.fitHeight,
 ),
 onPressed: () {
  Navigator.push(context,
      PageTransition(type: PageTransitionType.fade, child:okrainfo()));
 },
),
),
Padding(
padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
child:///***If you have exported images you must have to copy those images in assets/images directory.
IconButton(
 icon: Image.asset(
  'assets/images/gut-microbiota.png',
  height: 25,
  width: 50,
  fit: BoxFit.fitHeight,
 ),
 onPressed: () {
  Navigator.push(context,
      PageTransition(type: PageTransitionType.fade, child: const Disease()));
 },
),
),
],),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(29, 0, 5, 0),
child:Text(
"Info",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
Padding(
padding:EdgeInsets.fromLTRB(25, 0, 5, 0),
child:Text(
"Disease",
textAlign: TextAlign.start,
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
],),
),
),),
],),
const Padding(
padding:EdgeInsets.fromLTRB(15, 15, 15, 5),
child:Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Text(
"Heal your Okra",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:16,
color:Color(0xff000000),
),
),
],),),

Container(
  margin: const EdgeInsets.symmetric(horizontal: 15),
  child:   Row(
  mainAxisAlignment:MainAxisAlignment.start,
  crossAxisAlignment:CrossAxisAlignment.center,
  mainAxisSize:MainAxisSize.max,
  children:[
  Expanded(
    child:   Text(description,
    textAlign: TextAlign.justify,
    overflow:TextOverflow.clip,
    style:const TextStyle(
    fontWeight:FontWeight.w400,
    fontStyle:FontStyle.normal,
    fontSize:10,
    color:Color(0xff000000),
    ),
    ),
  ),
  ],),
),

Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Container(
margin:const EdgeInsets.all(0),
padding:const EdgeInsets.all(0),
width:200,
height:270,
decoration: const BoxDecoration(
color:Color(0xffffffff),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.zero,
),
child:

Card(
margin:const EdgeInsets.symmetric(vertical: 10,horizontal:12),
color:const Color(0xffc1d4dd),
shadowColor:const Color(0xff000000),
elevation:1,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(4.0),
side: const BorderSide(color:Color(0x4d9e9e9e), width:1),
),
child:

ListView(
scrollDirection: Axis.vertical,
padding:const EdgeInsets.all(0),
shrinkWrap:false,
physics:const ScrollPhysics(),
children:[

Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Container(
margin:const EdgeInsets.all(0),
padding:const EdgeInsets.all(0),
width:200,
height:40,
decoration: const BoxDecoration(
color:Color(0xffbfd3dd),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.zero,
),
)
)
,
],),
const Row(
mainAxisAlignment:MainAxisAlignment.center,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
  child:   Row(
  mainAxisAlignment:MainAxisAlignment.center,
  children: [
    Column(
      children: [
        Image(
        image:AssetImage("assets/images/smartphone.png"),
        height:50,
        width:50,
        fit:BoxFit.fitHeight,
        ),
        SizedBox(height: 25,),
        Text(
  "Take",
  textAlign: TextAlign.start,
  overflow:TextOverflow.clip,
  style:TextStyle(
  fontWeight:FontWeight.w400,
  fontStyle:FontStyle.normal,
  fontSize:14,
  color:Color(0xff000000),
  ),
  ),
   Text(
  "a Picture",
  textAlign: TextAlign.start,
  overflow:TextOverflow.clip,
  style:TextStyle(
  fontWeight:FontWeight.w400,
  fontStyle:FontStyle.normal,
  fontSize:14,
  color:Color(0xff000000),
  ),
  ),
      ],
    ),
    SizedBox(width: 15,),
    Text('>',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
    SizedBox(width: 20,),
     Column(
       children: [
         Image(
    image:AssetImage("assets/images/research.png"),
    height:50,
        width:50,
    fit:BoxFit.fitHeight,
    ),
    SizedBox(height: 25,),
    Text(
  "Get the",
  textAlign: TextAlign.start,
  overflow:TextOverflow.clip,
  style:TextStyle(
  fontWeight:FontWeight.w400,
  fontStyle:FontStyle.normal,
  fontSize:14,
  color:Color(0xff000000),
  ),
  ),
   Text(
  "Result",
  textAlign: TextAlign.start,
  overflow:TextOverflow.clip,
  style:TextStyle(
  fontWeight:FontWeight.w400,
  fontStyle:FontStyle.normal,
  fontSize:14,
  color:Color(0xff000000),
  ),
  ),
       ],
     ),
  SizedBox(width: 15,),
     Text('>',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
    SizedBox(width: 20,),
   Column(
     children: [
       Image(
        image:AssetImage("assets/images/report.png"),
        height:50,
        width:50,
        fit:BoxFit.fitHeight,
        ),
        SizedBox(height: 25,),
        Text(
  "Get ",
  textAlign: TextAlign.start,
  overflow:TextOverflow.clip,
  style:TextStyle(
  fontWeight:FontWeight.w400,
  fontStyle:FontStyle.normal,
  fontSize:14,
  color:Color(0xff000000),
  ),
  ), Text(
  "Diagnosis",
  textAlign: TextAlign.start,
  overflow:TextOverflow.clip,
  style:TextStyle(
  fontWeight:FontWeight.w400,
  fontStyle:FontStyle.normal,
  fontSize:14,
  color:Color(0xff000000),
  ),
  ),
     ],
   ),
  
  ],),
),
],),

const SizedBox(height: 15,),



Row(
mainAxisAlignment:MainAxisAlignment.center,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Align(
alignment:Alignment.center,
child:MaterialButton(
onPressed:() {
 Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const TfliteModel()));
},
color:const Color(0xff44c377),
elevation:0,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(50.0),
),
padding:const EdgeInsets.all(20),
textColor:const Color(0xffffffff),
height:40,
minWidth:170,
child:const Text("Take a Picture", style: TextStyle( fontSize:14,
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
),),
),
),
),
],),
],),
),
),),
],),
 Container(
  margin: const EdgeInsets.all(0),
  padding: const EdgeInsets.all(0),
  width: 200,
  height: 100,
  decoration: BoxDecoration(
   color: const Color(0x1fffffff),
   shape: BoxShape.rectangle,
   borderRadius: BorderRadius.zero,
   border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
  ),
  child: Row(
   mainAxisAlignment: MainAxisAlignment.start,
   crossAxisAlignment: CrossAxisAlignment.center,
   mainAxisSize: MainAxisSize.max,
   children: [
    Expanded(
     flex: 1,
     child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      width: 200,
      height: 100,
      decoration: BoxDecoration(
       color: const Color(0xffc5d7e0),
       shape: BoxShape.rectangle,
       borderRadius: BorderRadius.circular(5.0),
       border:
       Border.all(color: const Color(0x4d9e9e9e), width: 1),
      ),
      child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisSize: MainAxisSize.max,
       children: [
         const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            "Total Scan",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),_isLoading
            ? const CircularProgressIndicator():
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "$_totalScans", 
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                          
                        ),
                        
       ],
      ),
     ),
    ),
   ],
  ),
 ),
const Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(15, 0, 0, 0),
child:Text(
"Weather",
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
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Expanded(
flex: 1,
child: Container(
margin:const EdgeInsets.all(0),
padding:const EdgeInsets.all(0),
width:200,
height:140,
decoration: const BoxDecoration(
color:Color(0x1fffffff),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.zero,
),
child:

Card(
margin:const EdgeInsets.symmetric(vertical: 10,horizontal:12),
color:const Color(0xffc4d6df),
shadowColor:const Color(0xff000000),
elevation:1,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(4.0),
side: const BorderSide(color:Color(0x4d9e9e9e), width:1),
),
child:

ListView(
scrollDirection: Axis.vertical,
padding:const EdgeInsets.all(0),
shrinkWrap:false,
physics:const ScrollPhysics(),
children:const [

Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(15, 15, 0, 0),
child:Text(
"Today Weather",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w500,
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


Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Padding(
padding:EdgeInsets.fromLTRB(15, 0, 0, 0),
child:Text(
"35.1 °C",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w800,
fontStyle:FontStyle.normal,
fontSize:25,
color:Color(0xff000000),
),
),
),
],),

Row(
mainAxisAlignment:MainAxisAlignment.end,
children: [
Padding(
padding:EdgeInsets.only(left:150),
child:///***If you have exported images you must have to copy those images in assets/images directory.
Image(
image:AssetImage("assets/images/cloud.png"),
height:50,
width:50,
fit:BoxFit.fitHeight,
),
),
],),
],),
Row(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(15, 0, 0, 0),
child:Text(
"Overcast Clouds",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:12,
color:Color(0xff3b3939),
),
),
),

],),
],),
),
),),
],),
],),),
],),
)
;}
}
//   "\u2022 In severe infections the younger leaves turn yellow, become reduced in size and the plant is highly stunted.\n"
                       