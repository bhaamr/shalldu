import 'package:flutter/cupertino.dart';
import 'package:sqlite_provider_starter/models/tag.dart';
import 'package:sqlite_provider_starter/pages/todoList.dart';
import '../models/todo2.dart';
import '../routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

addData(Todo2 todo, BuildContext context){
  var colectionReference = FirebaseFirestore.instance.collection('todo').doc();
  var todoid = colectionReference.id;
  var json = todo.toJson();
  colectionReference.set(json).then(
          (result) {
        Navigator.pop(context);
        print(todoid);
      }).catchError((error){
    print("error");
  });
}
addTag(Tag tag, BuildContext context){
  var colectionReference = FirebaseFirestore.instance.collection('tags').doc();
  var tagid = colectionReference.id;
  var json = tag.toJson();
  colectionReference.set(json).then(
          (result) {
        print(tagid);
      }).catchError((error){
    print("error");
  });
}

searchTag(List<String> tags){
  if(tags[0] == "all") {
    var colectionReference2 = FirebaseFirestore.instance
        .collection('todo');
    print(tags[0]);
    return colectionReference2;
  }
  else if(tags[0] == 'untaged'){
    var colectionReference3 = FirebaseFirestore.instance
        .collection('todo')
        .where('tags', isEqualTo: []);
    print(tags);
    return colectionReference3;
  }else{
    var colectionReference = FirebaseFirestore.instance
        .collection('todo')
        .where('tags', arrayContainsAny: tags);
    print(tags);
    return colectionReference;
  }
}



deleteData(String id, BuildContext context){
  var todoDoc = FirebaseFirestore.instance.collection('todo').doc(id);
  todoDoc.delete().then(
          (result) {
            Navigator.of(context)
                .popUntil(ModalRoute.withName("listPage"));
      }).catchError((error){
    print("error");
  });
}
updateData(Todo2 todo, String id, BuildContext context)
{
  var todoDoc = FirebaseFirestore.instance.collection('todo').doc(id);
  todoDoc.update(todo.toJson()).then(
          (result) {
            Navigator.of(context)
                .popUntil(ModalRoute.withName("listPage"));
      }).catchError((error){
    print("error");
  });

}
/*
fetchData(DocumentSnapshot document){
  List<String> todovals = [];
  String title = document['title'].toString();
  String description = document['description'].toString();
  String image = document['image'].toString();
  String id = document.id;
  todovals.add(title);
  todovals.add(description);
  todovals.add(image);
  todovals.add(id);

  return(todovals);
}*/