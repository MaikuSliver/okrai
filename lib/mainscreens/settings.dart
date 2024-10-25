import 'package:flutter/material.dart';
import 'package:okrai/facts/contactus.dart';
import 'package:okrai/facts/help.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:page_transition/page_transition.dart';
import 'Home.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool notificationsEnabled = true; // Track if notifications are enabled

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
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
                icon: const Icon(Icons.home),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: const Home()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.energy_savings_leaf),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: const myokra()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: const Color(0xff44c377),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      PageTransition(type: PageTransitionType.fade, child: const settings()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              color: const Color(0xffffffff),
              shadowColor: const Color(0xffd5d2d2),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Notification settings",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: SwitchListTile(
                        value: notificationsEnabled,
                        title: const Text(
                          "Push Notification",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        subtitle: const Text(
                          "Receive weekly push notification",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xff737070),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value; // Update the state
                            if (!notificationsEnabled) {
                              // Logic to stop notifications
                              stopAllNotifications();
                            } else {
                              // Logic to enable notifications
                              startNotifications();
                            }
                          });
                        },
                        tileColor: const Color(0x00ffffff),
                        activeColor: const Color(0xff093010),
                        activeTrackColor: const Color(0xff57c26b),
                        controlAffinity: ListTileControlAffinity.trailing,
                        dense: false,
                        inactiveThumbColor: const Color(0xff9e9e9e),
                        inactiveTrackColor: const Color(0xffe0e0e0),
                        contentPadding: const EdgeInsets.all(0),
                      ),
                    ),
                    const Divider(
                      color: Color(0xff808080),
                      height: 16,
                      thickness: 0.3,
                      indent: 0,
                      endIndent: 0,
                    ),
                    // SwitchListTile(
                    //   value: false,
                    //   title: const Text(
                    //     "App Theme",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontStyle: FontStyle.normal,
                    //       fontSize: 14,
                    //       color: Color(0xff000000),
                    //     ),
                    //     textAlign: TextAlign.start,
                    //   ),
                    //   subtitle: const Text(
                    //     "Set into dark mode theme",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontStyle: FontStyle.normal,
                    //       fontSize: 12,
                    //       color: Color(0xff737070),
                    //     ),
                    //     textAlign: TextAlign.start,
                    //   ),
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.zero,
                    //   ),
                    //   onChanged: (value) {
                    //     // Implement your theme change logic here
                    //   },
                    //   tileColor: const Color(0x00ffffff),
                    //   activeColor: const Color(0xff3a57e8),
                    //   activeTrackColor: const Color(0x3f3a57e8),
                    //   controlAffinity: ListTileControlAffinity.trailing,
                    //   dense: false,
                    //   inactiveThumbColor: const Color(0xff9e9e9e),
                    //   inactiveTrackColor: const Color(0xffe0e0e0),
                    //   contentPadding: const EdgeInsets.all(0),
                    // ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              color: const Color(0xffffffff),
              shadowColor: const Color(0xffd5d2d2),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Support",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: ListTile(
  tileColor: const Color(0x00ffffff),
  title: const Text(
    "Help",
    style: TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      color: Color(0xff000000),
    ),
    textAlign: TextAlign.start,
  ),
  dense: false,
  contentPadding: const EdgeInsets.all(0),
  selected: false,
  selectedTileColor: const Color(0x42000000),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  ),
  trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xff767678), size: 18),
  
  // Add the onTap property to make it clickable
  onTap: () {
    // Define what happens when the tile is clicked
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const HelpPage()));
  },
)
                    ),
                    const Divider(
                      color: Color(0xff808080),
                      height: 16,
                      thickness: 0.3,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: ListTile(
  tileColor: const Color(0x00ffffff),
  title: const Text(
    "Contact Us",
    style: TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      color: Color(0xff000000),
    ),
    textAlign: TextAlign.start,
  ),
  dense: false,
  contentPadding: const EdgeInsets.all(0),
  selected: false,
  selectedTileColor: const Color(0x42000000),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  ),
  trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xff767678), size: 18),
  
  // Add the onTap property to make it clickable
  onTap: () {
    // Define what happens when the tile is clicked
   Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const ContactUsPage()));
  },
)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
              width: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Implement your notification management logic
  void startNotifications() {
    // Logic to start notifications
  }

  void stopAllNotifications() {
    // Logic to stop all notifications
  }
}
