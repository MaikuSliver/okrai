import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart'; // <-- Add intl package for date formatting

class CsvImporter extends StatelessWidget {
  const CsvImporter({super.key});

  Future<void> _importCSVtoFirestore(BuildContext context) async {
    try {
      final rawData = await rootBundle.loadString('assets/OKRAI HARVEST - Sheet1.csv');
      final List<List<dynamic>> csvTable = const CsvToListConverter().convert(rawData);

      final headers = csvTable.first; // First row = headers
      final dataRows = csvTable.skip(1); // Rest = data rows

      for (final row in dataRows) {
        String rawDate = row[1].toString().trim();
        String formattedDate = rawDate;

        try {
          // Try to parse and format the date
          DateTime parsedDate = DateTime.parse(rawDate);
          formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
        } catch (e) {
          // If parsing fails, keep the original (you can choose to handle errors differently)
          debugPrint('Date parsing failed for "$rawDate", keeping as-is.');
        }

        final Map<String, dynamic> data = {
          'date': formattedDate, // use formatted date
          'area': row[0],
          'disease': row[2],
          'harvest': row[3],
          'numberOfDiseases': row[4],
          'pesticides': row[5],
        };

        await FirebaseFirestore.instance.collection('harvests').add(data);
        debugPrint('Uploaded row: $data');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV imported successfully!')),
      );
      debugPrint('CSV import completed successfully.');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing CSV: $e')),
      );
      debugPrint('Error during CSV import: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CSV Importer')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _importCSVtoFirestore(context),
          child: const Text('Import from CSV'),
        ),
      ),
    );
  }
}
