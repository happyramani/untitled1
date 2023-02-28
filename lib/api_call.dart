import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:untitled1/add_api.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(" API",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => AddUser(null),
                    ),
                  )
                      .then(
                        (value) {
                      if (value == true) {
                        setState(() {});
                      }
                    },
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100,right: 20),
                      child: Text(
                        'Add New user',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Icon(Icons.add_box_rounded,color: Colors.green,size: 30,)
                  ],
                ),

              ),
            )
          ],
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: jsonDecode(snapshot.data!.body.toString()).length,
                itemBuilder: (context, index) {
                  return Card(
                    color: index % 2 == 0 ? Colors.amberAccent : Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Positioned(
                              right: 8,
                              top: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 20,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => AddUser(
                                            jsonDecode(snapshot.data!.body
                                                .toString())[index]),
                                      ),
                                    )
                                        .then(
                                          (value) {
                                        if (value == true) {
                                          setState(() {});
                                        }
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 50,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 20,
                                child: InkWell(
                                  onTap: () {
                                    deleteUser((jsonDecode(snapshot.data!.body
                                        .toString())[index]['id']))
                                        .then(
                                          (value) {
                                        setState(() {});
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            child: Image.network(
                              (jsonDecode(snapshot.data!.body.toString())[index]
                              ['avatar'])
                                  .toString(),
                              height: 300,
                            )),
                        Container(
                            child: Text(
                              (jsonDecode(snapshot.data!.body.toString())[index]
                              ['name'])
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            child: Text(
                              (jsonDecode(snapshot.data!.body.toString())[index]
                              ['FacultyDepartment'])
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                        Container(
                            child: Text(
                              (jsonDecode(snapshot.data!.body.toString())[index]
                              ['FacultySalary'])
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: getDataFromwebserver(),
        ),
      ),
    );
  }

  Future<http.Response> getDataFromwebserver() async {
    var response = await http
        .get(Uri.parse('https://631189bb19eb631f9d742399.mockapi.io/Faculty'));
    print(response.body.toString());
    return response;
  }

  Future<void> deleteUser(id) async {
    var response1 = await http.delete(
        Uri.parse("https://631189bb19eb631f9d742399.mockapi.io/Faculty/$id"));
  }
}
