import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Tables extends StatefulWidget {
  const Tables({super.key});

  @override
  State<Tables> createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _documents = [];
  bool _isLoading = false;
  DocumentSnapshot? _lastDocument;
  DocumentSnapshot? _firstDocument;
  String _searchFilter = "";
  final int _limit = 10;
  int _currentPage = 1;
  bool isOnline = false;
  @override
  void initState() {
    super.initState();
    _fetchData();
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
 Future<void> _fetchData({bool loadNextPage = false, bool loadPreviousPage = false}) async {
  if (_isLoading) return;

  setState(() {
    _isLoading = true;
  });

  Query query = _firestore
      .collection('harvests')
      .orderBy('date', descending: true);

  // Area filter
  if (_searchFilter.isNotEmpty) {
    query = query.where('date', isEqualTo: _searchFilter);
  }



  // Apply pagination
  if (loadNextPage && _lastDocument != null) {
    query = query.startAfterDocument(_lastDocument!);
  } else if (loadPreviousPage && _firstDocument != null) {
    query = query.endBeforeDocument(_firstDocument!);
  }

  // Limit the number of results
  query = query.limit(_limit);

  // Fetch data
  final querySnapshot = await query.get();

  if (querySnapshot.docs.isNotEmpty) {
    setState(() {
      _firstDocument = querySnapshot.docs.first;
      _lastDocument = querySnapshot.docs.last;
      _documents = querySnapshot.docs;
    });
  }

  setState(() {
    _isLoading = false;
  });
}


  Future<void> _exportToCsv() async {
  try {
    // Check permissions (for Android)
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission is required to save CSV files.'),
          ),
        );
        return;
      }
    }

    // 🔥 Fetch ALL documents from 'harvests'
    QuerySnapshot querySnapshot = await _firestore.collection('harvests').orderBy('date', descending: true).get();
    List<DocumentSnapshot> allDocuments = querySnapshot.docs;

    if (allDocuments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data available to export.')),
      );
      return;
    }

    // Prepare CSV data
    List<List<String>> csvData = [
      // Headers
      ['Date', 'Area', 'Disease', 'Number of Diseases', 'Pesticides', 'Harvest (kg)'],
      // Data rows
      ...allDocuments.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return [
          data['date']?.toString() ?? '',
          data['area']?.toString() ?? '',
          data['disease']?.toString() ?? '',
          data['numberOfDiseases']?.toString() ?? '',
          data['pesticides']?.toString() ?? '',
          data['harvest']?.toString() ?? '',
        ];
      }).toList(),
    ];

    // Convert to CSV
    String csv = const ListToCsvConverter().convert(csvData);

    // Save file
    final directory = await getExternalStorageDirectory();
    final path = '${directory!.path}/harvest_data.csv';
    final file = File(path);
    await file.writeAsString(csv);

    // Show success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('CSV file saved to $path'),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error exporting CSV: $e'),
      ),
    );
  }
}

void _deleteDocument(String docId) async {
    bool confirmDelete = await _showDeleteConfirmationDialog();
    if (confirmDelete) {
      await _firestore.collection('harvests').doc(docId).delete();
      _fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: const Text('Successfully deleted the row.',
                      style: TextStyle(color: Colors.white),),
                         duration: const Duration(seconds: 3),
                    backgroundColor: const Color(0xff57c26b),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),),
      );
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are you sure you want to delete this row?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showUpdateDialog(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String date = data['date'];
    String area = data['area'];
    String disease = data['disease'];
    String numberOfDiseases = data['numberOfDiseases'].toString();
    String pesticides = data['pesticides'];
    String harvest = data['harvest'].toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Harvest Data'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: date),
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: TextEditingController(text: area),
                onChanged: (value) => area = value,
                decoration: const InputDecoration(labelText: 'Area'),
              ),
              TextField(
                controller: TextEditingController(text: disease),
                onChanged: (value) => disease = value,
                decoration: const InputDecoration(labelText: 'Disease'),
              ),
              TextField(
                controller: TextEditingController(text: numberOfDiseases),
                onChanged: (value) => numberOfDiseases = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'No. of Diseases'),
              ),
              TextField(
                controller: TextEditingController(text: pesticides),
                onChanged: (value) => pesticides = value,
                decoration: const InputDecoration(labelText: 'Pesticides'),
              ),
              TextField(
                controller: TextEditingController(text: harvest),
                onChanged: (value) => harvest = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harvest (kg)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _firestore.collection('harvests').doc(doc.id).update({
                'area': area,
                'disease': disease,
                'numberOfDiseases': int.tryParse(numberOfDiseases) ?? 0,
                'pesticides': pesticides,
                'harvest': int.tryParse(harvest) ?? 0,
              });
              Navigator.of(context).pop();
              _fetchData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Row successfully updated!',
                      style: TextStyle(color: Colors.white),),
                         duration: const Duration(seconds: 3),
                    backgroundColor: const Color(0xff57c26b),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      
                      ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
}
  void _onSearch(String value) {
    setState(() {
      _searchFilter = value.trim();
      _lastDocument = null;
      _firstDocument = null;
      _currentPage = 1;
    });
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Harvest List",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff66bb73),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff63b36f),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _searchFilter = "";
                _lastDocument = null;
                _firstDocument = null;
                _currentPage = 1;
              });
              _fetchData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export as CSV',
            onPressed: _exportToCsv,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: _onSearch,
              ),
            ),
            Expanded(
              child: _documents.isEmpty
                  ? const Center(child: Text('No data found'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Area')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Disease')),
                            DataColumn(label: Text('No. of Diseases')),
                            DataColumn(label: Text('Harvest (kg)')),
                            DataColumn(label: Text('Pesticides')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: _documents.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            return DataRow(cells: [
                              DataCell(Text(data['area'] ?? '')),
                              DataCell(Text(data['date'] ?? '')),
                              DataCell(Text(data['disease'] ?? '')),
                              DataCell(Text(data['numberOfDiseases'].toString())),
                              DataCell(Text(data['harvest'].toString())),
                              DataCell(Text(data['pesticides'] ?? '')),
                              DataCell(
                                Row(
  children: [
    IconButton(
      icon: const Icon(Icons.edit),
      onPressed: isOnline ? () => _showUpdateDialog(doc) : null, // Disable when offline
      color: isOnline ? Colors.black : Colors.grey, // Change color to indicate disabled
    ),
    IconButton(
      icon: const Icon(Icons.delete),
      color: isOnline ? Colors.red : Colors.grey, // Change color to gray when disabled
      onPressed: isOnline ? () => _deleteDocument(doc.id) : null, // Disable when offline
    ),
  ],
),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
            ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _currentPage > 1
                        ? () {
                            setState(() {
                              _currentPage--;
                            });
                            _fetchData(loadPreviousPage: true);
                          }
                        : null,
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        color: Color(0xff66bb73),
                      ),
                    ),
                  ),
                  Text('Page $_currentPage'),
                  ElevatedButton(
                    onPressed: _documents.length == _limit
                        ? () {
                            setState(() {
                              _currentPage++;
                            });
                            _fetchData(loadNextPage: true);
                          }
                        : null,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xff66bb73),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
