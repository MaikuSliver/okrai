import 'package:flutter/material.dart';
import 'package:lastfinalsqliteimgae/widgets/viewpage.dart';

import 'Insert.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title:const Text("SQFlite CRUD Operation") ,
      ),

      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InsertPage()),);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,),
              child: const Text("Insert",style: TextStyle(color: Colors.white),),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const ViewPage()),);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,),
              child: const Text("ViewPage Update and Delete",style: TextStyle(color: Colors.white),),
            ),

          ],
        ),
      ),

    );
  }
}