import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class _ProgressState extends State<Progress> {
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
),),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: const EdgeInsets.only(top: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 GFProgressBar(
            percentage: 0.6,
            width:300,
             radius: 150,
             circleWidth:20,
             animation: true,
             animateFromLastPercentage:true,
             type: GFProgressType.circular,
             backgroundColor: Colors.black26,
             progressBarColor: GFColors.SUCCESS,
              leading  : const Icon( Icons.sentiment_dissatisfied, color: Colors.green),
              ),
              const Center(child: Text(' 60%', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 70,),
              const Center(child: Text('Great! Keep it up', style: TextStyle(fontWeight: FontWeight.bold),)),
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
                margin: const EdgeInsets.symmetric(horizontal: 20) ,
                child: Column(
                  children: [
                     GFItemsCarousel(
         rowCount: 3,
         children: imageList.map(
           (url) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child:
            Image.network(url, fit: BoxFit.cover, width: 1000.0),
           ),
        );
           },
         ).toList(),
      ),
                  ],
                ),
                ),
                 Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15) ,
                child: const Column(
                  children: [
                    Text('INFO', style: TextStyle(fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10,),
                    Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                    'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, whe'
                   ' n an unknown printer took a galley of type and scrambled it to make a type specimen book'
                    '. It has survived not only five centuries, but also the leap into electronic typesetting, remai'
                    'ning essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets cont'
                   ' aining Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inc'
                    'luding versions of Lorem Ipsum.', textAlign: TextAlign.justify,),
                  ],
                )
                ),
             Padding(
padding:const EdgeInsets.all(16),
child:Align(
alignment:Alignment.bottomCenter,
child:MaterialButton(
  onPressed: () {
    
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