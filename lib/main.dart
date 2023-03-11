import 'package:flutter/material.dart';

import 'add_details.dart';
import 'databasehelper.dart';
import 'model/Details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details App"),
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              initialData: const [],
              future: _dbHelper.getDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Details item = snapshot.data![index];

                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Widget>[
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        confirmDismiss: (direction) async{
                      final bool res = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return AlertDialog(
                      content: const Text(
                      "Are you sure you want to delete this Detail?"),
                      actions: <Widget>[
                      TextButton(
                      child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                      Navigator.pop(context, false);
                      },
                      ),
                      TextButton(
                      child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                      _dbHelper.deleteDetails(item.id);
                      Navigator.pop(context, true);
                      },
                      ),
                      ],
                      );
                      });
                      return res;
                      },
                        child: SizedBox(
                            height: 100.0,
                            child: Center(
                              child: ListTile(
                                title: Text(item.name, style: const TextStyle(fontSize: 16.0),),
                                subtitle: const Text("Click for more details", style: TextStyle(fontSize: 12.0)),
                                leading: CircleAvatar(child: Text(index.toString()),),
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 200,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text("Name: ${item.name}"),
                                              const SizedBox(height: 10,),
                                              Text("Address: ${item.address}"),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                child: const Text('Close'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddDetails())
          ).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
