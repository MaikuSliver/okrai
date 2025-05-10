import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CsvImportButton extends StatelessWidget {
  const CsvImportButton({super.key});

  Future<void> _importCsvToFirestore(BuildContext context) async {
    try {
      // Pick CSV file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result == null || result.files.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
        return;
      }

      final file = File(result.files.single.path!);
      final content = await file.readAsString();

      // Convert CSV content to List
      List<List<dynamic>> csvTable = const CsvToListConverter().convert(content, eol: '\n');

      // Skip header
      final dataRows = csvTable.skip(1);

      for (var row in dataRows) {
        await FirebaseFirestore.instance.collection('harvests').add({
          'date': row[0].toString(),
          'area': row[1].toString(),
          'disease': row[2].toString(),
          'numberOfDiseases': int.tryParse(row[3].toString()) ?? 0,
          'pesticides': row[4].toString(),
          'harvest': int.tryParse(row[5].toString()) ?? 0,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV imported successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Import failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _importCsvToFirestore(context),
        child: const Text('Import CSV to Firestore'),
      ),
    );
  }
}
