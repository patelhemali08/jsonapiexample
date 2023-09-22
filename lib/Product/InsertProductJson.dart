import 'dart:convert';

import 'package:apijsonexample/Product/ViewProductJson.dart';
import 'package:apijsonexample/Widget/MyButton.dart';
import 'package:apijsonexample/Widget/MyTextField.dart';
import 'package:apijsonexample/resource/Styleresorce.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

class InsertProductJson extends StatefulWidget {
  const InsertProductJson({super.key});

  @override
  State<InsertProductJson> createState() => _InsertProductJsonState();
}

class _InsertProductJsonState extends State<InsertProductJson> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InsertProductJson"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Styleresorce.defcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              MyTextField(
                obscuretext: false,
                controller: _name,
                text: "NAME",
                keyboardtype: TextInputType.text,
              ),
              SizedBox(height: 10,),
              MyTextField(
                obscuretext: false,
                controller: _qty,
                text: "QTY",
                keyboardtype: TextInputType.text,
              ),
              SizedBox(height: 10,),
              MyTextField(
                  obscuretext: false,
                controller: _price,
                text: "PRICE",
                keyboardtype: TextInputType.text,
              ),
            MyButton(
              onpress:() async {

      var name = _name.text.toString();
      var qty = _qty.text.toString();
      var price = _price.text.toString();

      Map<String ,String> prams = {
        "pname":name,
        "qty":qty,
        "price":price
      };


      Uri uri = Uri.parse("http://picsyapps.com/studentapi/insertProductJsonInput.php");
      var responce = await http.post(uri,body: jsonEncode(prams));

      if(responce.statusCode==200)
        {
          var body = responce.body.toString();
          print(body);

          var json = jsonDecode(body);
          if(json["status"]==true)
            {
              var msg = json["message"].toString();
            Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
            );

            }
          else
            {
              var msg = json["message"].toString();
            Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
            );


            }
        }
      else
        {
        Fluttertoast.showToast(
        msg: "API ERROR",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
        );

        }

      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProductJson()));
    } ,
              text: "SUBMIT",
            )
              // ElevatedButton(
              //     onPressed:() async {
              //
              //   var name = _name.text.toString();
              //   var qty = _qty.text.toString();
              //   var price = _price.text.toString();
              //
              //   Map<String ,String> prams = {
              //     "pname":name,
              //     "qty":qty,
              //     "price":price
              //   };
              //
              //
              //   Uri uri = Uri.parse("http://picsyapps.com/studentapi/insertProductJsonInput.php");
              //   var responce = await http.post(uri,body: jsonEncode(prams));
              //
              //   if(responce.statusCode==200)
              //     {
              //       var body = responce.body.toString();
              //       print(body);
              //
              //       var json = jsonDecode(body);
              //       if(json["status"]==true)
              //         {
              //           var msg = json["message"].toString();
              //         Fluttertoast.showToast(
              //         msg: msg,
              //         toastLength: Toast.LENGTH_SHORT,
              //         gravity: ToastGravity.CENTER,
              //         timeInSecForIosWeb: 1,
              //         backgroundColor: Colors.red,
              //         textColor: Colors.white,
              //         fontSize: 16.0
              //         );
              //
              //         }
              //       else
              //         {
              //           var msg = json["message"].toString();
              //         Fluttertoast.showToast(
              //         msg: msg,
              //         toastLength: Toast.LENGTH_SHORT,
              //         gravity: ToastGravity.CENTER,
              //         timeInSecForIosWeb: 1,
              //         backgroundColor: Colors.red,
              //         textColor: Colors.white,
              //         fontSize: 16.0
              //         );
              //
              //
              //         }
              //     }
              //   else
              //     {
              //     Fluttertoast.showToast(
              //     msg: "API ERROR",
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              //     );
              //
              //     }
              //
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProductJson()));
              //
              //
              //
              //
              //
              // }, child: Text("SUBMIT"))
            ],
          ),
        ),
      ),
    );
  }
}
