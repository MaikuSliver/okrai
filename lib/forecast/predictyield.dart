import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictYield extends StatefulWidget {
  const PredictYield({super.key});

  @override
  State<PredictYield> createState() => _PredictYieldState();
}

class _PredictYieldState extends State<PredictYield> {
 Interpreter? _interpreter;

  // Mapping strings to integers (Label Encoding)
  final Map<String, int> _diseaseTypeMapping = {
    'Early Blight Disease': 0,
    'Leaf Curl Disease': 1,
    'Yellow Vein Disease': 2,
    'None': 3,
  };

  final Map<String, int> _pesticideMapping = {
    'Acetamiprid 250 grams': 0,
    'Acetamiprid 300 grams': 1,
    'Acetamiprid 400 grams': 2,
    'Carbaryl 250 grams': 3,
    'Carbaryl 400 grams': 4,
    'Carbaryl 500 grams': 5,
    'Cull': 6,
    'Fungaran 200 grams': 7,
    'Fungaran 400 grams': 8,
    'Vermicast': 9,
    'None': 10,
  };

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

  // Prepare each input tensor as a List<Object>
  var diseaseTypeInput = [_diseaseTypeMapping[_selectedTypeOfDisease]!.toDouble()];
  var numberAffectedInput = [_encounteredDiseaseCount!.toDouble()];
  var solutionInput = [_pesticideMapping[_selectedPesticide]!.toDouble()];

  // Prepare output tensor
   var output = <int, List<List<double>>>{0: List.filled(1, [0.0])}; // Adjust as needed based on model output

  try {
    // Run the interpreter with the three inputs
    _interpreter?.runForMultipleInputs([diseaseTypeInput, numberAffectedInput, solutionInput], output);
    
    
    setState(() {
      _predictedHarvestKilos = output[0]![0][0];

      // Ensure that _predictedHarvestKilos is not null before performing operations
      double harvestAdjustment = 0;

      if (_encounteredDiseaseCount != null) {
        if (_encounteredDiseaseCount! < 10) {
          harvestAdjustment += 600;  // 1 digit
        } else if (_encounteredDiseaseCount! < 100) {
          harvestAdjustment += 400;  // 2 digits
        } else if (_encounteredDiseaseCount! < 300) {
          harvestAdjustment += 200;  // 3 digits
        } else if (_encounteredDiseaseCount! < 500) {
          harvestAdjustment -= 30;   // 400 up to 500
        } else if (_encounteredDiseaseCount! < 1000) {
          harvestAdjustment -= 200*0.76;  // 800 up to 1000
        } else if (_encounteredDiseaseCount! < 1500) {
          harvestAdjustment -= 500;  // 1100 up to 1500
           } else if (_encounteredDiseaseCount! < 2000) {
          harvestAdjustment -= 1000;  // 1500 up to 2000
        } else {
          // 2000 and above
          _predictedHarvestKilos = 0; // Set to 0 for very low harvest
          // You can add a message to inform the user if needed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Very Low Harvest')),
          );
          return; // Exit the function to avoid further processing
        }
      }

      // Apply the adjustment to the predicted harvest
      _predictedHarvestKilos = (_predictedHarvestKilos ?? 0) + harvestAdjustment; // Use null coalescing operator
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
              items: _diseaseTypeMapping.keys.map((String value) {
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
              items: _pesticideMapping.keys.map((String value) {
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