import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserInfoList extends StatefulWidget {
  const UserInfoList({Key? key}) : super(key: key);

  @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  Future<List<dynamic>> UserListInfo() async{
    var respponse= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    return jsonDecode(respponse.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserInfoList",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: UserListInfo(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
            if(asyncSnapshot.hasData){
              return ListView.builder(
                itemCount: asyncSnapshot.data.length,
                itemBuilder: (context,int position){
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(asyncSnapshot.data[position]["id"].toString()),
                      ),
                      title: Text(asyncSnapshot.data[position]["title"].toString()),
                      subtitle: Text(asyncSnapshot.data[position]["body"]),
                    ),
                  );
                },
              );

            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          },
        ),
      ),
    );
  }
}
