import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:okrai/mainscreens/Home.dart';
import 'package:okrai/mainscreens/Tables.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Harvest extends StatefulWidget {
  const Harvest({super.key});

  @override
  State<Harvest> createState() => _HarvestState();
}
  
class _HarvestState extends State<Harvest> {
bool isOnline = false;

@override
  void initState() {
    super.initState();
    _initializeConnectivity();
    _listenToConnectivityChanges();
  }

 void _initializeConnectivity() async {
  try {
    // Get the current connectivity status
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    _updateStatus(connectivityResult); // Pass the single ConnectivityResult
  } catch (e) {
    // Handle exceptions, such as plugin errors
    setState(() {
      isOnline = false;
    });
  }
}

void _listenToConnectivityChanges() {
  Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
    _updateStatus(connectivityResult); // Listen and pass the single ConnectivityResult
  });
}

void _updateStatus(ConnectivityResult connectivityResult) {
  setState(() {
    isOnline = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: const Icon(Icons.home, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(type: PageTransitionType.fade, child: const Home()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.show_chart, color: Color(0xff44c377)),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(type: PageTransitionType.fade, child: const Harvest()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.energy_savings_leaf, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(type: PageTransitionType.fade, child: const myokra()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(type: PageTransitionType.fade, child: const settings()),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff43c175),
        title: const Text(
          'Harvest',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
         Container(
          decoration: BoxDecoration(
    color: Colors.white, // White background
    borderRadius: BorderRadius.circular(15), // Curved edges
    boxShadow: const [
      BoxShadow(
        color: Colors.black12, // Optional shadow for better appearance
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  ),
     margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Optional padding
    child: Row(
      children: [
         Icon(
          isOnline ? Icons.wifi : Icons.wifi_off,
          color: isOnline ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          isOnline ? 'Online' : 'Offline',
          style: TextStyle(
            color: isOnline ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),
  ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                  const SizedBox(height: 10,),
                _addHarvest(),
                 const SizedBox(height: 10,),
                 Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text(
                    'The Okrai Harvest statistical charts provide a comprehensive overview of harvest productivity and crop health. With features like "Insert New Harvest" for data logging and "List View" for easy record management, the dashboard empowers farmers to make informed decisions for improved harvest outcomes.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                 
                  const SizedBox(height: 10,),
                _buildHarvestCharts(),
                   const SizedBox(height: 10,),
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
             const SizedBox(height: 10,),
                _buildDiseaseCharts(),
                        const SizedBox(height: 10,),
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
             const SizedBox(height: 10,),
                _buildPestCharts(),
                  const SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addHarvest() {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xff44c377), width: 3),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Text(
            "Okra Harvest",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "STATISTICAL CHARTS",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Center(
            child: Icon(
              Icons.stacked_bar_chart,
              size: 50,
              color: Color(0xff44c377),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Expanded(
  child: ElevatedButton(
    onPressed: isOnline ? _showInsertHarvestDialog : null, // Disable when offline
    style: ElevatedButton.styleFrom(
      backgroundColor: isOnline ? const Color(0xff44c377) : Colors.grey, // Change color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
    child: Text(
      isOnline ? "Insert New Harvest" : "No Internet", // Change text
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Colors.white,
      ),
    ),
  ),
),

                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const Tables())),
                      icon: const Icon(Icons.table_chart, color: Colors.white),
                      label: const Text(
                        "List",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                   const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


void _showInsertHarvestDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String date = "";
      String area = "";
      String disease = "";
      String numberOfDiseases = "";
      String pesticides = "";
      String harvest = "";
      List<String> areaOptions = ["Area 1", "Area 2", "Area 3", "Area 4", "Area 5"];
      List<String> diseaseOptions = ["Yellow Vein", "Leaf Curl", "Early Blight","None"];

      return StatefulBuilder(
        builder: (context, setState) {
          bool isInputComplete() {
            return date.isNotEmpty &&
                area.isNotEmpty &&
                disease.isNotEmpty &&
                numberOfDiseases.isNotEmpty &&
                pesticides.isNotEmpty &&
                harvest.isNotEmpty;
          }

          Future<bool> isOnline() async {
            var connectivityResult = await Connectivity().checkConnectivity();
            return connectivityResult != ConnectivityResult.none;
          }

          return AlertDialog(
            title: const Text("Insert New Harvest"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Date Picker
                  TextField(
                    readOnly: true,
                    decoration: const InputDecoration(labelText: "Date"),
                    onTap: () async {
                      DateTime today = DateTime.now();
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: today,
                        firstDate: today, // Disables past dates
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          date = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        });
                      }
                    },
                    controller: TextEditingController(text: date),
                  ),

                  const SizedBox(height: 10),

                  // Area Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Area"),
                    value: area.isEmpty ? null : area,
                    items: areaOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        area = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Disease Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Disease"),
                    value: disease.isEmpty ? null : disease,
                    items: diseaseOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        disease = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Number of Encountered Diseases (Number Input)
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "No. Encountered Diseases"),
                    onChanged: (value) {
                      setState(() {
                        numberOfDiseases = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Pesticides TextField
                  TextField(
                    decoration: const InputDecoration(labelText: "Pesticides"),
                    onChanged: (value) {
                      setState(() {
                        pesticides = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Harvest (Number Input)
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Harvest (kg)"),
                    onChanged: (value) {
                      setState(() {
                        harvest = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: isInputComplete()
                    ? () async {
                        if (await isOnline()) {
                          // Save the harvest data to Firestore
                          try {
                            await FirebaseFirestore.instance.collection('harvests').add({
                              'date': date,
                              'area': area,
                              'disease': disease,
                              'numberOfDiseases': int.parse(numberOfDiseases),
                              'pesticides': pesticides,
                              'harvest': int.parse(harvest),
                            });
                            print("Harvest data saved successfully.");
                            Navigator.of(context).pop();
                          } catch (e) {
                            print("Failed to save harvest data: $e");
                          }
                        } else {
                          // Show snackbar for no internet
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Failed to insert data please check your internet connection.",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          });
                        }
                      }
                    : null, // Disable button if inputs are incomplete
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    },
  );
}


// Define the static temporary data
final List<ChartData> barChartData = [
  ChartData('Category A', 20),
  ChartData('Category B', 45),
  ChartData('Category C', 30),
  ChartData('Category D', 60),
];
String timeSelectedFilter = 'This Week'; // Default selected time filter

Future<QuerySnapshot> fetchHarvestData() async {
  try {
    // First try to get data from the server
    return await FirebaseFirestore.instance.collection('harvests').get();
  } catch (e) {
    // If offline, fallback to cached data
    return await FirebaseFirestore.instance
        .collection('harvests')
        .get(const GetOptions(source: Source.cache));
  }
}

String dailySelectedFilter = 'Area 1';
String monthlySelectedFilter = 'Area 1';
String yearlySelectedFilter = 'Area 1';

Widget _buildHarvestCharts() {
  return Center(
    child: GFCarousel(
         items: [
               ////////// by daily///////////////
 Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique area values from Firestore data
      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure RowselectedFilter has a valid default value
      if (!areaOptions.contains(dailySelectedFilter) && areaOptions.isNotEmpty) {
        dailySelectedFilter = areaOptions.first;
      }

      // Calculate the start and end dates for the current month
      final DateTime now = DateTime.now();
      final DateTime startDate = DateTime(now.year, now.month, 1);
      final DateTime endDate = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

      // Filter and sort Firestore data
      final List<ChartData> chartDataToShow = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String dateString = (data['date'] ?? '').toString();
                final int harvest = (data['harvest'] ?? 0);
                final String area = (data['area'] ?? '').toString();

                try {
                  final DateFormat formatter = DateFormat('yyyy-M-d');
                  final DateTime parsedDate = formatter.parse(dateString);

                  if (area == dailySelectedFilter &&
                      parsedDate.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
                      parsedDate.isBefore(endDate.add(const Duration(days: 1)))) {
                    return ChartData(parsedDate.toIso8601String(), harvest); // Store ISO8601 for sorting
                  }
                } catch (e) {
                  print("Invalid date format: $dateString. Error: $e");
                }
                return null;
              })
              .where((data) => data != null)
              .cast<ChartData>()
              .toList()
          : [];

      // Sort chart data by the parsed `DateTime` object
      chartDataToShow.sort((a, b) {
        final DateTime dateA = DateTime.parse(a.category);
        final DateTime dateB = DateTime.parse(b.category);
        return dateA.compareTo(dateB);
      });

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
             Text(
  'Daily Harvest per Area - ${DateFormat('MMMM').format(DateTime.now())}',
  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
),
                DropdownButton<String>(
                  value: dailySelectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        dailySelectedFilter = newValue;
                      });
                    }
                  },
                  items: areaOptions.map((String area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                ),
                if (chartDataToShow.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No data yet",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45, // Rotate labels for better readability
                      ),
                      title: const ChartTitle(text: ''),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartDataToShow,
                          xValueMapper: (ChartData data, _) {
                            // Extract only the day number from the date
                            final DateTime date = DateTime.parse(data.category);
                            return date.day.toString();  // Only show day number
                          },
                          yValueMapper: (ChartData data, _) => data.value,
                          color: const Color(0xff44c377),
                          borderColor: const Color.fromARGB(255, 245, 245, 245),
                          borderWidth: 1,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
      ////////// by month///////////////
   Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique area values from Firestore data
      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure RowselectedFilter has a valid default value
      if (!areaOptions.contains(monthlySelectedFilter) && areaOptions.isNotEmpty) {
        monthlySelectedFilter = areaOptions.first;
      }

      // Filter Firestore data and group by month
      final Map<int, int> monthlyHarvests = {};  // Change key to month number
      if (snapshot.hasData) {
        for (final doc in snapshot.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final String dateString = (data['date'] ?? '').toString();
          final int harvest = (data['harvest'] ?? 0);
          final String area = (data['area'] ?? '').toString();

          try {
            final DateFormat formatter = DateFormat('yyyy-M-d');
            final DateTime parsedDate = formatter.parse(dateString);

            if (area == monthlySelectedFilter && parsedDate.year == DateTime.now().year) {
              final int monthNumber = parsedDate.month;  // Get month as a number (1-12)
              monthlyHarvests[monthNumber] = (monthlyHarvests[monthNumber] ?? 0) + harvest;
            }
          } catch (e) {
            print("Invalid date format: $dateString. Error: $e");
          }
        }
      }

      // Prepare chart data sorted by month number
      final List<ChartData> chartDataToShow = monthlyHarvests.entries
          .map((entry) {
            final monthName = DateFormat.MMMM().format(DateTime(DateTime.now().year, entry.key)); // Get month name
            return ChartData(monthName, entry.value);
          })
          .toList();

      // Sort months in chronological order (1 to 12)
      chartDataToShow.sort((a, b) {
        final monthA = DateFormat('MMMM').parse(a.category).month;
        final monthB = DateFormat('MMMM').parse(b.category).month;
        return monthA.compareTo(monthB);
      });

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                       Text(
  'Monthly Harvest per Area - ${DateFormat('yyyy').format(DateTime.now())}',
  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
),
                DropdownButton<String>(
                  value: monthlySelectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        monthlySelectedFilter = newValue;
                      });
                    }
                  },
                  items: areaOptions.map((String area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                ),
                if (chartDataToShow.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No data yet",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45, // Rotate labels for better readability
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartDataToShow,
                          xValueMapper: (ChartData data, _) => data.category, // Month name
                          yValueMapper: (ChartData data, _) => data.value,    // Total harvest
                          color: const Color(0xff44c377),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
////////////////////////////year
Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique area values from Firestore data
      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure RowselectedFilter has a valid default value
      if (!areaOptions.contains(yearlySelectedFilter) && areaOptions.isNotEmpty) {
        yearlySelectedFilter = areaOptions.first;
      }

      // Filter Firestore data and group by year
      final Map<int, int> yearlyHarvests = {};  // Change key to year
      if (snapshot.hasData) {
        for (final doc in snapshot.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final String dateString = (data['date'] ?? '').toString();
          final int harvest = (data['harvest'] ?? 0);
          final String area = (data['area'] ?? '').toString();

          try {
            final DateFormat formatter = DateFormat('yyyy-M-d');
            final DateTime parsedDate = formatter.parse(dateString);

            if (area == yearlySelectedFilter) {
              final int year = parsedDate.year;  // Get the year
              yearlyHarvests[year] = (yearlyHarvests[year] ?? 0) + harvest;
            }
          } catch (e) {
            print("Invalid date format: $dateString. Error: $e");
          }
        }
      }

      // Prepare chart data
      final List<ChartData> chartDataToShow = yearlyHarvests.entries
          .map((entry) => ChartData(entry.key.toString(), entry.value))  // Convert year to string for display
          .toList();

      // Sort years in ascending order
      chartDataToShow.sort((a, b) => int.parse(a.category).compareTo(int.parse(b.category)));

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Annual Harvests per Area',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: yearlySelectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        yearlySelectedFilter = newValue;
                      });
                    }
                  },
                  items: areaOptions.map((String area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                ),
                if (chartDataToShow.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No data yet",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45, // Rotate labels for better readability
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartDataToShow,
                          xValueMapper: (ChartData data, _) => data.category, // Year
                          yValueMapper: (ChartData data, _) => data.value,    // Total harvest
                          color: const Color(0xff44c377),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

      ]
    ),
  );
}

String dailyDiseaseArea = 'Area 1';
String dailyDiseaseType = 'Leaf Curl';

String monthlyDiseaseArea = 'Area 1';
String monthlyDiseaseType = 'Leaf Curl';

String yearlyDiseaseArea = 'Area 1';
String yearlyDiseaseType = 'Leaf Curl';

Widget _buildDiseaseCharts() {
  return Center(
    child: GFCarousel(
      items: [
        ///////////////////////////////daily////////////////
        Container(
          child: FutureBuilder<QuerySnapshot>(
            future: fetchHarvestData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Extract unique disease and area values from Firestore data
              final List<String> diseaseOptions = snapshot.hasData
                  ? snapshot.data!.docs
                      .map((doc) => (doc.data() as Map<String, dynamic>)['disease'] ?? '')
                      .where((disease) => disease.toString().isNotEmpty)
                      .toSet()
                      .cast<String>()
                      .toList()
                  : [];
              diseaseOptions.sort();

              final List<String> areaOptions = snapshot.hasData
                  ? snapshot.data!.docs
                      .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
                      .where((area) => area.toString().isNotEmpty)
                      .toSet()
                      .cast<String>()
                      .toList()
                  : [];
              areaOptions.sort();

              // Ensure filters have valid default values
              if (!diseaseOptions.contains(dailyDiseaseType) && diseaseOptions.isNotEmpty) {
                dailyDiseaseType = diseaseOptions.first;
              }
              if (!areaOptions.contains(dailyDiseaseArea) && areaOptions.isNotEmpty) {
                dailyDiseaseArea = areaOptions.first;
              }

             final List<ChartData> chartDataToShow = snapshot.hasData
    ? snapshot.data!.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final String dateString = (data['date'] ?? '').toString();
          final int numberOfDiseases = (data['numberOfDiseases'] ?? 0);
          final String disease = (data['disease'] ?? '').toString();
          final String area = (data['area'] ?? '').toString();

          try {
            final DateFormat formatter = DateFormat('yyyy-M-d');
            final DateTime parsedDate = formatter.parse(dateString);

            // Get the first and last date of the current month
            final DateTime now = DateTime.now();
            final DateTime startOfMonth = DateTime(now.year, now.month, 1);
            final DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

            // Filter data by selected disease, area, and date range
            if (disease == dailyDiseaseType &&
                area == dailyDiseaseArea &&
                parsedDate.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
                parsedDate.isBefore(endOfMonth.add(const Duration(days: 1)))) {
              return ChartData(parsedDate.toIso8601String(), numberOfDiseases);
            }
          } catch (e) {
            print("Invalid date format: $dateString. Error: $e");
          }
          return null;
        })
        .where((data) => data != null)
        .cast<ChartData>()
        .toList()
    : [];


              // Sort chart data by the parsed DateTime object
              chartDataToShow.sort((a, b) {
                final DateTime dateA = DateTime.parse(a.category);
                final DateTime dateB = DateTime.parse(b.category);
                return dateA.compareTo(dateB);
              });

              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Daily Disease Detected - ${DateFormat('MMMM').format(DateTime.now())}',
  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                       
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Dropdown for disease filter
                            Expanded(
                              child: DropdownButton<String>(
                                value: dailyDiseaseType,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      dailyDiseaseType = newValue;
                                    });
                                  }
                                },
                                items: diseaseOptions.map((String disease) {
                                  return DropdownMenuItem<String>(
                                    value: disease,
                                    child: Text(disease),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Dropdown for area filter
                            Expanded(
                              child: DropdownButton<String>(
                                value: dailyDiseaseArea,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      dailyDiseaseArea = newValue;
                                    });
                                  }
                                },
                                items: areaOptions.map((String area) {
                                  return DropdownMenuItem<String>(
                                    value: area,
                                    child: Text(area),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        if (chartDataToShow.isEmpty)
                          const Expanded(
                            child: Center(
                              child: Text(
                                "No data available",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                        else
                         Expanded(
  child: SfCartesianChart(
    primaryXAxis: const CategoryAxis(
      labelRotation: 45, // Rotate labels for better readability
    ),
    series: <CartesianSeries<ChartData, String>>[
      ColumnSeries<ChartData, String>(
        dataSource: chartDataToShow,
        xValueMapper: (ChartData data, _) {
          final DateTime date = DateTime.parse(data.category);
          return DateFormat('d').format(date); // Display only the day of the month
        },
        yValueMapper: (ChartData data, _) => data.value,
        color: const Color.fromARGB(255, 212, 22, 8), // Chart color
      ),
    ],
  ),
),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        ///////////////////////////////MMONTHLY
        Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique disease and area values from Firestore data
      final List<String> diseaseOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['disease'] ?? '')
              .where((disease) => disease.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      diseaseOptions.sort();

      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure filters have valid default values
      if (!diseaseOptions.contains(monthlyDiseaseType) && diseaseOptions.isNotEmpty) {
        monthlyDiseaseType = diseaseOptions.first;
      }
      if (!areaOptions.contains(monthlyDiseaseArea) && areaOptions.isNotEmpty) {
        monthlyDiseaseArea = areaOptions.first;
      }

      // Group and sum diseases per month for the current year
      final Map<String, int> monthlyDiseaseSums = {};
      if (snapshot.hasData) {
        for (var doc in snapshot.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final String dateString = (data['date'] ?? '').toString();
          final int numberOfDiseases = (data['numberOfDiseases'] ?? 0);
          final String disease = (data['disease'] ?? '').toString();
          final String area = (data['area'] ?? '').toString();

          try {
            final DateFormat formatter = DateFormat('yyyy-M-d');
            final DateTime parsedDate = formatter.parse(dateString);

            final DateTime now = DateTime.now();
            if (parsedDate.year == now.year &&
                disease == monthlyDiseaseType &&
                area == monthlyDiseaseArea) {
              final String monthName = DateFormat('MMMM').format(parsedDate); // Get month name
              monthlyDiseaseSums[monthName] = (monthlyDiseaseSums[monthName] ?? 0) + numberOfDiseases;
            }
          } catch (e) {
            print("Invalid date format: $dateString. Error: $e");
          }
        }
      }

      // Sort months in order starting from January
      final List<ChartData> chartDataToShow = monthlyDiseaseSums.entries
          .map((entry) => ChartData(entry.key, entry.value))
          .toList();
      chartDataToShow.sort((a, b) => DateFormat('MMMM').parse(a.category).month.compareTo(DateFormat('MMMM').parse(b.category).month));

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Monthly Disease Detected - ${DateTime.now().year}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown for disease filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: monthlyDiseaseType,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              monthlyDiseaseType = newValue;
                            });
                          }
                        },
                        items: diseaseOptions.map((String disease) {
                          return DropdownMenuItem<String>(
                            value: disease,
                            child: Text(disease),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Dropdown for area filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: monthlyDiseaseArea,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              monthlyDiseaseArea = newValue;
                            });
                          }
                        },
                        items: areaOptions.map((String area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                if (chartDataToShow.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45,
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartDataToShow,
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          color: const Color.fromARGB(255, 212, 22, 8), // Chart color
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
//////////////////////yearly
Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique disease and area values from Firestore data
      final List<String> diseaseOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['disease'] ?? '')
              .where((disease) => disease.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      diseaseOptions.sort();

      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure filters have valid default values
      if (!diseaseOptions.contains(yearlyDiseaseType) && diseaseOptions.isNotEmpty) {
        yearlyDiseaseType = diseaseOptions.first;
      }
      if (!areaOptions.contains(yearlyDiseaseArea) && areaOptions.isNotEmpty) {
        yearlyDiseaseArea = areaOptions.first;
      }

      // Group and sum diseases per year
      final Map<int, int> yearlyDiseaseSums = {};
      if (snapshot.hasData) {
        for (var doc in snapshot.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          final String dateString = (data['date'] ?? '').toString();
          final int numberOfDiseases = (data['numberOfDiseases'] ?? 0);
          final String disease = (data['disease'] ?? '').toString();
          final String area = (data['area'] ?? '').toString();

          try {
            final DateFormat formatter = DateFormat('yyyy-M-d');
            final DateTime parsedDate = formatter.parse(dateString);

            if (disease == yearlyDiseaseType && area == yearlyDiseaseArea) {
              final int year = parsedDate.year; // Extract year
              yearlyDiseaseSums[year] = (yearlyDiseaseSums[year] ?? 0) + numberOfDiseases;
            }
          } catch (e) {
            print("Invalid date format: $dateString. Error: $e");
          }
        }
      }

      // Convert yearly sums to a list of ChartData and sort by year
      final List<ChartData> chartDataToShow = yearlyDiseaseSums.entries
          .map((entry) => ChartData(entry.key.toString(), entry.value))
          .toList();
      chartDataToShow.sort((a, b) => int.parse(a.category).compareTo(int.parse(b.category))); // Sort by year

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Yearly Disease Detected',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown for disease filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: yearlyDiseaseType,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              yearlyDiseaseType = newValue;
                            });
                          }
                        },
                        items: diseaseOptions.map((String disease) {
                          return DropdownMenuItem<String>(
                            value: disease,
                            child: Text(disease),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Dropdown for area filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: yearlyDiseaseArea,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              yearlyDiseaseArea = newValue;
                            });
                          }
                        },
                        items: areaOptions.map((String area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                if (chartDataToShow.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 0, // No label rotation needed for years
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartDataToShow,
                          xValueMapper: (ChartData data, _) => data.category, // Year
                          yValueMapper: (ChartData data, _) => data.value,   // Sum of diseases
                          color: const Color.fromARGB(255, 212, 22, 8), // Chart color
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
)

      ],
    ),
  );
}

String dailyPestArea = 'Area 1';
String dailyPestType = 'Leaf Curl';

String monthlyPestArea = 'Area 1';
String monthlyPestType = 'Leaf Curl';

String yearlyPestArea = 'Area 1';
String yearlyPestType = 'Leaf Curl';

Widget _buildPestCharts() {
 return Center(
    child: GFCarousel(
      items: [
        ///////////////////////////////daily////////////////
    Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique disease and area values from Firestore data
      final List<String> diseaseOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['disease'] ?? '')
              .where((disease) => disease.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      diseaseOptions.sort();

      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure filters have valid default values
      if (!diseaseOptions.contains(dailyPestType) && diseaseOptions.isNotEmpty) {
        dailyPestType = diseaseOptions.first;
      }
      if (!areaOptions.contains(dailyPestArea) && areaOptions.isNotEmpty) {
        dailyPestArea = areaOptions.first;
      }

      // Chart data for pesticides used
      final Map<String, int> pesticideCounts = snapshot.hasData
          ? snapshot.data!.docs
              .where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String dateString = (data['date'] ?? '').toString();
                final String disease = (data['disease'] ?? '').toString();
                final String area = (data['area'] ?? '').toString();

                try {
                  final DateFormat formatter = DateFormat('yyyy-M-d');
                  final DateTime parsedDate = formatter.parse(dateString);

                  // Get the first and last date of the current month
                  final DateTime now = DateTime.now();
                  final DateTime startOfMonth = DateTime(now.year, now.month, 1);
                  final DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

                  // Filter data by selected disease, area, and date range
                  return disease == dailyPestType &&
                      area == dailyPestArea &&
                      parsedDate.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
                      parsedDate.isBefore(endOfMonth.add(const Duration(days: 1)));
                } catch (e) {
                  print("Invalid date format: $dateString. Error: $e");
                  return false;
                }
              })
              .fold<Map<String, int>>({}, (counts, doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String pesticide = (data['pesticides'] ?? '').toString();

                if (pesticide.isNotEmpty) {
                  counts[pesticide] = (counts[pesticide] ?? 0) + 1;
                }
                return counts;
              })
          : {};

      // Get the top 5 pesticides by count
      final List<ChartData> pesticideChartData = pesticideCounts.entries
          .map((entry) => ChartData(entry.key, entry.value))
          .toList()
          ..sort((a, b) => b.value.compareTo(a.value)); // Sort by descending order
      final List<ChartData> top5Pesticides = pesticideChartData.take(5).toList();

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Top 5 Pesticides Used - ${DateFormat('MMMM').format(DateTime.now())}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown for disease filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: dailyPestType,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              dailyPestType = newValue;
                            });
                          }
                        },
                        items: diseaseOptions.map((String disease) {
                          return DropdownMenuItem<String>(
                            value: disease,
                            child: Text(disease),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Dropdown for area filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: dailyPestArea,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              dailyPestArea = newValue;
                            });
                          }
                        },
                        items: areaOptions.map((String area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                if (top5Pesticides.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No pesticide data available",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45, // Rotate labels for better readability
                    
                      ),
                      primaryYAxis: const NumericAxis(
                    
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: top5Pesticides,
                          xValueMapper: (ChartData data, _) => data.category, // Pesticide name
                          yValueMapper: (ChartData data, _) => data.value, // Count of usage
                          color: const Color(0xff44c377), // Chart color
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

        ///////////////////////////////monthly
        ///
        Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique disease and area values from Firestore data
      final List<String> diseaseOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['disease'] ?? '')
              .where((disease) => disease.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      diseaseOptions.sort();

      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure filters have valid default values
      if (!diseaseOptions.contains(monthlyPestType) && diseaseOptions.isNotEmpty) {
        monthlyPestType = diseaseOptions.first;
      }
      if (!areaOptions.contains(monthlyPestArea) && areaOptions.isNotEmpty) {
        monthlyPestArea = areaOptions.first;
      }

      // Chart data for pesticides used in the current year
      final Map<String, int> pesticideCounts = snapshot.hasData
          ? snapshot.data!.docs
              .where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String dateString = (data['date'] ?? '').toString();
                final String disease = (data['disease'] ?? '').toString();
                final String area = (data['area'] ?? '').toString();

                try {
                  final DateFormat formatter = DateFormat('yyyy-M-d');
                  final DateTime parsedDate = formatter.parse(dateString);

                  // Get the first and last date of the current year
                  final DateTime now = DateTime.now();
                  final DateTime startOfYear = DateTime(now.year, 1, 1);
                  final DateTime endOfYear = DateTime(now.year, 12, 31);

                  // Filter data by selected disease, area, and date range
                  return disease == monthlyPestType &&
                      area == monthlyPestArea &&
                      parsedDate.isAfter(startOfYear.subtract(const Duration(days: 1))) &&
                      parsedDate.isBefore(endOfYear.add(const Duration(days: 1)));
                } catch (e) {
                  print("Invalid date format: $dateString. Error: $e");
                  return false;
                }
              })
              .fold<Map<String, int>>({}, (counts, doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String pesticide = (data['pesticides'] ?? '').toString();

                if (pesticide.isNotEmpty) {
                  counts[pesticide] = (counts[pesticide] ?? 0) + 1;
                }
                return counts;
              })
          : {};

      // Get the top 5 pesticides by count
      final List<ChartData> pesticideChartData = pesticideCounts.entries
          .map((entry) => ChartData(entry.key, entry.value))
          .toList()
          ..sort((a, b) => b.value.compareTo(a.value)); // Sort by descending order
      final List<ChartData> top5Pesticides = pesticideChartData.take(5).toList();

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Top 5 Pesticides Used - ${DateFormat('yyyy').format(DateTime.now())}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown for disease filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: monthlyPestType,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              monthlyPestType= newValue;
                            });
                          }
                        },
                        items: diseaseOptions.map((String disease) {
                          return DropdownMenuItem<String>(
                            value: disease,
                            child: Text(disease),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Dropdown for area filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: monthlyPestArea,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              monthlyPestArea = newValue;
                            });
                          }
                        },
                        items: areaOptions.map((String area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                if (top5Pesticides.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No pesticide data available for this year",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45, // Rotate labels for better readability
                      
                      ),
                      primaryYAxis: const NumericAxis(
                     
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: top5Pesticides,
                          xValueMapper: (ChartData data, _) => data.category, // Pesticide name
                          yValueMapper: (ChartData data, _) => data.value, // Count of usage
                          color: const Color(0xff44c377), // Chart color
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
/////////////////////////
Container(
  child: FutureBuilder<QuerySnapshot>(
    future: fetchHarvestData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Extract unique disease and area values from Firestore data
      final List<String> diseaseOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['disease'] ?? '')
              .where((disease) => disease.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      diseaseOptions.sort();

      final List<String> areaOptions = snapshot.hasData
          ? snapshot.data!.docs
              .map((doc) => (doc.data() as Map<String, dynamic>)['area'] ?? '')
              .where((area) => area.toString().isNotEmpty)
              .toSet()
              .cast<String>()
              .toList()
          : [];
      areaOptions.sort();

      // Ensure filters have valid default values
      if (!diseaseOptions.contains(yearlyPestType) && diseaseOptions.isNotEmpty) {
        yearlyPestType = diseaseOptions.first;
      }
      if (!areaOptions.contains(yearlyPestArea) && areaOptions.isNotEmpty) {
        yearlyPestArea = areaOptions.first;
      }

      // Chart data for overall pesticide usage
      final Map<String, int> pesticideCounts = snapshot.hasData
          ? snapshot.data!.docs
              .where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String disease = (data['disease'] ?? '').toString();
                final String area = (data['area'] ?? '').toString();

                // Filter data by selected disease and area
                return disease == yearlyPestType && area == yearlyPestArea;
              })
              .fold<Map<String, int>>({}, (counts, doc) {
                final data = doc.data() as Map<String, dynamic>;
                final String pesticide = (data['pesticides'] ?? '').toString();

                if (pesticide.isNotEmpty) {
                  counts[pesticide] = (counts[pesticide] ?? 0) + 1;
                }
                return counts;
              })
          : {};

      // Get the top 5 pesticides by count
      final List<ChartData> pesticideChartData = pesticideCounts.entries
          .map((entry) => ChartData(entry.key, entry.value))
          .toList()
          ..sort((a, b) => b.value.compareTo(a.value)); // Sort by descending order
      final List<ChartData> top5Pesticides = pesticideChartData.take(5).toList();

      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Top 5 Pesticides Used - Overall',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown for disease filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: yearlyPestType,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              yearlyPestType = newValue;
                            });
                          }
                        },
                        items: diseaseOptions.map((String disease) {
                          return DropdownMenuItem<String>(
                            value: disease,
                            child: Text(disease),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Dropdown for area filter
                    Expanded(
                      child: DropdownButton<String>(
                        value: yearlyPestArea,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              yearlyPestArea = newValue;
                            });
                          }
                        },
                        items: areaOptions.map((String area) {
                          return DropdownMenuItem<String>(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                if (top5Pesticides.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No pesticide data available",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 45, // Rotate labels for better readability
                       
                      ),
                      primaryYAxis: const NumericAxis(
                     
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: top5Pesticides,
                          xValueMapper: (ChartData data, _) => data.category, // Pesticide name
                          yValueMapper: (ChartData data, _) => data.value, // Count of usage
                          color: const Color(0xff44c377), // Chart color
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

      ],
    ),
  );
}
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}