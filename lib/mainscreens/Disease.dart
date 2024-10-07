// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:okrai/disease/diseaseinfo.dart';
import 'package:page_transition/page_transition.dart';

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
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff63b36f),
          onPressed: () {
            Navigator.pop(context);
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
          diseaseItem(context, 'Yellow Vein', 'assets/images/dis2.png', 0),
          diseaseItem(context, 'Leaf Curl', 'assets/images/curl.jpg', 1),
          diseaseItem(context, 'Early Blight', 'assets/images/early.jpg', 2),
          diseaseItem(context, 'Powdery Mildrew', 'assets/images/images (5).jpg', 3),
          diseaseItem(context, 'Fusarium Wilt', 'assets/images/picture2.jpg', 4),
          diseaseItem(context, 'Leaf Spot', 'assets/images/images (6).jpg', 5),
          diseaseItem(context, 'Silverleaf Whitefly', 'assets/images/images (7).jpg', 6),
          diseaseItem(context, 'Corythucha Gossypii', 'assets/images/images (8).jpg', 7),
          diseaseItem(context, 'Anthracnose', 'assets/images/images (9).jpg', 8),
          diseaseItem(context, 'Aphids', 'assets/images/images (10).jpg', 9),
          diseaseItem(context, 'Damping Off', 'assets/images/images (4).jpg', 10),
          diseaseItem(context, 'Root Rot', 'assets/images/images (11).jpg', 11),
        ],
      ),
    );
  }

  // Helper method to create consistent disease items with black text background
  Widget diseaseItem(BuildContext context, String diseaseName, String imagePath, int diseaseId) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: const Color(0xff57c26b),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xff57c26b), width: 1),
          ),
          child: IconButton(
            icon: Image.asset(
              imagePath,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: DiseaseInfo(id: diseaseId),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.all(4),
            width: 140,
            child: Text(
              diseaseName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 10,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
