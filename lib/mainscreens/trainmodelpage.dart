import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

class TrainModelPage extends StatefulWidget {
  const TrainModelPage({super.key});

  @override
  _TrainModelPageState createState() => _TrainModelPageState();
}

class _TrainModelPageState extends State<TrainModelPage> {
  late DataFrame dataframe;
  late LinearRegressor model;
  bool modelTrained = false;

  List<String> areaOptions = [];
  List<String> diseaseOptions = [];
  List<String> pesticidesOptions = [];

  String? selectedArea;
  String? selectedDisease;
  String? selectedPesticides;
  TextEditingController numberOfDiseasesController = TextEditingController();

  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Storage permission granted");
    } else {
      throw Exception("Storage permission denied");
    }
  }

  Future<void> loadAndProcessCSV() async {
    try {
      await requestStoragePermission();

      const filePath = '/storage/emulated/0/Android/data/com.example.okrai/files/harvest_data.csv';
      final file = File(filePath);

      if (await file.exists()) {
        final csvData = await file.readAsString();
        final rows = const CsvToListConverter().convert(csvData);

        final header = rows.first.map((e) => e.toString()).toList();
        final data = rows.sublist(1);

        final areaSet = <String>{};
        final diseaseSet = <String>{};
        final pesticidesSet = <String>{};

        final processedData = data.map((row) {
          final area = row[header.indexOf('Area')].toString();
          final disease = row[header.indexOf('Disease')].toString();
          final pesticides = row[header.indexOf('Pesticides')].toString();

          areaSet.add(area);
          diseaseSet.add(disease);
          pesticidesSet.add(pesticides);

          final numberOfDiseases = row[header.indexOf('Number of Diseases')] as int;
          final harvest = row[header.indexOf('Harvest (kg)')] as int;

          return [
            area == 'Area 2' ? 1.0 : 0.0,
            disease == 'Yellow Vein' ? 1.0 : 0.0,
            numberOfDiseases.toDouble(),
            pesticides == 'rtgx' ? 1.0 : 0.0,
            harvest.toDouble(),
          ];
        }).toList();

        setState(() {
          areaOptions = areaSet.toList();
          diseaseOptions = diseaseSet.toList();
          pesticidesOptions = pesticidesSet.toList();
          dataframe = DataFrame(processedData, header: [
            'Area',
            'Disease',
            'Number of Diseases',
            'Pesticides',
            'Harvest (kg)',
          ]);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("CSV Loaded and Processed Successfully")),
        );
      } else {
        throw Exception("File not found");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading CSV: $e")),
      );
    }
  }

  Future<void> trainModel() async {
    try {
      const targetName = 'Harvest (kg)'; // Target column name

      model = LinearRegressor(
        dataframe,
        targetName,
      );

      setState(() {
        modelTrained = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Model Trained Successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error training model: $e")),
      );
    }
  }

  Future<void> saveModel() async {
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Storage permission is required to save Model.'),
            ),
          );
          return;
        }
      }
      final directory = await getApplicationDocumentsDirectory();
      const filePath = '/storage/emulated/0/Android/data/com.example.okrai/files/harvest_model.json';

      final json = await model.saveAsJson('harvest_model');
      if (json is! String) {
        throw Exception("Model's JSON is not a string");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Model saved to $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving model: $e")),
      );
    }
  }

 Future<void> testModel() async {
  try {
    if (!modelTrained) {
      throw Exception("Model not trained yet");
    }

    // Parse inputs
    final areaValue = selectedArea == '' ? 1.0 : 0.0;
    final diseaseValue = selectedDisease == '' ? 1.0 : 0.0;
    final pesticidesValue = selectedPesticides == '' ? 1.0 : 0.0;
    final numberOfDiseasesValue = double.tryParse(numberOfDiseasesController.text) ?? 0.0;

    final inputs = [areaValue, diseaseValue, numberOfDiseasesValue, pesticidesValue];

    // Debugging prints
    print("Input Values: $inputs");
    print("Expected Feature Count: ${dataframe.header.length - 1}");

    // Ensure inputs array matches the expected feature count
    if (inputs.length != dataframe.header.length - 1) {
      throw Exception(
        "Input count (${inputs.length}) does not match model feature count (${dataframe.header.length - 1})",
      );
    }

    // Construct the DataFrame for prediction
    final predictionDataFrame = DataFrame(
      [inputs], // List containing a single row of inputs
      header: ['Area', 'Disease', 'Number of Diseases', 'Pesticides'], // Headers matching the model features
    );

    // Debugging prints for validation
    print("Prediction DataFrame Header: ${predictionDataFrame.header}");
    print("Prediction DataFrame Row Count: ${predictionDataFrame.rows.length}");
    print("Prediction DataFrame: ${predictionDataFrame.toString()}");

    // Perform prediction
    final prediction = model.predict(predictionDataFrame);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Prediction: ${prediction[0]} kg")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error testing model: $e")),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Train ML Model"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: loadAndProcessCSV,
              child: const Text("Load and Process CSV"),
            ),
            ElevatedButton(
              onPressed: trainModel,
              child: const Text("Train Model"),
            ),
            ElevatedButton(
              onPressed: saveModel,
              child: const Text("Save Model"),
            ),
            const SizedBox(height: 16),
            if (areaOptions.isNotEmpty)
              DropdownButton<String>(
                value: selectedArea,
                hint: const Text("Select Area"),
                items: areaOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedArea = value;
                  });
                },
              ),
            const SizedBox(height: 8),
            if (diseaseOptions.isNotEmpty)
              DropdownButton<String>(
                value: selectedDisease,
                hint: const Text("Select Disease"),
                items: diseaseOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDisease = value;
                  });
                },
              ),
            const SizedBox(height: 8),
            if (pesticidesOptions.isNotEmpty)
              DropdownButton<String>(
                value: selectedPesticides,
                hint: const Text("Select Pesticides"),
                items: pesticidesOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPesticides = value;
                  });
                },
              ),
            const SizedBox(height: 8),
            TextField(
              controller: numberOfDiseasesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Diseases',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: testModel,
              child: const Text("Test Model"),
            ),
          ],
        ),
      ),
    );
  }
}
