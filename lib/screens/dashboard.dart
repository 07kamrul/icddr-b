import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icddrb/db/SqliteDatabase.dart';
import 'package:icddrb/model/members.dart';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),),
                  Text("Age", style:
                  TextStyle(color: Colors.grey),),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Date",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),),
                  Text("Sex", style:
                  TextStyle(color: Colors.grey),),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    _displayCard(Member member){
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
                  Text("Name: ${member.fullName}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text("Age: ${member.age}",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Date: ${member.date.day}/${member.date.month}/${member.date.year}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text("Sex: ${member.gender}",
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Dashboard")),
        elevation: .1,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: SqliteDatabase().getRecord(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Member>> snapshot) {
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
        ),
      ),
    );
  }
}


