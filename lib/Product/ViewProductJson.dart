import 'dart:convert';

import 'package:apijsonexample/Widget/MyButton.dart';
import 'package:apijsonexample/resource/Styleresorce.dart';
import 'package:apijsonexample/resource/UrlResorce.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

class ViewProductJson extends StatefulWidget {


  @override
  State<ViewProductJson> createState() => _ViewProductJsonState();
}

class _ViewProductJsonState extends State<ViewProductJson> {

   Future<List<dynamic>?>?alldata;
   Future<List<dynamic>?>?data()async{
    Uri uri =Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var responce = await http.get(uri);
    if(responce.statusCode==200)
      {
        var body = responce.body.toString();
        var json = jsonDecode(body);
        return json ["data"];

        print("body :"+body);

      }
    else
      {
        print("API ARROR");
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = data();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewProductJson"),
      ),
      body: FutureBuilder(
        future:alldata,
        builder:(context, snapshot) {
          if(snapshot.hasData)
            {
              if(snapshot.data!.length<=0)
                {
                  return Center(child: Text("NO DATA"),);
                }
              else
                {
                  return ListView.builder(
                    itemCount:snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text("pid : "+snapshot.data![index]["pid"].toString(),style: Styleresorce.abctextstyle,),
                              Text("pname : "+snapshot.data![index]["pname"].toString(),style: Styleresorce.abctextstyle,),
                              Text("qty : "+snapshot.data![index]["qty"].toString(),style: Styleresorce.abctextstyle,),
                              Text("price : "+snapshot.data![index]["price"].toString(),style: Styleresorce.abctextstyle,),
                              Text("added_datetime : "+snapshot.data![index]["added_datetime"].toString(),style: Styleresorce.abctextstyle,),
                              Column(
                                children: [
                                  MyButton(
                                    text: "SUBMIT",
                                    onpress:  (){
                                      AlertDialog alert =AlertDialog(
                                        title: Text("DELETE") ,
                                        content: Text("ARE YOU SURE"),
                                        actions: [
                                          MyButton(
                                            onpress: ()async{

                                        var id = snapshot.data![index]["pid"].toString();
                                        print(id);

                                        Map<String,String>prams ={
                                          "pid":id,
                                        };

                                        Uri uri = Uri.parse("http://picsyapps.com/studentapi/deleteProductJson.php");
                                        var responce = await http.post(uri,body:jsonEncode(prams));
                                        if(responce.statusCode==200)
                                        {
                                          var body = responce.body.toString();
                                          var json = jsonDecode(body);

                                          print("body :"+body);

                                          if(json["status"]==true)
                                          {
                                            var msg = json["message"].toString();
                                            print(msg);

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
                                                fontSize: 16.0);
                                          }
                                          Navigator.of(context).pop();
                                          setState(() {
                                            alldata = data();
                                          });
                                        }
                                        else
                                        {
                                          print("NO API");
                                        }
                                        // Navigator.of(context).pop();

                                      },
                                      text: "YES",
                                      ),
                                          MyButton(
                                            onpress: (){
                                              Navigator.of(context).pop();
                                            },
                                            text: "NO",
                                          ),

                                        ],
                                      );
                                      showDialog(context: context, builder: (context){
                                        return alert;
                                      });
                                    }

                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                  );
                }
            }
          else
            {
              return Center(child: CircularProgressIndicator(),);
            }
        },
      )
    );
  }
}
