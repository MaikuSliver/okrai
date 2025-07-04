// ignore_for_file: file_names
//import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:okrai/mainscreens/Disease.dart';
import 'package:okrai/mainscreens/Harvest.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/okrainfo.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import '../database/db_helper.dart';
import '../mlmodel/TfliteModel.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'trainmodelpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _totalScans = 0;
  bool _isLoading = true;
  String description = 'This tool aids farmers in preserving their harvests. This app has a useful built-in camera that enables the farmer to take a picture of the crop that is ill and send it for diagnosis.';
  int _totalHealthy = 0;
  int _totalDisease = 0;
  String selectedFilter = 'This Month';
 //int _currentIndex = 0; // Current index for the carousel
  //late Timer _timer; // Timer for auto slide

  @override
  void initState() {
    super.initState();
    _refreshScans(selectedFilter);
    _checkFirstTime();
      // Start the timer for auto sliding
    // _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
    //   setState(() {
    //     _currentIndex = (_currentIndex + 1) % 3; // Cycle through the items
    //   });
    // });
  }

 List<ChartData> pieChartData = [];
  List<ChartData> lineChartData = [];
   List<ChartData> barChartData = [];
    List<ChartData> pesticideChartData = [];
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  @override
  void dispose() {
   // _timer.cancel(); // Cancel the timer when disposing
    super.dispose();
  }
void _checkFirstTime() async {
  var box = await Hive.openBox('appBox');
  bool isFirstTime = box.get('isFirstTime', defaultValue: true);

  if (isFirstTime) {
    // Show the welcome message
    _showWelcomePopup();

    // Update the flag
    box.put('isFirstTime', false);
  }
}

void _showWelcomePopup() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Welcome!"),
        content: const Text(
          "Thank you for installing the Okrai app! Here's how you can get started with your journey.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Insert data locally and sync to Firestore
              await _addUserOffline();

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text("Got it!"),
          ),
        ],
      );
    },
  );
}

Future<void> _addUserOffline() async {
  try {
    // Generate a unique ID for the user
    String userId = DateTime.now().millisecondsSinceEpoch.toString();

    // Save user data locally using Hive
    var box = await Hive.openBox('offlineUsers');
    await box.add({
      'id': userId,
      'timestamp': DateTime.now().toIso8601String(),
    });

    debugPrint("User data saved locally with ID: $userId");

    // Attempt to sync the data to Firestore
    _syncOfflineData();
  } catch (e) {
    debugPrint("Error saving user data locally: $e");
  }
}

Future<void> _syncOfflineData() async {
  try {
    var box = await Hive.openBox('offlineUsers');
    var users = box.values.toList();

    if (users.isNotEmpty) {
      // Reference to the Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Upload each user to Firestore
      for (var user in users) {
        await usersCollection.add({
          'id': user['id'],
          'timestamp': FieldValue.serverTimestamp(),
        });

        debugPrint("User synced with ID: ${user['id']}");
      }

      // Clear the locally saved data after syncing
      await box.clear();
    }
  } catch (e) {
    debugPrint("Error syncing offline data: $e");
  }
}

void _refreshScans(String filter) async {
   setState(() => _isLoading = true);

  _totalScans = await DatabaseHelper.instance.countTotalRows();
  _totalHealthy = await DatabaseHelper.instance.countTotalHealthy();
  _totalDisease = await DatabaseHelper.instance.countTotalDisease();

  // Fetch disease count by type
    // Update the charts based on the selected filter
  barChartData = (await DatabaseHelper.instance.countDiseasesByType(filter: filter)).entries.map((entry) {
    return ChartData(entry.key, entry.value.toDouble());
  }).toList();

  // Fetch daily scan data and prepare line chart data
  final dailyScans = await DatabaseHelper.instance.countDiseasesByType();
  lineChartData = dailyScans.entries.map((entry) {
    return ChartData(entry.key, entry.value.toDouble());
  }).toList();

  // Prepare pie chart data
  pieChartData = [
 ChartData('Healthy', double.parse((_totalHealthy / _totalScans * 100).toStringAsFixed(1))),
ChartData('Diseased', double.parse((_totalDisease / _totalScans * 100).toStringAsFixed(1))),
  ];

  // Fetch pesticide counts and prepare data
   pesticideChartData = (await DatabaseHelper.instance.countPesticidesUsed(filter: filter)).entries.map((entry) {
    return ChartData(entry.key, entry.value.toDouble());
  }).toList();

  setState(() => _isLoading = false);

}

 bool get hasBarData => barChartData.isNotEmpty;
  bool get hasLineData => lineChartData.isNotEmpty;
  bool get hasPieData => pieChartData.isNotEmpty;
   bool get hasPesticideData => pesticideChartData.isNotEmpty;
  
// List of tips
  final List<String> tips = [
    "Check soil moisture to prevent root rot.",
    "Use mulch to retain soil moisture and suppress weeds.",
    "Rotate crops to prevent soil nutrient depletion.",
    "Harvest okra regularly to encourage more growth.",
    "Inspect plants for pests regularly.",
    "Ensure adequate sunlight for healthy growth.",
    "Use organic fertilizers to boost soil health.",
    "Plant okra after the last frost date.",
    "Prune lower leaves to improve airflow.",
    "Water deeply and less frequently.",
    "Avoid overcrowding to prevent disease.",
    "Use row covers to protect seedlings from pests.",
    "Apply neem oil to control aphids and whiteflies.",
    "Monitor for signs of disease and act quickly.",
    "Plant companion plants to deter pests.",
    "Clean tools to prevent disease spread."
  ];



  


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
                icon: const Icon(Icons.show_chart, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Harvest())),
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
      body: Row(
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                       child: Row(
  children: [
    // Card for Info
    Card(
      margin: const EdgeInsets.fromLTRB(12, 5, 5, 5),
      color: const Color(0xffffffff),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: IconButton(
              icon: Image.asset(
                'assets/images/pest.png',
                height: 30, // Adjust the size as needed
                width: 50,
              ),
              onPressed: () => Navigator.push(
                context,
                PageTransition(type: PageTransitionType.fade, child: okrainfo()),
              ),
            ),
          ),
          const Text(
            "Info",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),

    // Card for Disease
    Card(
      margin: const EdgeInsets.fromLTRB(5, 5, 12, 5),
      color: const Color(0xffffffff),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: IconButton(
              icon: Image.asset(
                'assets/images/gut-microbiota.png',
                height: 30, // Adjust the size as needed
                width: 50,
              ),
              onPressed: () => Navigator.push(
                context,
                PageTransition(type: PageTransitionType.fade, child: const Disease()),
              ),
            ),
          ),
          const Text(
            "Disease",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
    //  Card(
    //   margin: const EdgeInsets.fromLTRB(12, 5, 5, 5),
    //   color: const Color(0xffffffff),
    //   elevation: 1,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(4.0),
    //     side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
    //   ),
    //         child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 0),
    //         child: IconButton(
    //           icon: const Icon(Icons.settings, color: Colors.green),
    //           onPressed: () => Navigator.push(
    //             context,
    //             PageTransition(type: PageTransitionType.fade, child: HarvestPredictionScreen()),
    //           ),
    //         ),
    //       ),
    //       const Text(
    //         "Train Model",
    //         style: TextStyle(
    //           fontWeight: FontWeight.w400,
    //           fontSize: 14,
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  ],
)

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
               _buildCharts(),
                _buildTotalScanCard(),
                _buildOkraYieldPredictionCard(),
                _buildDailyTips(),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Total Healthy Container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 22, 97, 12),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Total Healthy",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
                    ),
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "$_totalHealthy",  // Updated to display total healthy count
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),

        // Total Scan Container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff43c175),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Total Scan",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "$_totalScans",  // Total scans as before
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),

        // Total Disease Container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 6, 6),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Total Disease",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
                    ),
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "$_totalDisease",  // Updated to display total disease count
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
                          ),
                        ),
                ],
              ),
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
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(color: Color(0xff44c377), width: 3),
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
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xff44c377), width: 3), // Green border
      borderRadius: BorderRadius.circular(10), // Optional: round the corners of the border
    ),
    child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Padding(
      padding: EdgeInsets.fromLTRB(10,10,0,0),
      child: Text(
        "Okra Yield Prediction", 
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(10,0,0,0),
      child: Text(
        "PREDICT NOW!", 
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(10,0,0,0),
      child: Center(
        child: Icon(
          Icons.grass_rounded, 
          size: 50, 
          color: Color(0xff44c377),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(10,0,0,0),
      child: Center(
        child: Padding(
  padding: const EdgeInsets.all(10),
  child: SizedBox(
    width: double.infinity, // Makes the button full width
    child: ElevatedButton(
      onPressed: () => Navigator.push(
        context, 
        PageTransition(type: PageTransitionType.fade, child: const HarvestPredictionScreen()),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff44c377),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Text(
        "Click Here", 
        style: TextStyle(
          fontWeight: FontWeight.w600, 
          fontSize: 16, 
          color: Colors.white,
        ),
      ),
    ),
  ),
),

      ),
    ),
  ],
),

  );
}

Widget _buildCharts() {


  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.3, // Adjust height based on screen size
      width: MediaQuery.of(context).size.height * 0.5, // Adjust width based on screen size
      child: GFCarousel(
        items: [
          // Bar Chart or No Data Message with Dropdown
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20), // Add horizontal space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Disease Types',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                   DropdownButton<String>(
  value: selectedFilter,
  onChanged: (String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedFilter = newValue;
        _refreshScans(newValue); // Pass the selected filter to update charts
      });
    }
  },
  items: ['Today', 'This Month', 'This Year'].map((String filter) {
    return DropdownMenuItem<String>(
      value: filter,
      child: Text(filter),
    );
  }).toList(),
),
                  ],
                ),
                Expanded(
                  child: hasBarData
                      ? SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          title: const ChartTitle(text: ''),
                          series: <CartesianSeries<ChartData, String>>[
                            ColumnSeries<ChartData, String>(
                              dataSource: barChartData,
                              xValueMapper: (ChartData data, _) => data.category,
                              yValueMapper: (ChartData data, _) => data.value,
                              color: const Color.fromARGB(255, 212, 22, 8),
                              borderColor: const Color.fromARGB(255, 245, 245, 245),
                              borderWidth: 1,
                            ),
                          ],
                        )
                      : const Center(
                          child: Text("No data yet", style: TextStyle(fontSize: 20)),
                        ),
                ),
              ],
            ),
          ),

          // Pesticide Chart or No Data Message with Dropdown
         Container(
  margin: const EdgeInsets.only(left: 20, right: 20), // Add horizontal space
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Top 5 Pesticides Used',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: selectedFilter,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedFilter = newValue;
                  _refreshScans(newValue); // Pass the selected filter to update charts
                });
              }
            },
            items: ['Today', 'This Month', 'This Year'].map((String filter) {
              return DropdownMenuItem<String>(
                value: filter,
                child: Text(filter),
              );
            }).toList(),
          ),
        ],
      ),
      Expanded(
        child: hasPesticideData
            ? SfCartesianChart(
                primaryXAxis: const CategoryAxis(
               
                  labelStyle: TextStyle(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                  ),
                ),
                title: const ChartTitle(text: ''),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: pesticideChartData,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    color: const Color(0xff44c377),
                    borderColor: const Color.fromARGB(255, 245, 245, 245),
                    borderWidth: 1,
                  ),
                ],
              )
            : const Center(
                child: Text("No pesticide data yet", style: TextStyle(fontSize: 20)),
              ),
      ),
    ],
  ),
)
,

          // Pie Chart (No Dropdown)
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20), // Add horizontal space
            child: hasPieData
                ? SfCircularChart(
                    title: const ChartTitle(text: 'Healthy & Disease Plants'),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      itemPadding: 10,
                      legendItemBuilder: (String name, dynamic series, dynamic point, int index) {
                        Color color = index == 0 ? const Color(0xff44c377) : const Color.fromARGB(255, 212, 22, 8);
                        return Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: color,
                              margin: const EdgeInsets.only(right: 5),
                            ),
                            Text(name, style: const TextStyle(fontSize: 14)),
                          ],
                        );
                      },
                    ),
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                        dataSource: pieChartData.where((data) => data.value != 0).toList(),
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.value,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                        pointColorMapper: (ChartData data, int index) {
                          return index == 0 ? const Color(0xff44c377) : const Color.fromARGB(255, 212, 22, 8);
                        },
                      ),
                    ],
                  )
                : const Center(
                    child: Text("No data yet", style: TextStyle(fontSize: 20)),
                  ),
          ),
           // Pie Chart (No Dropdown)
         
             FutureBuilder<DocumentSnapshot>(
        future: usersCollection.doc().get(const GetOptions(source: Source.cache)),
        builder: (context, futureSnapshot) {
          return StreamBuilder<QuerySnapshot>(
            stream: usersCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !futureSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching user count.'));
              }

              // Use live data if available, otherwise fallback to cache
              final totalUsers = (snapshot.hasData
    ? snapshot.data?.docs.length ?? 0
    : futureSnapshot.data?.exists ?? false ? 1 : 0) + 5;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Users:',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$totalUsers',
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.people, color: Colors.green, size: 35),
                        ],
                    ),
                  ],
                ),
                
                
              );
            },
          );
        },
          ),
         
        ],
      ),
    ),
  );
}



   Widget _buildDailyTips() {
    // Select a random tip
    final randomTip = (tips..shuffle()).first; // Shuffle and select the first tip
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      color: const Color(0xff44c377),
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline, color: Colors.white),
        title: const Text("Today's Tip!", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        subtitle: Text(randomTip,style: const TextStyle(color: Colors.white,)),
      ),
    );
  }
}

  // Chart data class
  class ChartData {
    final String category;
    final double value;

    ChartData(this.category, this.value);
  }