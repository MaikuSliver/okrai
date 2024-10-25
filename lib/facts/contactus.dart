// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Don't forget to import the url_launcher package

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

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
          "Contact Us",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Address:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff44c377), // Okrai green
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Davao del Norte State College, Panabo City, Davao del Norte, Philippines',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Email:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff44c377), // Okrai green
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              child: const Text(
                'manipon.mikeangel@dnsc.edu.ph',
             
              ),
              onTap: () {
                launchEmail();
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Phone Number:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff44c377), // Okrai green
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              child: const Text(
                '+63 961-022-2593',
              
              ),
              onTap: () {
                launchPhone();
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Follow Us on Social Media:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff44c377), // Okrai green
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    launchURL('https://www.facebook.com');
                  },
                  child: const Icon(Icons.facebook, size: 30, color: Color(0xff44c377)), // Okrai green
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    launchURL('https://www.twitter.com');
                  },
                  child: const Icon(Icons.message, size: 30, color: Color(0xff44c377)), // Okrai green
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    launchURL('https://www.instagram.com');
                  },
                  child: const Icon(Icons.camera, size: 30, color: Color(0xff44c377)), // Okrai green
                ),
              ],
            ),
             const SizedBox(height: 75),
                   const Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  image: AssetImage('assets/okrai.png'), // Add the correct path to your icon image
                  width: 150,
                  height: 150,
                ),
              ),
             
            ),
            const SizedBox(height: 10,),
             const Center(child: Text('Copyright ©2024, Okr-ai. All Rights Reserved.', 
             style: TextStyle(fontSize: 6),)),
          ],
        ),
      ),
    );
  }

  // Function to launch email client
  void launchEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
      query: 'subject=Support Request', // Add subject
    );
    launch(emailLaunchUri.toString());
  }

  // Function to launch phone dialer
  void launchPhone() {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+11234567890', // Replace with your phone number
    );
    launch(phoneLaunchUri.toString());
  }

  // Function to launch URL
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
