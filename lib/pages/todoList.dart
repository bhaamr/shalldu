import 'package:flutter/material.dart';
import 'package:sqlite_provider_starter/database/firestoreHandler.dart';
import '../routes/routes.dart';
//import '../database/firestoreHandler.dart';
import '../pages/todoPage.dart';
import '../pages/todoEdit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Cloudtest extends StatefulWidget {
  const Cloudtest({Key? key}) : super(key: key);
  @override
  _CloudtestState createState() => _CloudtestState();
}

class _CloudtestState extends State<Cloudtest> {
  late Map data ;
  late Map data2;
  var category;
  var carMake;
  List<String> tags = [];

  tagfunc() async{
    final QuerySnapshot result =
    await FirebaseFirestore.instance.collection('tags').get();
    final List<DocumentSnapshot> documents = result.docs;
    result.docs.forEach((document) {
      if(tags.contains(document['tagName'])){

      }else{
        tags.add(document['tagName']);
      }

    });
  }





  Widget _buildListItem2(BuildContext context,DocumentSnapshot document){
    bool? _checked = document['completed'];
    return Card(
      color: Colors.black,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            caption: 'See full info',
            color: Colors.purple[600],
            icon: Icons.preview,
            onTap: () {
              /*doctitle = document['title'];
              docdescription = document['description'];
              docimage = document['image'];
              print(document.id);*/
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Todo(
                    doctitle: document['title'],
                    doctdescription: document['description'],
                    docimage: document['image'],
                    docid: document.id,
                    docdate: document['created'],
                    doctags: document['tags'],
                    alltags: tags,

                     )
                  )
              );
            },
          ),
        ],
        child: CheckboxListTile(
            title: Text(
              document['title'],
              style: TextStyle(color: Colors.white),
            ),
          checkColor: Colors.white,
          activeColor: Colors.white,
          side: BorderSide(color: Colors.white),
          value: document['completed'],
          onChanged: (bool? value) {
            setState(() {
              _checked = value;
            });
          }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = '';
    tagfunc();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
          child: SafeArea(
            child:
        SizedBox(
          width: 600.0,
          height: 700.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.white,)),
                  Flexible(
                      child: Container(
                        width: double.infinity,
                      )
                  ),
                    Flexible(
                        child: Container(
                          width: double.infinity,
                        )
                    ),

                  Expanded(
                          child:
                          StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('tags').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            //var carMake = snapshot.data!.docs[snapshot.data!.docs.length-1].get('tagName');
                            if (!snapshot.hasData) return const Text('Loading...');
                                //.where('tagName',  isEqualTo: 'all');
                            return DropdownButton(
                              dropdownColor: Colors.black54,
                              isExpanded: true,
                              value: carMake,
                              items: snapshot.data?.docs.map((value) {
                                return DropdownMenuItem(
                                  value: value.get('tagName'),
                                  child: AutoSizeText('${value.get('tagName')}' , style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (newvalue) {
                                debugPrint('selected onchange: $newvalue');
                                setState(
                                      () {
                                        carMake = newvalue;
                                    debugPrint('make selected: $newvalue');
                                  },
                                );
                              },
                            );
                          },
                        ),
                  ),
                    IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          //addData();
                          Navigator.of(context).pushNamed(RouteManager.addTodo);
                        }
                    )
                  ],
                ),
                Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                      child: StreamBuilder(
                          //stream: FirebaseFirestore.instance.collection('todo').snapshots(),
                          stream: searchTag(['${carMake}']).snapshots(),
                          builder: (context,AsyncSnapshot snapshot){
                            if (!snapshot.hasData) return const Text('Loading...');
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context,index) =>
                                  _buildListItem2(context,snapshot.data!.docs[index]),
                            );
                          }
                      ),
                    )
                )
              ],
            ),
        )
          )
      ),
    );
  }
}

