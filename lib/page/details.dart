import 'package:flutter/material.dart';
import 'package:lol/model/update.dart';
import 'package:lol/page/student.dart';

class DetailsPage extends StatelessWidget {
  final TodoModel UserDetails;
  final List<String> titles = <String>[
    'correlation',
    'name',
    'age',
    'birthdate',
    'contactNum',
    'address',
  ];

  DetailsPage({required this.UserDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Emergency Details'),
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddUser(UserDetails)));
                },
                icon: Icon(Icons.edit_note_rounded)),
          ],
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
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.person_3_rounded),
                  title: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text('Correlation:'),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(': ${UserDetails.correlation}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text('Name:'),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(': ${UserDetails.name}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.numbers),
                  title: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text('Age:'),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(': ${UserDetails.age}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.calendar_month_rounded),
                  title: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text('Birthdate:'),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(': ${UserDetails.birthdate}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.contact_phone_rounded),
                  title: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text('Contact Number:'),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(': ${UserDetails.contactNum}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.pin_drop_rounded),
                  title: Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Text('Address'),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(': ${UserDetails.address}'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
