import 'package:flutter/material.dart';
import 'package:sqlite_provider_starter/pages/todoEdit.dart';

class Todo extends StatefulWidget {
  String? doctitle;
  String? doctdescription;
  String? docimage;
  String? docid;
  String? docdate;
  List? doctags;
  List? alltags;

  Todo({Key? key, this.doctitle, this.doctdescription, this.docimage, this.docid, this.docdate, this.doctags,this.alltags}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();

}

Widget box(String title, Color backgroundcolor){
  return Container(
      margin: EdgeInsets.all(10),
      width: 80,
      color: backgroundcolor,
      alignment: Alignment.center,
      child: Text(title, style:TextStyle(
          color: Colors.white,
          fontSize: 20))
  );
}


class _TodoState extends State<Todo> {
  final tcontroller = TextEditingController();
  final dcontroller = TextEditingController();
  final icontroller = TextEditingController();


  @override
  /*void initState() {
    super.initState();
    tcontroller.text = widget.doctitle.toString();
    dcontroller.text = widget.doctdescription.toString();
    icontroller.text = widget.docimage.toString();

  }*/

  @override
  Widget build(BuildContext context) {
    var laaa = widget.doctags;
    List<String> laa2 = [];
    if(laaa != null){
      for(var i = 0; i< laaa.length;i++){
        laa2.add(laaa[i]);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            print(laaa);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoEdit(
                  doctitle: widget.doctitle,
                  doctdescription: widget.doctdescription,
                  docimage: widget.docimage,
                  docid: widget.docid,
                  doctags: widget.doctags,
                  alltags: widget.alltags,
                   )
                )
            );
          },
              icon: Icon(Icons.edit))
        ],
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text("${widget.doctitle}"),
        bottom: PreferredSize(
            child: Text(
              "${widget.docdate}",
              style: TextStyle(color: Colors.white),
            ),
            preferredSize: Size.fromHeight(.5)),

      ),
      body: Container(

        child: SafeArea(
          child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0),
                  child:Container(
                    color: Colors.black,
                    child:  Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "${widget.doctdescription}",
                        style: TextStyle(color: Colors.white,),
                      ),
                    )
                  )
                ),
                SizedBox(height: 10),
                Container(
                  height: 180,
                  width: 720,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${widget.docimage}"),
                          fit: BoxFit.scaleDown
                      )
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:Row(
                      children: laa2.map((tag){
                        return box(tag, Colors.deepOrangeAccent);
                      }).toList(),
                    )
                )
              ],
            ),
          )

        ),
      ),
      
    );
  }
}
