import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictYield extends StatefulWidget {
  const PredictYield({super.key});

  @override
  State<PredictYield> createState() => _PredictYieldState();
}

class _PredictYieldState extends State<PredictYield> {
  Interpreter? _interpreter;

  // Sorted Disease types and pesticide names
  final List<String> _typesOfDiseases = [
    'Early Blight Disease',
    'Leaf Curl Disease',
    'Yellow Vein Disease',
    'None',
  ];
  final List<String> _pesticidesUsed = [
    'Acetamiprid 250 grams',
    'Acetamiprid 300 grams',
    'Acetamiprid 400 grams',
    'Carbaryl 250 grams',
    'Carbaryl 400 grams',
    'Carbaryl 500 grams',
    'Cull',
    'Fungaran 200 grams',
    'Fungaran 400 grams',
    'Vermicast',
    'None',
  ];

  String? _selectedTypeOfDisease;
  String? _selectedPesticide;
  int? _encounteredDiseaseCount;
  double? _predictedHarvestKilos;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/okra_yield_model.tflite');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  void _predictYield() {
    if (_interpreter == null || _encounteredDiseaseCount == null || _selectedTypeOfDisease == null || _selectedPesticide == null) {
      return;
    }

    // Prepare input tensor (convert input data to a float array)
    var input = [
      [
        _encounteredDiseaseCount!.toDouble(),
        _typesOfDiseases.indexOf(_selectedTypeOfDisease!).toDouble(),
        _pesticidesUsed.indexOf(_selectedPesticide!).toDouble(),
      ]
    ];

    // Prepare output tensor with correct shape [1, 1]
    var output = List.generate(1, (_) => List.filled(1, 0.0)); // 2D list with shape [1, 1]

    try {
      // Run the interpreter to get the prediction
      _interpreter?.run(input, output);

      // Update the state with the predicted value
      setState(() {
        _predictedHarvestKilos = output[0][0];
      });
    } catch (e) {
      print("Error during prediction: $e");
    }
  }

  bool _isButtonEnabled() {
    return _encounteredDiseaseCount != null && _selectedTypeOfDisease != null && _selectedPesticide != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Predict Okra Yield",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xff44c377),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Encountered Disease in Okra"),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter number of encountered diseases"),
              onChanged: (value) {
                setState(() {
                  _encounteredDiseaseCount = int.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 16),

            const Text("What Types of Disease"),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedTypeOfDisease,
              items: _typesOfDiseases.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTypeOfDisease = newValue!;
                });
              },
              hint: const Text("Select Type of Disease"),
            ),
            const SizedBox(height: 16),

            const Text("Name of Used Pesticides"),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedPesticide,
              items: _pesticidesUsed.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPesticide = newValue!;
                });
              },
              hint: const Text("Select Pesticide"),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _isButtonEnabled() ? _predictYield : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff44c377),
                disabledBackgroundColor: Colors.grey,
              ),
              child: const Text(
                "Predict Harvest Kilos",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            if (_predictedHarvestKilos != null)
              Center(
                child: Text(
                  "Predicted Harvest Kilos: ${_predictedHarvestKilos!.toStringAsFixed(2)} kg",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}
