import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/list_model.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  MyListScreenState createState() => MyListScreenState();
}

class MyListScreenState extends State<MyListScreen> {
  List<MyModel> _myList = [];
  String _name = '';
  int _age = 0;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  Future<void> _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = prefs.getStringList('myList') ?? [];
    List<MyModel> modelList = jsonStringList.map((jsonString) => MyModel.fromJson(jsonDecode(jsonString))).toList();
    setState(() {
      _myList = modelList;
    });
  }

  Future<void> _saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = _myList.map((model) => jsonEncode(model.toJson())).toList();
    await prefs.setStringList('myList', jsonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter a name:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Enter an age:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _age = int.parse(value);
                });
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _myList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_myList[index].name),
                    subtitle: Text(_myList[index].age.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _myList.add(MyModel(
              name: _name,
              age: _age,
            ));
            _name = '';
            _age = 0;
          });
          _saveList();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('List saved to shared preferences.')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class MyListScreen extends StatefulWidget {
//   const MyListScreen({super.key});
//
//   @override
//   MyListScreenState createState() => MyListScreenState();
// }
//
// class MyListScreenState extends State<MyListScreen> {
//   List<String> _myList = [];
//   String _newItem = '';
//
//   Future<void> _loadList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String jsonString = prefs.getString('myList') ?? '[]';
//     List<dynamic> jsonList = jsonDecode(jsonString);
//     setState(() {
//       _myList = jsonList.cast<String>();
//     });
//   }
//
//   Future<void> _saveList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String jsonString = jsonEncode(_myList);
//     await prefs.setString('myList', jsonString);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My List'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Enter a string:'),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _newItem = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 16.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _myList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(_myList[index]),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _myList.add(_newItem);
//             _newItem = '';
//           });
//           _saveList();
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('List saved to shared preferences.'),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class MyTextFieldScreen extends StatefulWidget {
//   @override
//   _MyTextFieldScreenState createState() => _MyTextFieldScreenState();
// }
//
// class _MyTextFieldScreenState extends State<MyTextFieldScreen> {
//   String _myString = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadString();
//   }
//
//   Future<void> deleteText() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('myString');
//     _myString = '';
//     setState(() {});
//   }
//
//   Future<void> _loadString() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _myString = prefs.getString('myString') ?? '';
//     });
//   }
//
//   Future<void> _saveString() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('myString', _myString);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Text Field'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Enter a string:'),
//             TextField(
//               onChanged: (value) {
//                 _myString = value;
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _saveString();
//                 });
//               },
//               child: Text('Save'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   deleteText();
//                 });
//               },
//               child: Text('Delete'),
//             ),
//             Text(_myString),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Learning',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
//
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() {
//     return _MyHomePageState();
//   }
// }
//
//
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     retrieve();
//   }
//
//   // TextEditingController controller = TextEditingController();
//   String name = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter SharedPreferences"),
//       ),
//       body: Container(
//           margin: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   name = value;
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 name,
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               ElevatedButton(
//                 child: Text("Save"),
//                 onPressed: () {
//                   save();
//                 },
//               ),
//               ElevatedButton(
//                 child: Text("retrieve"),
//                 onPressed: () {
//                   retrieve();
//                 },
//               ),
//               ElevatedButton(
//                 child: Text("Delete"),
//                 onPressed: () {
//                   delete();
//                 },
//               ),
//               // Text(name),
//             ],
//           )),
//     );
//   }
//
//   save() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("username", name);
//   }
//
//   retrieve() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     name = prefs.getString("username")!;
//     setState(() {});
//   }
//
//   delete() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove("username");
//     name = "";
//     setState(() {});
//   }
// }
