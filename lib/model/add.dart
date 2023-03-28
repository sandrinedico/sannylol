import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lol/firestore_service.dart';

class AddUser extends StatefulWidget {
  User user;
  AddUser(this.user);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formKey = GlobalKey<FormState>();

  TextEditingController correlationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController contactNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    correlationController.dispose();
    nameController.dispose();
    birthdateController.dispose();
    ageController.dispose();
    contactNumController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Emergency Information Form",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ])),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.blue.shade50,
                Colors.blue.shade100,
                Colors.blue.shade200,
                Colors.blue.shade300
              ])),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                TextFormField(
                    controller: correlationController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person_3_rounded),
                        hintText: 'Father',
                        labelText: 'Correlation'),
                    validator: (correlation) {
                      if (correlation!.isEmpty ||
                          !RegExp(r'[0-9]+$').hasMatch(correlation)) {
                        return 'Input Correlation to the Owner!.';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle),
                        hintText: 'Name',
                        labelText: 'Name'),
                    validator: (name) {
                      if (name!.isEmpty ||
                          !RegExp(r'[a-z A-Z]+$').hasMatch(name)) {
                        return 'Input your Name!.';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.numbers),
                        hintText: '35',
                        labelText: 'Age'),
                    validator: (age) {
                      if (age!.isEmpty ||
                          !RegExp(r'[a-z A-Z]+$').hasMatch(age)) {
                        return 'Input your Age!.';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: birthdateController,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_month),
                        hintText: 'DD/MM/YYYY',
                        labelText: 'Date of Birth'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2025));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        setState(() {
                          birthdateController.text = formattedDate;
                        });
                      }
                    },
                    validator: (birthdate) {
                      if (birthdate!.isEmpty) {
                        return 'Please enter your Date of Birth.';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: contactNumController,
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.contact_phone_rounded),
                        hintText: '09876543211',
                        labelText: 'Contact Numvber'),
                    validator: (contactNum) {
                      if (contactNum!.isEmpty ||
                          !RegExp(r'[0-9]+$').hasMatch(contactNum)) {
                        return 'Your your Contact Number!.';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.pin_drop_rounded),
                        hintText: 'Carmen, Cagayan de Oro City',
                        labelText: 'Address'),
                    validator: (address) {
                      if (address!.isEmpty ||
                          !RegExp(r'[0-9]+$').hasMatch(address)) {
                        return 'Please enter your Contact Number.';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 20),
                loading
                    ? CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        height: 40,
                        width: 500,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (correlationController.text == "" ||
                                  nameController.text == "" ||
                                  ageController.text == "" ||
                                  birthdateController.text == "" ||
                                  contactNumController.text == "" ||
                                  addressController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("All fields are required!"),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                await FirestoreService().insertTodo(
                                    correlationController.text,
                                    nameController.text,
                                    ageController.text,
                                    birthdateController.text,
                                    contactNumController.text,
                                    widget.user.uid);
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              }
                            }
                            ;
                          },
                          child: const Text('SUBMIT'),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
