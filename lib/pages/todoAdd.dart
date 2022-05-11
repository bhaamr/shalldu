import 'package:sqlite_provider_starter/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import '../database/firestoreHandler.dart';
import '../pages/todoEdit.dart';
import 'package:sqlite_provider_starter/models/todo2.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Addtodo extends StatefulWidget {
  const Addtodo({Key? key}) : super(key: key);

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  final _formKey = GlobalKey<FormState>();
  final tcontroller = TextEditingController();
  final dcontroller = TextEditingController();
  final icontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
      appBar:AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("New todo"),

      ),

      body: Container(
        child: SafeArea(
          child:  Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: tcontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(color: Colors.white60),
                    fillColor: Colors.black,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: dcontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.white60),
                    fillColor: Colors.black,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: icontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Image url",
                    labelStyle: TextStyle(color: Colors.white60),
                    fillColor: Colors.black,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('dd-MM-yyyy').format(now);
          var todo = Todo2(
              title: tcontroller.text,
              description: dcontroller.text,
              completed: false,
              created: formattedDate,
              image: icontroller.text,
              prio: 0,
              tags: []
          );
          addData(todo, context);
          setState(() {
            tcontroller.clear();
            dcontroller.clear();
            icontroller.clear();
            showSnackBar(context, 'New "todo" successfully added!');

          });
        },

        child: Icon(Icons.upload_rounded),
      ),
    );
  }
}
