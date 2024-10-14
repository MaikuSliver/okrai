import 'package:flutter/material.dart';

class PredictYield extends StatefulWidget {
  const PredictYield({super.key});

  @override
  State<PredictYield> createState() => _PredictYieldState();
}

class _PredictYieldState extends State<PredictYield> {

// Dummy choices for dropdowns
  final List<String> _encounteredDiseases = ['None', 'Disease A', 'Disease B', 'Disease C'];
  final List<String> _typesOfDiseases = ['Type 1', 'Type 2', 'Type 3'];
  final List<String> _pesticidesUsed = ['Pesticide X', 'Pesticide Y', 'Pesticide Z'];
  final List<double> _litersOfPesticides = [0.5, 1.0, 1.5, 2.0];

  // Selected values
  String? _selectedEncounteredDisease;
  String? _selectedTypeOfDisease;
  String? _selectedPesticide;
  double? _selectedLitersOfPesticides;

  // Dummy predicted result
  double? _predictedHarvestKilos;

  // Placeholder for the prediction function (will use dummy logic here)
  void _predictYield() {
    setState(() {
      // Dummy prediction logic (just returning a constant value for now)
      _predictedHarvestKilos = 100.0; // Replace this with actual model prediction
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Predict Okra Yield", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
        backgroundColor: const Color(0xff44c377),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {Navigator.pop(context);},
        ),leadingWidth: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Encountered Disease Dropdown
            const Text("Encountered Disease in Okra"),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedEncounteredDisease,
              items: _encounteredDiseases.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEncounteredDisease = newValue!;
                });
              },
              hint: const Text("Select Encountered Disease"),
            ),
            const SizedBox(height: 16),

            // Types of Disease Dropdown
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

            // Name of Used Pesticides Dropdown
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

            // Liters of Used Pesticides Dropdown
            const Text("Liters of Used Pesticides"),
            DropdownButton<double>(
              isExpanded: true,
              value: _selectedLitersOfPesticides,
              items: _litersOfPesticides.map((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (double? newValue) {
                setState(() {
                  _selectedLitersOfPesticides = newValue!;
                });
              },
              hint: const Text("Select Liters of Pesticides"),
            ),
            const SizedBox(height: 16),

            // Predict Button
            ElevatedButton(
              onPressed: _predictYield,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff44c377)),
              child: const Text("Predict Harvest Kilos",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 16),

            // Show predicted result
            if (_predictedHarvestKilos != null)
              Text(
                "Predicted Harvest Kilos: $_predictedHarvestKilos kg",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}