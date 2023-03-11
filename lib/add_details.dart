import 'package:flutter/material.dart';

import 'databasehelper.dart';
import 'model/Details.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

final DatabaseHelper _dbHelper = DatabaseHelper();

GlobalKey<FormState> _key = GlobalKey();

final nameController = TextEditingController();
final addressController = TextEditingController();

class _AddDetailsState extends State<AddDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Details"),
        ),
        body: Container(
            padding: const EdgeInsets.all(32),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        "Add your Details",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orangeAccent, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 60,
                                  child: Icon(
                                    Icons.person,
                                    size: 15,
                                    color: Colors.black26,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: nameController,
                                    validator: _validateName,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Name",
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 20)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orangeAccent, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 60,
                                  child: Icon(
                                    Icons.location_history,
                                    size: 15,
                                    color: Colors.black26,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: addressController,
                                    validator: _validateAddress,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Address",
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 20)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_key.currentState!.validate()) {
                                Details details = Details(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    name: nameController.text,
                                    address: addressController.text);
                                _dbHelper.insertDetails(details);
                                Navigator.pop(context);
                                nameController.clear();
                                addressController.clear();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(20),
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )));
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return '*Required Field';
    } else {
      return null;
    }
  }

  String? _validateAddress(String? value) {
    if (value!.isEmpty) {
      return '*Required Field';
    } else {
      return null;
    }
  }
}
