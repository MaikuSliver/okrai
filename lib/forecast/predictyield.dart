import 'dart:io';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class PredictYield extends StatefulWidget {
  const PredictYield({super.key});

  @override
  State<PredictYield> createState() => _PredictYieldState();
}

class _PredictYieldState extends State<PredictYield> {
late RegressionModel model;
  String _prediction = '';
  Map<String, double> pesticideEncoding = {}; // Map to store pesticide encodings
  String _metrics = ''; // To store evaluation metrics
List<DataPoint> _sortedDataPoints = []; // for sorted data
  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  void _initializeModel() async {
  List<DataPoint> dataPoints = await loadAndPreprocessData();
  model = RegressionModel();
  model.train(dataPoints, 1000);

  List<double> actual = dataPoints.map((data) => data.harvest).toList();
  List<double> predicted = model.computePredictions(dataPoints);

  double mse = calculateMSE(actual, predicted);
  double mae = calculateMAE(actual, predicted);
  double rmse = calculateRMSE(actual, predicted);
  double rSquared = calculateRSquared(actual, predicted);

  // Sort dataPoints by harvest value (ascending)
  dataPoints.sort((a, b) => a.harvest.compareTo(b.harvest));

  setState(() {
    _metrics = '''
MSE: ${mse.toStringAsFixed(2)}
MAE: ${mae.toStringAsFixed(2)}
RMSE: ${rmse.toStringAsFixed(2)}
R²: ${rSquared.toStringAsFixed(2)}
''';
    _sortedDataPoints = dataPoints;
  });
}


  Future<List<DataPoint>> loadAndPreprocessData() async {
    // Get the path to the CSV file in local storage
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/harvest_data.csv';
    final file = File(filePath);

    // Read the CSV file
    final rawData = await file.readAsString();
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(rawData);

    // Preprocess the data
    List<DataPoint> dataPoints = [];
    for (var row in csvTable.skip(1)) {
      // Skip header row
      double area = row[1] == 'Area 1' ? 0.0 : 1.0; // Convert Area to numerical
      double disease = row[2] == 'Leaf Curl' ? 0.0 : 1.0; // Convert Disease to numerical
      double numberOfDiseases = row[3].toDouble();

      // Convert Pesticide (string) to numerical using label encoding
      String pesticide = row[4];
      double encodedPesticide = _encodePesticide(pesticide);

      double harvest = row[5].toDouble();

      dataPoints.add(DataPoint(
        area: area,
        disease: disease,
        numberOfDiseases: numberOfDiseases,
        pesticides: encodedPesticide,
        harvest: harvest,
      ));
    }

    return dataPoints;
  }

  double _encodePesticide(String pesticide) {
    // Assign a unique numerical value to each pesticide
    if (!pesticideEncoding.containsKey(pesticide)) {
      pesticideEncoding[pesticide] = pesticideEncoding.length.toDouble();
    }
    return pesticideEncoding[pesticide]!;
  }

  void _predict() {
    // Example input for prediction
    double area = 0.0; // Area 1
    double disease = 1.0; // Yellow Vein
    double numberOfDiseases = 200.0;
    double pesticides = _encodePesticide('tytg'); // Example pesticide

    List<double> features = [area, disease, numberOfDiseases, pesticides];
    double prediction = model.predict(features);
    setState(() {
      _prediction = 'Predicted Harvest: $prediction kg';
    });
  }
double calculateMSE(List<double> actual, List<double> predicted) {
  double sum = 0.0;
  for (int i = 0; i < actual.length; i++) {
    sum += (actual[i] - predicted[i]) * (actual[i] - predicted[i]);
  }
  return sum / actual.length;
}

double calculateMAE(List<double> actual, List<double> predicted) {
  double sum = 0.0;
  for (int i = 0; i < actual.length; i++) {
    sum += (actual[i] - predicted[i]).abs();
  }
  return sum / actual.length;
}

double calculateRMSE(List<double> actual, List<double> predicted) {
  return sqrt(calculateMSE(actual, predicted));
}

double calculateRSquared(List<double> actual, List<double> predicted) {
  double meanActual = actual.reduce((a, b) => a + b) / actual.length;
  double ssTotal = 0.0;
  double ssResidual = 0.0;

  for (int i = 0; i < actual.length; i++) {
    ssTotal += (actual[i] - meanActual) * (actual[i] - meanActual);
    ssResidual += (actual[i] - predicted[i]) * (actual[i] - predicted[i]);
  }

  return 1 - (ssResidual / ssTotal);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regression Model')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _predict,
              child: const Text('Predict Harvest'),
            ),
            const SizedBox(height: 20),
            Text(_prediction),
            const SizedBox(height: 20),
            Text('Evaluation Metrics:\n$_metrics'), // Display metrics
          ],
        ),
      ),
    );
  }
}


class DataPoint {
  final double area;
  final double disease;
  final double numberOfDiseases;
  final double pesticides; // Now a numerical value
  final double harvest;

  DataPoint({
    required this.area,
    required this.disease,
    required this.numberOfDiseases,
    required this.pesticides,
    required this.harvest,
  });
}

class RegressionModel {
  List<double> weights; // Model weights
  double bias; // Model bias
  final double learningRate; // Learning rate for gradient descent

  // Constructor to initialize weights, bias, and learning rate
  RegressionModel({List<double>? weights, this.bias = 0.0, this.learningRate = 0.01})
      : weights = weights ?? [0.0, 0.0, 0.0, 0.0];

  // Predict the output based on input features
  double predict(List<double> features) {
    double prediction = bias;
    for (int i = 0; i < features.length; i++) {
      prediction += weights[i] * features[i];
    }
    return prediction;
  }

  // Train the model using gradient descent
  void train(List<DataPoint> dataPoints, int epochs) {
    for (int epoch = 0; epoch < epochs; epoch++) {
      for (var data in dataPoints) {
        // Create a new modifiable list for features
        List<double> features = [data.area, data.disease, data.numberOfDiseases, data.pesticides];
        double target = data.harvest;

        // Compute prediction
        double prediction = predict(features);

        // Compute error
        double error = prediction - target;

        // Update weights and bias using gradient descent
        for (int i = 0; i < weights.length; i++) {
          weights[i] -= learningRate * error * features[i];
        }
        bias -= learningRate * error;
      }
    }
  }

  // Compute predictions for the entire dataset
  List<double> computePredictions(List<DataPoint> dataPoints) {
    List<double> predictions = [];
    for (var data in dataPoints) {
      List<double> features = [data.area, data.disease, data.numberOfDiseases, data.pesticides];
      predictions.add(predict(features));
    }
    return predictions;
  }
}