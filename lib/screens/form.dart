import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/db.dart';
import '../utils/EAColors.dart';
import 'adminDashboard.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _eventName = '';
  String _eventType = '';
  DateTime _selectedDate = DateTime.now();
  String _address = '';
  String _eventTheme = '';
  String _description = '';
  double _price = 0.0;
  int _numberOfTickets = 0;
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _picturePath = '';
  String _priceError = '';
  String _ticketsError = '';
  String _selectedEventType = '';
  String _selectedCity = 'Tunis';
  String _image = '';

  db my_db = new db();

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateTimePickers(),
                SizedBox(height: 16.0),
                _buildEventTypeRadioButton(),
                SizedBox(height: 16.0),
                _buildCityRadioButton(),
                SizedBox(height: 16.0),
                _buildTextFormField('Name:', 'Please enter the event name', (value) {
                  _eventName = value!;
                }),
                SizedBox(height: 16.0),
                _buildTextFormField('Address:', 'Please enter the address', (value) {
                  _address = value!;
                }),
                SizedBox(height: 16.0),
                _buildTextFormField('Theme:', '', (value) {
                  _eventTheme = value!;
                }, isRequired: false),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  'Description:',
                  'Please enter the event description',
                      (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  'Ticket Price:',
                  'Please enter the event price',
                      (value) {
                    double? parsedValue = double.tryParse(value!);
                    if (parsedValue == null) {
                      setState(() {
                        _priceError = 'Please enter a valid number';
                      });
                    } else {
                      setState(() {
                        _priceError = '';
                        _price = parsedValue;
                      });
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                if (_priceError.isNotEmpty) Text(_priceError, style: TextStyle(color: Colors.red)),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  'Number of Tickets:',
                  'Please enter the number of tickets',
                      (value) {
                    int? parsedValue = int.tryParse(value!);
                    if (parsedValue == null) {
                      setState(() {
                        _ticketsError = 'Please enter a valid number';
                      });
                    } else {
                      setState(() {
                        _ticketsError = '';
                        _numberOfTickets = parsedValue;
                      });
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                if (_ticketsError.isNotEmpty) Text(_ticketsError, style: TextStyle(color: Colors.red)),
                SizedBox(height: 16.0),
                _buildTextFormField('Image Url :', '', (value) {
                  _image = value!;
                }, isRequired: false),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventTypeRadioButton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              _buildRadioButton('Cinema'),
              _buildRadioButton('Theatre'),
              _buildRadioButton('Art'),
              _buildRadioButton('Gaming'),
              _buildRadioButton('Music'),
              _buildRadioButton('Festival'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCityRadioButton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'City : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              _buildCityRadioButtonItem('Tunis'),
              _buildCityRadioButtonItem('Kelibia'),
              _buildCityRadioButtonItem('Hammamet'),
              _buildCityRadioButtonItem('Sousse'),
              _buildCityRadioButtonItem('Djerba'),
              _buildCityRadioButtonItem('Tabarka'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: _selectedEventType,
            onChanged: (selectedValue) {
              setState(() {
                _selectedEventType = selectedValue.toString();
              });
            },
          ),
          Text(value),
        ],
      ),
    );
  }



  Widget _buildCityRadioButtonItem(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: _selectedCity,
            onChanged: (selectedValue) {
              setState(() {
                _selectedCity = selectedValue.toString();
              });
            },
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildDateTimePickers() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Date:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  DateFormat('dd-MM-yyyy').format(_selectedDate),
                ),
                onTap: () => _selectDate(context),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Time:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${_selectedTime.format(context)}'),
                onTap: () => _selectTime(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
      String label,
      String hintText,
      void Function(String?) onSaved, {
        TextInputType keyboardType = TextInputType.text,
        bool isRequired = true,
      }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$label',
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12.0),
      ),
      validator: (value) {
        if (!isRequired && (value == null || value.isEmpty)) {
          return null; // Theme field is optional
        }
        if (value == null || value.isEmpty) {
          return 'Please enter the $label';
        }
        return null;
      },
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Construct the SQL query for inserting a new event
      String sql = '''
        INSERT INTO "Events" (
          "name", "type", "city", "adress", "date", "time", "theme", "description", "price", "ntickets","image_url"
        ) VALUES (
          "$_eventName", "$_selectedEventType", "$_selectedCity", "$_address",
          "${DateFormat('yyyy-MM-dd').format(_selectedDate)}", "${_selectedTime.format(context)}",
          "$_eventTheme", "$_description", $_price, $_numberOfTickets,"$_image"
        )
      ''';

      // Insert the event into the database
      int response = await my_db.insertData(sql);

      if (response > 0) {
        // Event added successfully, show confirmation message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Event added successfully to the database.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDashboard()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle the case where the event was not added successfully
        // You can show an error message or take appropriate action
      }
    }
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FormScreen(),
  ),
);
