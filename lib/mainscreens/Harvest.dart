import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:okrai/mainscreens/Home.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Harvest extends StatefulWidget {
  const Harvest({super.key});

  @override
  State<Harvest> createState() => _HarvestState();
}
  
String selectedFilter = 'This Year';
String RowselectedFilter = 'Row 1';

class _HarvestState extends State<Harvest> {
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
        title: const Center(
          child: Text(
            'Harvest',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
                _addHarvest(),
                _buildHarvestCharts(),
                _buildDiseaseCharts(),
                _buildPestCharts(),
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showInsertHarvestDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff44c377),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "Insert New Harvest",
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

void _showInsertHarvestDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String date = "";
      String area = "";
      String disease = "";
      String pesticides = "";
      String harvest = "";
      List<String> areaOptions = ["Area 1","Area 2","Area 3","Area 4","Area 5",];
      List<String> diseaseOptions = ["Yellow Vein", "Leaf Curl", "Early Blight"];

      return StatefulBuilder(
        builder: (context, setState) {
          bool isInputComplete() {
            return date.isNotEmpty &&
                area.isNotEmpty &&
                disease.isNotEmpty &&
                pesticides.isNotEmpty &&
                harvest.isNotEmpty;
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
                        // Save the harvest data to Firestore
                        try {
                          await FirebaseFirestore.instance.collection('harvests').add({
                            'date': date,
                            'area': area,
                            'disease': disease,
                            'pesticides': pesticides,
                            'harvest': int.parse(harvest),
                          });
                          print("Harvest data saved successfully.");
                        } catch (e) {
                          print("Failed to save harvest data: $e");
                        }
                        Navigator.of(context).pop();
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
      if (!areaOptions.contains(RowselectedFilter) && areaOptions.isNotEmpty) {
        RowselectedFilter = areaOptions.first;
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

                  if (area == RowselectedFilter &&
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
                  value: RowselectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        RowselectedFilter = newValue;
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
      if (!areaOptions.contains(RowselectedFilter) && areaOptions.isNotEmpty) {
        RowselectedFilter = areaOptions.first;
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

            if (area == RowselectedFilter && parsedDate.year == DateTime.now().year) {
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
                  value: RowselectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        RowselectedFilter = newValue;
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
      if (!areaOptions.contains(RowselectedFilter) && areaOptions.isNotEmpty) {
        RowselectedFilter = areaOptions.first;
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

            if (area == RowselectedFilter) {
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
                  value: RowselectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        RowselectedFilter = newValue;
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








Widget _buildDiseaseCharts() {
  // Use the temporary data when no actual data is available
  final bool hasBarData = barChartData.isNotEmpty;
  final List<ChartData> chartDataToShow = hasBarData ? barChartData : barChartData;

  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.5, // Adjust height based on screen size
      width: MediaQuery.of(context).size.height * 1, // Adjust width based on screen size
      child: 
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
                      'Disease Detect',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: RowselectedFilter,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            RowselectedFilter = newValue;
                          });
                        }
                      },
                      items: ['Row 1', 'Row 2', 'All'].map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                    ),
                      DropdownButton<String>(
                      value: selectedFilter,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedFilter = newValue;
                          });
                        }
                      },
                      items: ['This Week', 'This Month', 'This Year'].map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Expanded(
                  child: hasBarData || chartDataToShow.isNotEmpty
                      ? SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          title: const ChartTitle(text: ''),
                          series: <CartesianSeries<ChartData, String>>[
                            ColumnSeries<ChartData, String>(
                              dataSource: chartDataToShow,
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
        
   
    ),
  );
}

Widget _buildPestCharts() {
  // Use the temporary data when no actual data is available
  final bool hasBarData = barChartData.isNotEmpty;
  final List<ChartData> chartDataToShow = hasBarData ? barChartData : barChartData;

  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.5, // Adjust height based on screen size
      width: MediaQuery.of(context).size.height * 1, // Adjust width based on screen size
      child: 
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
                      'Pesticides Used',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: RowselectedFilter,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            RowselectedFilter = newValue;
                          });
                        }
                      },
                      items: ['Row 1', 'Row 2', 'All'].map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                    ),
                      DropdownButton<String>(
                      value: selectedFilter,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedFilter = newValue;
                          });
                        }
                      },
                      items: ['This Week', 'This Month', 'This Year'].map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Expanded(
                  child: hasBarData || chartDataToShow.isNotEmpty
                      ? SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          title: const ChartTitle(text: ''),
                          series: <CartesianSeries<ChartData, String>>[
                            ColumnSeries<ChartData, String>(
                              dataSource: chartDataToShow,
                              xValueMapper: (ChartData data, _) => data.category,
                              yValueMapper: (ChartData data, _) => data.value,
                              color: const Color(0xff44c377),
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
        
   
    ),
  );
}
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}