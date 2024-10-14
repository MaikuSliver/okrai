// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:okrai/forecast/predictyield.dart';
import 'package:okrai/mainscreens/Disease.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/okrainfo.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import '../database/db_helper.dart';
import '../mlmodel/TfliteModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _totalScans = 0;
  bool _isLoading = true;
  String description = 'This tool aids farmers in preserving their harvests. This app has a useful built-in camera that enables the farmer to take a picture of the crop that is ill and send it for diagnosis.';

  @override
  void initState() {
    super.initState();
    _refreshScans();
  }

  void _refreshScans() async {
    setState(() => _isLoading = true);
    _totalScans = await DatabaseHelper.instance.countTotalRows();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home, color: Color(0xff44c377)),
                onPressed: () => Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Home())),
              ),
              IconButton(
                icon: const Icon(Icons.energy_savings_leaf, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const myokra())),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const settings())),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage("assets/images/GUL-AI__1_-removebg-preview.png"),
                        height: 80,
                        width: 100,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff43c175),
                          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(12, 5, 190, 5),
                          color: const Color(0xffffffff),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: IconButton(
                                      icon: Image.asset(
                                        'assets/images/pest.png',
                                        height: 25,
                                        width: 50,
                                      ),
                                      onPressed: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: okrainfo())),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/images/gut-microbiota.png',
                                      height: 25,
                                      width: 50,
                                    ),
                                    onPressed: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const Disease())),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(29, 0, 5, 0),
                                    child: Text("Info", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(25, 0, 5, 0),
                                    child: Text("Disease", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Text("Heal your Okra", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                _buildPredictionCard(),
                _buildTotalScanCard(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Text("Predict", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                _buildOkraYieldPredictionCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalScanCard() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0x1fffffff),
        border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffc5d7e0),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Total Scan",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  _isLoading ? const CircularProgressIndicator() : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                      "$_totalScans",
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionCard() {
    return SizedBox(
      height: 230,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        color: const Color(0xffc1d4dd),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPredictionStep("Take", "a Picture", "assets/images/smartphone.png"),
                const SizedBox(width: 15),
                const Text('>', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                const SizedBox(width: 20),
                _buildPredictionStep("Get the", "Result", "assets/images/research.png"),
                const SizedBox(width: 15),
                const Text('>', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                const SizedBox(width: 20),
                _buildPredictionStep("Get", "Diagnosis", "assets/images/report.png"),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const TfliteModel())),
                color: const Color(0xff44c377),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                padding: const EdgeInsets.all(20),
                textColor: const Color(0xffffffff),
                height: 40,
                minWidth: 170,
                child: const Text("Take a Picture", style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionStep(String title, String subtitle, String assetPath) {
    return Column(
      children: [
        Image.asset(assetPath, height: 50),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
      ],
    );
  }

  Widget _buildOkraYieldPredictionCard() {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color(0xffc4d6df),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          const Text("Okra Yield Prediction", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const Text("PREDICT NOW!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const Icon(Icons.grass_rounded, size: 50, color: Color(0xff44c377)),
          ElevatedButton(
            onPressed: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const PredictYield())),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff44c377),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("Click Here", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
