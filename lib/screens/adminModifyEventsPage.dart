import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';
import 'admin_modify_event_form.dart';
import 'package:test7/screens/form.dart';

class AdminModifyEventsPage extends StatefulWidget {
  @override
  _AdminModifyEventsPageState createState() => _AdminModifyEventsPageState();
}

class _AdminModifyEventsPageState extends State<AdminModifyEventsPage> {
  List<Map<dynamic, dynamic>> _events = [];
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    // Fetch events from the database using the readData method
    String sql = "SELECT * FROM Events";
    List<Map<dynamic, dynamic>> events = await db().readData(sql);

    setState(() {
      _events = events;
    });
  }

  Future<void> _deleteEvent(int eventId) async {
    // Delete the event from the database using the deleteData method
    String sql = "DELETE FROM Events WHERE id = $eventId";
    await db().deleteData(sql);

    // Reload the events after deletion
    _loadEvents();
  }

  void _updateEvent(int eventId) {
    // Open the update event form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminModifyEventForm(eventId: eventId),
      ),
    ).then((_) {
      // Reload the events after updating
      _loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Events"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor2,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text('Add Event', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            Text(
              'Events List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (_events.isEmpty)
              Text(
                'No events found.',
                style: TextStyle(fontSize: 16),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time')),
                    DataColumn(label: Text('City')),
                    DataColumn(label: Text('Event Type')),
                    DataColumn(label: Text('Event Name')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Event Theme')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Ticket Price')),
                    DataColumn(label: Text('Number of Tickets')),
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _events.map((event) {
                    return DataRow(
                      cells: [
                        DataCell(Text(event['id'].toString())),
                        DataCell(Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(event['date'])))),
                        DataCell(Text(event['time'].toString())),
                        DataCell(Text(event['city'].toString())),
                        DataCell(Text(event['type'].toString())),
                        DataCell(Text(event['name'].toString())),
                        DataCell(Text(event['address'].toString())),
                        DataCell(Text(event['theme'].toString())),
                        DataCell(Text(event['description'].toString())),
                        DataCell(Text(event['price'].toString())),
                        DataCell(Text(event['ntickets'].toString())),
                        DataCell(Text(event['image_url'].toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Call the delete event method when the delete button is pressed
                                  _deleteEvent(event['id']);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Call the update event method when the update button is pressed
                                  _updateEvent(event['id']);
                                },
                              ),
                            ],
                          ),
                        ),
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
    home: AdminModifyEventsPage(),
  ),
);
