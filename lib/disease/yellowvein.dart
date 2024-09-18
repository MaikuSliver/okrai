
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:okrai/mainscreens/Disease.dart';
import 'package:page_transition/page_transition.dart';

class yellowvein extends StatelessWidget {
  const yellowvein({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Okra Disease",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff66bb73),
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),color: const Color(0xff63b36f), onPressed: () {
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Disease()));
        }
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child:

              ///***If you have exported images you must have to copy those images in assets/images directory.
              Image(
                image: const AssetImage("assets/images/dis2.png"),
                height:
                MediaQuery.of(context).size.height * 0.35000000000000003,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Yellow Vein Disease",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Vein-Clearing/Yellow Vein Mosaic :",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 10,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                    child: Text(
                      "Bhendi yellow vein mosaic virus",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 10,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: LinearProgressIndicator(
                        backgroundColor: Color(0xffd4d4d4),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff3a57e8)),
                        value: 0,
                        minHeight: 3),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Disease Image",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
         
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Row(
                children: [
                       Expanded(child: Image.asset('assets/images/y1.jpg',
                fit: BoxFit.cover,height: 200,
              width: 200,)),
                       const SizedBox(width: 15,),
                       Expanded(child: Image.asset('assets/images/y2.jpg',
                fit: BoxFit.cover,height: 200,
              width: 200,)),
                ],
              ),
            ),
         
 Container(
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                       Expanded(child: Image.asset('assets/images/y3.jpg',
                fit: BoxFit.cover,height: 200,
              width: 200,)),
                       const SizedBox(width: 15,),
                       Expanded(child: Image.asset('assets/images/y4.jpg',
                fit: BoxFit.cover,height: 200,
              width: 200,)),
                ],
              ),
            ),
           
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: LinearProgressIndicator(
                      backgroundColor: Color(0xffcccccc),
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xff3a57e8)),
                      value: 0,
                      minHeight: 3),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Symptoms:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                      child: Text(
                        "\u2022 Yellowing of the entire network of veins in the leaf blade is the characteristic symptom.\n"
                            "\u2022 In severe infections the younger leaves turn yellow, become reduced in size and the plant is highly stunted.\n"
                            "\u2022 The veins of the leaves will be cleared by the virus and intervenal area becomes completely yellow or white.\n"
                            "\u2022 In a field, most of the plants may be diseased and the infection may start at any stage of plant growth.\n"
                            "\u2022 Infection restricts flowering and fruits, if formed, may be smaller and harder.\n"
                            "\u2022 The affected plants produce fruits with yellow or white colour and they are not fit for marketing.\n"
                            "\u2022 The virus is spread by whitefly.",
            
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.clip,
                     
                      ),
                  
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: LinearProgressIndicator(
                      backgroundColor: Color(0xffc8c7c7),
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xff3a57e8)),
                      value: 0,
                      minHeight: 3),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Farm Use",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      "\u2022 Spray azadirachtin 0.03 WSP @ 5 g/10l or methyl demeton 25 EC @ 1.6 ml/l or thiamethoxam 25 WG @ 2 g/lit to kill the insect vector, whitefly.\n"
                          "\u2022 By selecting varieties resistant to yellow vein mosaic like Parbhani Kranti, Arka Abhay, Arka Anamika, and Varsha Uphar, the incidence of the disease can be minimised.\n"
                          "\u2022 The virus is transmitted by the whitely (Bemisia tabaci,.\n"
                          "\u2022 Parbhani Kranti, Janardhan, Haritha, Arka Anamika and Arka Abhay can tolerate yellow vein mosaic.\n"
                          "\u2022 For sowing during the summer season, when the whitefly activity is high, the susceptible varieties should be avoided.\n"
                          "\u2022 Synthetic pyrethroids should not be used because it will aggravate the situation.\n"
                          "\u2022 It can be controlled by application of Chlorpyriphos 2.5 ml + neem oil 2 ml lit of water.\n",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
