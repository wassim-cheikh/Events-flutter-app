import 'package:flutter/material.dart';
import 'package:test7/screens/AddAdmin.dart';
import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';
import 'AddAdmin.dart';
import 'AdminUpdateAdminForm.dart';

class AdminReports extends StatefulWidget {
  @override
  _AdminReportsState createState() => _AdminReportsState();
}

class _AdminReportsState extends State<AdminReports> {
  List<Map<dynamic, dynamic>> _reports = [];
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    // Fetch admins from the database using the readData method
    String sql = "SELECT * FROM Reports";
    List<Map<dynamic, dynamic>> reports = await db().readData(sql);

    setState(() {
      _reports = reports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Reports"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16.0),
            Text(
              'Reports List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (_reports.isEmpty)
              Text(
                'No Reports found.',
                style: TextStyle(fontSize: 16),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Username ')),
                    DataColumn(label: Text('Event ID')),
                    DataColumn(label: Text('Report')),
                  ],
                  rows: _reports.map((admin) {
                    return DataRow(
                      cells: [
                        DataCell(Text(admin['username'].toString())),
                        DataCell(Text(admin['event_id'].toString())),
                        DataCell(Text(admin['report'].toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminReports(),
  ),
);
