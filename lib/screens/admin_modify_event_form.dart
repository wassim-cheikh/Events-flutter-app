import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';

class AdminModifyEventForm extends StatefulWidget {
  final int eventId;

  AdminModifyEventForm({required this.eventId});

  @override
  _AdminModifyEventFormState createState() => _AdminModifyEventFormState();
}

class _AdminModifyEventFormState extends State<AdminModifyEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventTypeController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventTimeController = TextEditingController();
  TextEditingController _eventAddressController = TextEditingController();
  TextEditingController _eventThemeController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  TextEditingController _eventPriceController = TextEditingController();
  TextEditingController _eventTicketsController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  void initState() {
    super.initState();
    _loadEventData();
  }

  Future<void> _loadEventData() async {
    // Fetch event details from the database using the readData method
    String sql = "SELECT * FROM Events WHERE id = ${widget.eventId}";
    List<Map<dynamic, dynamic>> eventDetails = await db().readData(sql);

    if (eventDetails.isNotEmpty) {
      setState(() {
        _eventNameController.text = eventDetails[0]['name'];
        _eventTypeController.text = eventDetails[0]['type'];
        _eventDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(eventDetails[0]['date']));
        _eventTimeController.text = eventDetails[0]['time'];
        _eventAddressController.text = eventDetails[0]['adress'];
        _eventThemeController.text = eventDetails[0]['theme'];
        _eventDescriptionController.text = eventDetails[0]['description'];
        _eventPriceController.text = eventDetails[0]['price'].toString();
        _eventTicketsController.text = eventDetails[0]['ntickets'].toString();
        _selectedDate = DateTime.parse(eventDetails[0]['date']);
        _imageController.text = eventDetails[0]['image_url'].toString();

        _selectedTime = TimeOfDay(
          hour: int.parse(eventDetails[0]['time'].split(':')[0]),
          minute: int.parse(eventDetails[0]['time'].split(':')[1]),
        );
      });
    }
  }

  Future<void> _updateEvent() async {
    if (_formKey.currentState!.validate()) {
      // Construct the SQL query for updating the event
      String sql = '''
        UPDATE Events SET
          "name" = "${_eventNameController.text}",
          "type" = "${_eventTypeController.text}",
          "date" = "${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
          "time" = "${_selectedTime.format(context)}",
          "adress" = "${_eventAddressController.text}",
          "theme" = "${_eventThemeController.text}",
          "description" = "${_eventDescriptionController.text}",
          "price" = ${double.parse(_eventPriceController.text)},
          "ntickets" = ${int.parse(_eventTicketsController.text)},
          "image_url" = "${_imageController.text}"
        WHERE id = ${widget.eventId}
      ''';

      // Update the event in the database
      await db().updateData(sql);

      // Navigate back to the AdminModifyEventsPage after updating
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _eventDateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _eventTimeController.text = _selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Modify Event"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField('Name', _eventNameController, 'Enter the event name'),
                _buildTextFormField('Type', _eventTypeController, 'Enter the event type'),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextFormField('Date', _eventDateController, 'Select the event date', isEnabled: false),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: _buildTextFormField('Time', _eventTimeController, 'Select the event time', isEnabled: false),
                    ),
                  ],
                ),
                _buildTextFormField('Adress', _eventAddressController, 'Enter the event address'),
                _buildTextFormField('Theme', _eventThemeController, 'Enter the event theme', isRequired: false),
                _buildTextFormField('Description', _eventDescriptionController, 'Enter the event description'),
                _buildTextFormField('Ticket Price', _eventPriceController, 'Enter the ticket price', keyboardType: TextInputType.numberWithOptions(decimal: true)),
                _buildTextFormField('Number of Tickets', _eventTicketsController, 'Enter the number of tickets', keyboardType: TextInputType.number),
                _buildTextFormField('Image url', _imageController, 'Enter the image url'),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor2,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: Text('Update Date', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor2,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: Text('Update Time', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _updateEvent,
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor2,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text('Update Event', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String label,
      TextEditingController controller,
      String hintText, {
        TextInputType keyboardType = TextInputType.text,
        bool isRequired = true,
        bool isEnabled = true,
      }) {
    return TextFormField(
      controller: controller,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12.0),
      ),
      validator: (value) {
        if (!isRequired && (value == null || value.isEmpty)) {
          return null; // Field is optional
        }
        if (value == null || value.isEmpty) {
          return 'Please enter the $label';
        }
        return null;
      },
      keyboardType: keyboardType,
    );
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminModifyEventForm(eventId: 1), // Provide the eventId for the event you want to modify
  ),
);
