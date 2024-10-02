///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:okrai/disease/curl.dart';
import 'package:okrai/disease/early.dart';
import 'package:okrai/disease/yellowvein.dart';
import 'package:page_transition/page_transition.dart';

import 'Home.dart';

class Disease extends StatelessWidget {
  const Disease({super.key});

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
          "Disease",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff65bb72),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),color: const Color(0xff63b36f), onPressed: () {
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Home()));
        },
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [

              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                IconButton(
                  icon: Image.asset(
                    'assets/images/dis2.png',
                    height: 100,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        PageTransition(type: PageTransitionType.fade, child: const yellowvein()));
                  },
                ),
              ),
              const Text(
                "Yellow Vein",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                IconButton(
                  icon: Image.asset(
                    'assets/images/curl.jpg',
                    height: 100,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        PageTransition(type: PageTransitionType.fade, child: const curl()));
                  },
                ),
              ),
              const Text(
                "Leaf Curl",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [

              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                IconButton(
                  icon: Image.asset(
                    'assets/images/early.jpg',
                    height: 100,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        PageTransition(type: PageTransitionType.fade, child: const early()));
                  },
                ),
              ),
              const Text(
                "Early Blight",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-vector/colorful-realistic-science-background_52683-36470.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (5).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Powdery Mildrew",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 15,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-vector/silhouette-people-demonstration_23-2147997865.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/picture2.jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Fusarium Wilt",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-vector/cartoon-graphic-design-landing-page_52683-70881.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (6).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Leaf Spot",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-photo/pretty-young-stylish-sexy-woman-pink-luxury-dress-summer-fashion-trend-chic-style-sunglasses-blue-studio-background-shopping-holding-paper-bags-talking-mobile-phone-shopaholic_285396-2957.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (7).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Silverleaf Whitefly",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-photo/young-blonde-woman-painting-with-acrylics_23-2148854525.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (8).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Corythucha Gossypii",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 13,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-photo/close-up-people-training-with-ball_23-2149049821.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (9).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Anthracnose",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-vector/colorful-realistic-science-background_52683-36470.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (10).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Aphids",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-vector/silhouette-people-demonstration_23-2147997865.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (4).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Damping Off",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: const NetworkImage(
                      "https://image.freepik.com/free-vector/cartoon-graphic-design-landing-page_52683-70881.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x6e000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
                  image: AssetImage("assets/images/images (11).jpg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                "Root rot",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
