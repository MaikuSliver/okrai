// ignore_for_file: camel_case_types, deprecated_member_use
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:okrai/diagnose/progress.dart';
import 'package:okrai/okraimodels/okralist.dart';
import 'package:page_transition/page_transition.dart';
import '../okraimodels/okra.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:syncfusion_flutter_charts/charts.dart';

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
  
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late String okratype;
late String okraimg;
late int okraid;
late String okraname;
late String okrapest;
late String okradate;
late int okragraph;
@override
  void initState() {
    super.initState();
  // Initialize notification plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Initialize timezone settings
  tz.initializeTimeZones(); 
    okratype = widget.type;
    okraimg = widget.img;
    okraid =  widget.id;
    okraname = widget.name;
    okrapest = widget.pest;
    okradate = widget.date;
    
      // Set okrainfoid based on okraname
        if (okratype.toLowerCase() == 'mild early blight disease') { 
      okrainfoid = 0;
      okragraph = 1;
    } else if (okratype.toLowerCase() == 'severe early blight disease') { 
      okrainfoid = 1;
      okragraph = 1;
    } else if (okratype.toLowerCase() == 'critical early blight disease') {
      okrainfoid = 2;
      okragraph = 1;
    } else if (okratype.toLowerCase() == 'mild leaf curl disease') { 
       okrainfoid = 3;
       okragraph = 2;
    } else if (okratype.toLowerCase() == 'severe leaf curl disease') { 
       okrainfoid = 4;
       okragraph = 2;
    }else if (okratype.toLowerCase() == 'critical leaf curl disease') { 
       okrainfoid = 5;
       okragraph = 2;
     }else if (okratype.toLowerCase() == 'mild yellow vein mosaic disease') { 
       okrainfoid = 6;
       okragraph = 3;
     }else if (okratype.toLowerCase() == 'severe yellow vein mosaic disease') { 
       okrainfoid = 7;
       okragraph = 3;
     }else if (okratype.toLowerCase() == 'critical yellow vein mosaic disease') { 
       okrainfoid = 8;
       okragraph = 3;
    } else {
      okrainfoid = 9; 
      okragraph = 4;
    }
      // Start a timer to trigger notifications every 5 seconds
  Timer.periodic(const Duration(days: 7), (timer) {
    showInstantNotification(
      okraname,
      "This is your water."
    );
  });
   Timer.periodic(const Duration(days: 7), (timer) {
    showInstantNotification(
       okraname,
      "This is your fertilization."
    );
  });
  }
    late int okrainfoid;

  void showInstantNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'instantChannelId', 'instantChannelName',
      importance: Importance.max, priority: Priority.high
    );
    var generalNotificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000), // Unique Notification ID
      title,
      body,
      generalNotificationDetails,
    );

  }
@override
Widget build(BuildContext context) {
    final okra okrainfoss = okrainfos.okraList[okrainfoid];
     // Prepare the pesticide data based on the disease type
  Map<String, int> pesticideData = {};
  
  // Example Data - Replace this with your actual data processing logic
  if (okragraph == 2) {
    pesticideData = {
      'Carbaryl\n250g': 22,
      'Carbaryl\n400g': 2,
      'Carbaryl\n500g': 1,
      'Vermicast': 1,
    };
  } else if (okragraph == 3) {
    pesticideData = {
      'Acetamiprid\n250g': 11,
      'Acetamiprid\n300g': 9,
      'Acetamiprid\n400g': 4,
    };
  } else if (okragraph == 1) {
    pesticideData = {
      'Fungaran\n200g': 5,
      'Fungaran\n400g': 1,
    };
  }
return Scaffold(
backgroundColor: const Color(0xffffffff),
appBar: 
AppBar(
  leadingWidth: 8,
elevation:3,
centerTitle:false,
automaticallyImplyLeading: false,
backgroundColor:const Color(0xffffffff),
shape:const RoundedRectangleBorder(
borderRadius:BorderRadius.zero,
),
title: const Center(
  child: Text(
  "Okrai Care",
  style: TextStyle(color:Color(0xff44c377), fontWeight: FontWeight.bold),
  ),
),
leading: IconButton(
  icon: const Icon(Icons.arrow_back),color: const Color(0xff63b36f), onPressed: () {
  Navigator.pop(context);
},
),
),
body:Container(
  margin: const EdgeInsets.symmetric(horizontal: 10),
  child: SizedBox(
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
  padding:const EdgeInsets.symmetric(vertical: 1,horizontal:0),
  child:Align(
  alignment:Alignment.center,
  child:///***If you have exported images you must have to copy those images in assets/images directory.
  ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    child: Image(
    image: FileImage(File(okraimg)),
    height:175,
    width:200,
    fit:BoxFit.cover,
    ),
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
      overflow: TextOverflow.clip,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        color: okrainfoss.hstatus == 'Healthy' 
            ?const Color(0xff63b36f) // Green color
            : const Color(0xffff0000) // Red color
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
  
       showInstantNotification(
                        "Reminder Set",
                        "You have successfully set Water and Fertilization reminders."
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        "Instant reminders triggered for Water and Fertilization",
        style: TextStyle(color: Colors.white), // White text color
      ),
      duration: const Duration(seconds: 2), // You can adjust the duration as needed
      backgroundColor: const Color(0xff57c26b), // Green background color
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
  
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
      overflow: TextOverflow.visible,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        height: 1.5, // Line spacing
        color: Color(0xff000000),
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
  padding:EdgeInsets.fromLTRB(0, 30, 0, 10),
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
    overflow: TextOverflow.visible,
    style: const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 14,
      height: 1.5,
      color: Color(0xff000000),
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
  padding:EdgeInsets.fromLTRB(0, 30, 0, 10),
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
  
  Expanded(
    flex: 1,
    child: Text(
    okrainfoss.pest,
    textAlign: TextAlign.justify,
      overflow: TextOverflow.visible,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        height: 1.5,
        color: Color(0xff000000),
    ),
    ),
  ),
  ],),
  Row(
  
  children:[
  
  Container(
  margin: const EdgeInsets.only(top: 10),
  child:PesticideUsageChart(
              diseaseType: okratype,
              pesticideData: pesticideData,
               okragraph: okragraph,  // Pass okragraph to the widget
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
),
)
;}
}

class PesticideUsageChart extends StatelessWidget {
  final String diseaseType;
  final Map<String, int> pesticideData;
  final int okragraph; // Add okragraph as a parameter

  const PesticideUsageChart({
    Key? key,
    required this.diseaseType,
    required this.pesticideData,
    required this.okragraph, // Include okragraph in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (okragraph == 4) {
      // If the okragraph is 4 (healthy state), show a centered message
      return const Center(
        child: Text(
          "No need to Implement Pesticides",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      );
    }

    // Prepare the data for the chart if okragraph is not 4
    final List<ChartData> chartData = pesticideData.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              'Pesticide Trends for\n$diseaseType:',
        textAlign: TextAlign.justify,
      overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 275, maxWidth: 275),
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  labelStyle: TextStyle(fontSize: 10),
                ),
                primaryYAxis: const NumericAxis(
                  labelStyle: TextStyle(fontSize: 10),
                ),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.pesticide,
                    yValueMapper: (ChartData data, _) => data.usage,
                    color: const Color(0xff67bd74),
                    borderColor: Colors.green,
                    borderWidth: 1,
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String pesticide;
  final int usage;

  ChartData(this.pesticide, this.usage);
}