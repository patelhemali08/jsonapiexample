import 'package:apijsonexample/Product/InsertProductJson.dart';
import 'package:apijsonexample/Product/ViewProductJson.dart';
import 'package:apijsonexample/resource/Styleresorce.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("InsertProductJason"),
              onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsertProductJson())) ;
              },
            ),
            Divider(color: Styleresorce.abccolor,thickness: 3),
            ListTile(
              title: Text("ViewProductJason"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProductJson())) ;
              },
            ),
            Divider(color: Styleresorce.abccolor,thickness: 3),
          ],
        ),
      ),
    );
  }
}
