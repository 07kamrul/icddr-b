import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:icddrb/db/SqliteDatabase.dart';
import 'package:icddrb/model/student.dart';
import 'package:icddrb/screens/insert_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController =  TextEditingController();

  @override
  Widget build(BuildContext context) {

    final add = ElevatedButton(
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InsertPage())
        );
      },
      child: const Text('Add New'),
    );


    final search_add = Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 1.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        children: <Widget>[
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Search")  ,
              add
            ],
          ),
        ],
      ),
    );

    _displayCard(Student student){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Name: ${student.fullName}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text("Age: ${student.age}",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Date: ${student.date.day}/${student.date.month}/${student.date.year}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text("Sex: ${student.gender}",
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    final recycleView = FutureBuilder(
      future: SqliteDatabase().getRecord(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Student>> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return _displayCard(snapshot.data![index]);
              }
          );
        }
        else{
          return const Center(
            child: Text("No data found."),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Student List")),
        elevation: .1,
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
              child: search_add
          ),
          Expanded(
            child: SafeArea(
              child: recycleView,
            )
          )
        ],
      ),
    );
  }
}


