import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
Future main() async {
  // Init ffi loader if needed.
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await db.execute('''
  CREATE TABLE Product (
      id INTEGER PRIMARY KEY,
      title TEXT
  )
  ''');
  await db.insert('Product', <String, dynamic>{'title': 'Product 1'});
  await db.insert('Product', <String, dynamic>{'title': 'Product 1'});

  var result = await db.query('Product');
  print(result);
  // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
  await db.close();
}
//import 'package:flutter/material.dart';
//import 'package:sqlite_demo/ClientModel.dart';
//import 'package:sqlite_demo/Database.dart';
//import 'dart:math' as math;

//void main() => runApp(MaterialApp(home: MyApp()));

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}

//class _MyAppState extends State<MyApp> {
//  // data for testing
//  List<Client> testClients = [
//    Client(firstName: "Raouf", lastName: "Rahiche", blocked: false),
//    Client(firstName: "Zaki", lastName: "oun", blocked: true),
//    Client(firstName: "oussama", lastName: "ali", blocked: false),
//  ];

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("Flutter SQLite")),
//      body: FutureBuilder<List<Client>>(
//        future: DBProvider.db.getAllClients(),
//        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
//          if (snapshot.hasData) {
//            return ListView.builder(
//              itemCount: snapshot.data.length,
//              itemBuilder: (BuildContext context, int index) {
//                Client item = snapshot.data[index];
//                return Dismissible(
//                  key: UniqueKey(),
//                  background: Container(color: Colors.red),
//                  onDismissed: (direction) {
//                    DBProvider.db.deleteClient(item.id);
//                  },
//                  child: ListTile(
//                    title: Text(item.lastName),
//                    leading: Text(item.id.toString()),
//                    trailing: Checkbox(
//                      onChanged: (bool value) {
//                        DBProvider.db.blockOrUnblock(item);
//                        setState(() {});
//                      },
//                      value: item.blocked,
//                    ),
//                  ),
//                );
//              },
//            );
//          } else {
//            return Center(child: CircularProgressIndicator());
//          }
//        },
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () async {
//          Client rnd = testClients[math.Random().nextInt(testClients.length)];
//          await DBProvider.db.newClient(rnd);
//          setState(() {});
//        },
//      ),
//    );
//  }
//}
