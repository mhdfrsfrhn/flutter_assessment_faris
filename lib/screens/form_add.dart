import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sd1_flutter_assessment/imports.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  const FormAddScreen({Key? key}) : super(key: key);

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  DateTime dateTimePicker = DateTime.now();
  bool? _isFieldNameValid;
  bool? _isFieldPhoneValid;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(contactKey.toString());
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add New Contact",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldPhone(),
                Row(
                  children: [
                    Flexible(child: _buildTextFieldDateTime()),
                    const SizedBox(width: 50),
                    // Flexible(child: _buildTextFieldAge()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextButton(
                    onPressed: () {
                      if (_isFieldNameValid == null ||
                          _isFieldPhoneValid == null ||
                          !_isFieldNameValid! ||
                          !_isFieldPhoneValid!) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );

                        return;
                      }
                      // print("writing");
                      Map<String, dynamic> data = {
                        "user": _controllerName.text.toString(),
                        "phone": _controllerPhone.text.toString(),
                        "check-in": reformatDateToSave(_controllerDate.text),
                      };
                      dbRef.push().set(data).then((value) {
                        Navigator.of(context).pop();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("New contact added!"),
                        ),
                      );
                    },
                    child: Text(
                      "Add Contact".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.orange[600]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Full name",
        errorText: _isFieldNameValid == null || _isFieldNameValid!
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPhone() {
    return TextField(
      controller: _controllerPhone,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Phone Number",
        errorText: _isFieldPhoneValid == null || _isFieldPhoneValid!
            ? null
            : "Phone Number is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPhoneValid) {
          setState(() => _isFieldPhoneValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDateTime() {
    return TextField(
        controller: _controllerDate,
        decoration: const InputDecoration(
          labelText: "Check-in time",
        ),
        onTap: () {
          _showDialog(
            CupertinoDatePicker(
              initialDateTime: dateTimePicker,
              use24hFormat: false,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() => _controllerDate.text =
                    DateFormat('d MMM y hh:mm a').format(newDateTime));
              },
            ),
          );
        });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }
}
