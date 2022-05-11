import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_provider_starter/models/tag.dart';
import '../database/firestoreHandler.dart';
import '../models/todo2.dart';
import '../widgets/dialogs.dart';
import '../pages/todoList.dart';

class TodoEdit extends StatefulWidget {
  String? doctitle;
  String? doctdescription;
  String? docimage;
  String? docid;
  List? doctags;
  List? alltags;

  TodoEdit({Key? key, this.doctitle, this.doctdescription, this.docimage, this.docid,this.doctags,this.alltags}) : super(key: key);


  @override
  _TodoEditState createState() => _TodoEditState();

}


class _TodoEditState extends State<TodoEdit> {
  final _formKey = GlobalKey<FormState>();
  final tcontroller = TextEditingController();
  final dcontroller = TextEditingController();
  final icontroller = TextEditingController();



  var textEditingControllers = <TextEditingController>[];
  var textformFields = <TextFormField>[];
  var textformFields2 = <String>[];

  void _addformWidget(controller) {
    setState(() {
      textformFields.add(tagForm(controller));
    });
  }

  Future<List<dynamic>> getCollection(CollectionReference collection) async {
    var test = [];
    QuerySnapshot snapshot = await collection.get();
    //List<dynamic> result =  snapshot.docs.map((doc) => doc.data()).toList();
    snapshot.docs.forEach((document) {
      test.add(document['tagName']);
    });
        //return result;
    return test;
  }

  Future<List> futuretopresent(Future<List<dynamic>> collection) async{
    var list = await collection;
    return list;
  }

  TextFormField tagForm(controller){

    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: "Tag",
          labelStyle: TextStyle(color: Colors.white60),
          fillColor: Colors.black,
          filled: true,
          suffixIcon: IconButton(
            icon:Icon(Icons.delete, color: Colors.white,),
            onPressed: (){
              setState(() {
                //controller.dispose();
                textEditingControllers.remove(controller);
                textformFields.removeWhere((w) => w.controller == controller);
              });
            },

          )
      ),
    );

  }



  @override
  void initState() {

    super.initState();
    tcontroller.text = widget.doctitle.toString();
    dcontroller.text = widget.doctdescription.toString();
    icontroller.text = widget.docimage.toString();

    widget.doctags?.forEach((element) {
      var textEditingController = new TextEditingController(text: element);
      textEditingControllers.add(textEditingController);
      //return textformFields.add(tagForm(textEditingController)
      return _addformWidget(textEditingController);
      //);
    });
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text('Delete TODO'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Delete'),
                      onPressed: () {
                        deleteData(widget.docid.toString(), context);
                        setState(() {
                          showSnackBar(context, 'todo "${widget.doctitle}" successfully deleted!');
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
              icon: Icon(Icons.delete))
        ],
        backgroundColor: Colors.grey[900],
        title: Text("${widget.doctitle}"),
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
              SizedBox(height: 10),
              Row(children: [
                Text("Tags:", style:TextStyle(color: Colors.white)),
                IconButton(onPressed: (){
                  var textEditingController = new TextEditingController(text: "tag");
                  textEditingControllers.add(textEditingController);
                  _addformWidget(textEditingController);
                  print(textformFields.length);
                },
                  icon: Icon(Icons.add,color: Colors.white,),
                )
              ],),
              /*SingleChildScrollView(
                child: new Column(
                children: textformFields,
                )
              ),*/
              Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                        itemCount: textformFields.length,
                        itemBuilder: (context,index) {
                          return textformFields[index];
                        }),
                  )
              ),
            ],
          ),
        ),
        ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            var colectionReference = FirebaseFirestore.instance.collection('tags');
            var test2 = getCollection(colectionReference);
            var test3 = await futuretopresent(test2);
            var alltags = widget.alltags;


            List<String> test = [];
            textEditingControllers.forEach((element) {
              test.add(element.text);
            });
            test.forEach((tag) {
              if(test3 != null){
                if(test3.contains(tag)){
                  print(tag);
                  print(test3);
                  print('${tag} is in alltags');
                }else{
                  print(tag);
                  print(test3);
                  print('${tag} is not in alltags');
                  var tag2 = Tag(tagName: tag);
                  addTag(tag2, context);
                }
              }

            });

            if(tcontroller == '' && dcontroller == '' && icontroller == ''){
              print("not valid");
            }else{
              var todo = Todo2(
                title: tcontroller.text,
                description: dcontroller.text,
                image: icontroller.text,
                tags: test,
              );
              updateData(todo, widget.docid.toString(),context);

              setState(() {
                showSnackBar(context, 'todo ${widget.doctitle} successfully updated!');
              });
            }
          },
          child: Icon(Icons.update),
    ),
    );
  }
}



