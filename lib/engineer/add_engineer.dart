import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class EngineerForm extends StatefulWidget {
  final List<Map<String, dynamic>> factories;
  final int currentFactoryIndex;
  Function(String, String) updateEngineerList;

  EngineerForm({
    super.key,
    required this.factories,
    required this.currentFactoryIndex,
    required this.updateEngineerList,
  });

  @override
  State<EngineerForm> createState() => _EngineerFormState();
}

class _EngineerFormState extends State<EngineerForm> {
  final nameFormKey = GlobalKey<FormState>();
  final phoneNumberFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isValidated = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void validateForm() {
    final nameForm = nameFormKey.currentState;
    final phoneForm = phoneNumberFormKey.currentState;
    if (nameForm != null &&
        phoneForm != null &&
        nameForm.validate() &&
        phoneForm.validate()) {
      setState(() {
        isValidated = true;
      });
    } else {
      setState(() {
        isValidated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text(
          widget.factories[widget.currentFactoryIndex]['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Container(
          width: 100.w,
          color: const Color(0xFFBDBDBD),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text(
                  'Invitation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const Text(
                  'Invite users',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Owner's name",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Form(
                        key: nameFormKey,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) => validateNameInput(value),
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: 'Type here',
                          ),
                          onChanged: (value) => validateForm(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Owner's Phone Number",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/flag.png',
                                    width: 48,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10.0),
                                    child: const Text('+60'),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Form(
                                key: phoneNumberFormKey,
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  validator: (value) =>
                                      validatePhoneNumberInput(value),
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter your phone number',
                                  ),
                                  onChanged: (value) => validateForm(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: isValidated
                          ? () {
                        widget.updateEngineerList(nameController.text, phoneNumberController.text);
                        Navigator.pop(context);
                      }
                          : null,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String? validatePhoneNumberInput(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }
    bool isNumeric = RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
    bool isCorrectLength = phoneNumber.length == 9 || phoneNumber.length == 10;
    if (!isNumeric) {
      return 'Phone number must be numeric';
    }
    if (!isCorrectLength) {
      return 'Must be 9 or 10 digits long';
    }
    return null;
  }

  String? validateNameInput(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    bool isCorrectLength = name.length >= 3;
    if (!isCorrectLength) {
      return 'Name must be 3 digits or longer';
    }
    return null;
  }
}