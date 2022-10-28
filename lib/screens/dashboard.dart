import 'package:flutter/material.dart';
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
  
  Widget _displayCard(Member member){
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
}


