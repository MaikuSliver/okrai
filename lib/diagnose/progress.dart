import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:okrai/mlmodel/update.dart';
import 'package:page_transition/page_transition.dart';

class Progress extends StatefulWidget {
  const Progress({super.key, 
  required this.id, 
  required this.name, 
  required this.type, 
  required this.img, 
  required this.pest, 
  required this.date});

final int id;
final String name;
final String type;
final String img;
final String pest;
final String date;

  @override
  State<Progress> createState() => _ProgressState();
}


final List<String> imageList = [
  "assets/images/c1.jpg",
  "assets/images/c2.jpg",
  "assets/images/c3.jpg",
  "assets/images/c4.jpg",
  "assets/images/c5.jpg",
  "assets/images/e1.jpg"
];

class _ProgressState extends State<Progress> {

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
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                              child: Image.asset(
                                url,
                                fit: BoxFit.cover,
                                width: 100.0,
                              ),
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