// ignore_for_file: file_names
//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:okrai/forecast/predictyield.dart';
import 'package:okrai/mainscreens/Disease.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/okrainfo.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import '../database/db_helper.dart';
import '../mlmodel/TfliteModel.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
 //int _currentIndex = 0; // Current index for the carousel
  //late Timer _timer; // Timer for auto slide

  @override
  void initState() {
    super.initState();
    _refreshScans();
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
  @override
  void dispose() {
   // _timer.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

void _refreshScans() async {
   setState(() => _isLoading = true);

  _totalScans = await DatabaseHelper.instance.countTotalRows();
  _totalHealthy = await DatabaseHelper.instance.countTotalHealthy();
  _totalDisease = await DatabaseHelper.instance.countTotalDisease();

  // Fetch disease count by type
  final diseaseCounts = await DatabaseHelper.instance.countDiseasesByType();
  barChartData = diseaseCounts.entries.map((entry) {
    return ChartData(entry.key, entry.value.toDouble());
  }).toList();

  // Fetch daily scan data and prepare line chart data
  final dailyScans = await DatabaseHelper.instance.countDiseasesByType();
  lineChartData = dailyScans.entries.map((entry) {
    return ChartData(entry.key, entry.value.toDouble());
  }).toList();

  // Prepare pie chart data
  pieChartData = [
    ChartData('Healthy', _totalHealthy.toDouble()),
    ChartData('Diseased', _totalDisease.toDouble()),
  ];

  // Fetch pesticide counts and prepare data
  final pesticideCounts = await DatabaseHelper.instance.countPesticidesUsed();
  pesticideChartData = pesticideCounts.entries.map((entry) {
    return ChartData(entry.key, entry.value.toDouble());
  }).toList();

  setState(() => _isLoading = false);

}

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



  

 bool get hasBarData => barChartData.isNotEmpty;
  bool get hasLineData => lineChartData.isNotEmpty;
  bool get hasPieData => pieChartData.isNotEmpty;
   bool get hasPesticideData => pesticideChartData.isNotEmpty;
  
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
        PageTransition(type: PageTransitionType.fade, child: const PredictYield()),
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
      width: MediaQuery.of(context).size.height * 0.5, // Adjust height based on screen size
      child: GFCarousel(
        items: [
          // Bar Chart or No Data Message
          Container(
  margin: const EdgeInsets.only(left: 20, right: 20), // Add horizontal space
  child: hasBarData
      ? SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          title: const ChartTitle(text: 'Disease Types'),
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
      : const Center(child: Text("No data yet", style: TextStyle(fontSize: 20))),
),
Container(
  margin: const EdgeInsets.only(left: 20, right: 20), // Add horizontal space
  child: hasPesticideData // This should be a boolean indicating if there's pesticide data
      ? SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          title: const ChartTitle(text: 'Top 5 Pesticides Used'),
          series: <CartesianSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
              dataSource: pesticideChartData, // Your data source for pesticides
              xValueMapper: (ChartData data, _) {
                // Split the category by space
                final words = data.category.split(' '); 
                
                // Function to truncate words longer than a specified length
                String truncate(String word, int maxLength) {
                  return word.length > maxLength ? '${word.substring(0, maxLength)}...' : word;
                }

                // Truncate the first word and the rest if necessary
                String firstWord = truncate(words[0], 5); // Adjust length as needed
                String remainingWords = words.length > 1 
                    ? words.sublist(1).map((word) => truncate(word, 5)).join(' ') // Adjust length as needed
                    : '';

                return remainingWords.isNotEmpty 
                    ? '$firstWord\n$remainingWords' // Add line break between the first word and the rest
                    : firstWord; // Return the single word if there's no remaining words
              },
              yValueMapper: (ChartData data, _) => data.value,
              color: const Color(0xff44c377), // Change color as needed
              borderColor: const Color.fromARGB(255, 245, 245, 245),
              borderWidth: 1,
            ),
          ],
        )
      : const Center(child: Text("No pesticide data yet", style: TextStyle(fontSize: 20))),
),

          // Line Chart or No Data Message
         Container(
  margin: const EdgeInsets.only(left: 20, right: 20), // Add horizontal space
  child: hasLineData
      ? SfCartesianChart(
          primaryXAxis: const CategoryAxis(isVisible: false), // Hide x-axis label
          title: const ChartTitle(text: 'Daily Scan Reports'),
          series: <CartesianSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              dataSource: lineChartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              color: const Color(0xff67bd74),
            ),
          ],
        )
      : const Center(child: Text("No data yet", style: TextStyle(fontSize: 20))),
)
,
          // Pie Chart or No Data Message
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
              // Custom legend item builder
              Color color = index == 0 ? const Color(0xff44c377) : const Color.fromARGB(255, 212, 22, 8);
              return Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: color,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                  Text(name, style: const TextStyle(fontSize: 14)), // Adjust the font size as needed
                ],
              );
            },
          ),
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: pieChartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              pointColorMapper: (ChartData data, int index) {
                // Set color based on index: green for healthy, red for diseased
                return index == 0 ? const Color(0xff44c377) : const Color.fromARGB(255, 212, 22, 8);
              },
            ),
          ],
        )
      : const Center(child: Text("No data yet", style: TextStyle(fontSize: 20))),
),

        ],
      //  onPageChanged: (index) {
        //  setState(() {
          //  _currentIndex = index; // Update current index on manual change
         // });
       // },
       // initialPage: _currentIndex, // Set the initial page
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