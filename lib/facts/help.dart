import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Help Center",
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  image: AssetImage('assets/okrai.png'), // Add the correct path to your icon image
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Features of Okrai',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '''1. Crop Management Recommendations:
   Okrai provides tailored advice on managing different crops based on your location, soil type, and season. This helps farmers make data-driven decisions about planting, watering, and harvesting.

2. Offline Access:
   The app works entirely offline, ensuring that farmers in remote areas can still access its features without needing an internet connection.

3. Pest and Disease Identification:
   Okrai helps identify common pests and diseases based on visual cues. You can input symptoms, and the app will provide possible causes and solutions.

4. Production Monitoring:
   Track the growth of your crops over time by entering planting dates, and Okrai will offer suggestions for optimal watering, fertilizer use, and harvest timing.

5. Resource Planning:
   The app provides recommendations on the best times for planting and harvesting based on weather patterns and seasonal trends, optimizing resource use.
              ''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Text(
              'How Okrai Increases Production for Farmers',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '''1. Optimized Crop Yield:
   By offering tailored recommendations based on real-time farm conditions, Okrai helps maximize your crop yield through better planting practices, irrigation schedules, and harvest times.

2. Improved Resource Management:
   Okrai provides advice on the best use of water, fertilizer, and labor, ensuring that crops receive the right nutrients at the right time, reducing waste and improving overall crop health.

3. Pest and Disease Control:
   Early detection of pests and diseases allows you to take preventive actions, helping to reduce the risk of widespread damage and promoting healthier crops.

4. Timely Decision-Making:
   With offline access, Okrai enables quick responses to changes in weather or crop health, allowing for better management decisions without waiting for internet access.
              ''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
