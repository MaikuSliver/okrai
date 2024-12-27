import 'package:flutter/material.dart';
import 'package:okrai/mainscreens/Home.dart';
import 'package:okrai/mainscreens/myokra.dart';
import 'package:okrai/mainscreens/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Harvest extends StatefulWidget {
  const Harvest({super.key});

  @override
  State<Harvest> createState() => _HarvestState();
}
  
String selectedFilter = 'This Year';
String RowselectedFilter = 'All';

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
      List<String> areaOptions = ["Row 1", "Row 2", "Row 3"];
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
                    ? () {
                        // Save the harvest data here
                        print("Date: $date");
                        print("Area: $area");
                        print("Disease: $disease");
                        print("Pesticides: $pesticides");
                        print("Harvest: $harvest");
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

Widget _buildHarvestCharts() {
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
                      'Harvest',
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