import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icddrb/db/SqliteDatabase.dart';
import 'package:icddrb/model/members.dart';
import 'package:icddrb/screens/dashboard.dart';
import 'package:icddrb/screens/login_page.dart';
import 'package:intl/intl.dart';

enum ChooseYourGender { male, female, others }

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  _InsertPageState createState() =>  _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  // final genderController = TextEditingController();

  final ChooseYourGender _yourGender = ChooseYourGender.male;
  bool checkedValue = false;

  void _performSignInPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  String? dropdownvalue;
  List genders = ["Male", "Female"];
  late String selectGender;
  @override
  void initState(){
    selectGender = "";
    super.initState();
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
            activeColor: Theme.of(context).primaryColor,
            value: genders[btnValue],
            groupValue: selectGender,
            onChanged: (value) {
              setState(() {
                print(value);
                selectGender = value;
              });
            }),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final fullName = TextFormField(
      controller: fullNameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Enter your full name...',
        labelText: 'Full Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your valid full name';
        }
        return null;
      },
    );

    final age = TextFormField(
      controller: ageController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Enter your age...',
        labelText: 'Age',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your valid mobile no';
        }
        return null;
      },
    );

    final date = TextFormField(
      controller: dateController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today),
        hintText: 'Enter your date...',
        labelText: 'Date',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2099)
        );
        if(pickedDate != null){
          print(pickedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate);

          setState(() {
            dateController.text = formattedDate;
          });
        }
        else{
          print("Date is not selected.");
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your valid date';
        }
        return null;
      },
    );


    final time = TextFormField(
      controller: timeController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: const InputDecoration(
        icon: Icon(Icons.timer),
        hintText: 'Enter your time...',
        labelText: 'Time',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now()
        );
        if(pickedTime != null){
          print(pickedTime.format(context));
          DateTime parseTime = DateFormat.jm().parse(pickedTime.format(context));
          print(parseTime);

          String formattedTime = DateFormat('HH:mm:ss').format(parseTime);
          print(formattedTime);

          setState(() {
            timeController.text = formattedTime;
          });
        }
        else{
          print("Time is not selected.");
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your valid date';
        }
        return null;
      },
    );


    final gender =  Row(
      children: <Widget>[
        const Icon(
          Icons.people_alt_outlined,
          color: Colors.grey,
          size: 30.0,
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          "Gender:",
          style: TextStyle(fontSize: 15.0),
        ),
        addRadioButton(0, 'Male'),
        addRadioButton(1, 'Female')
      ],
    );

    final education = Row(
      children: [
        const Icon(
          Icons.cast_for_education,
          color: Colors.grey,
          size: 30.0,
        ),
        const SizedBox(
          width: 25,
        ),
        const Text(
          'Education:',
          style: TextStyle(fontSize: 15.0),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
            value: dropdownvalue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepOrange),
            items: <String>['SSC', 'HSC', 'BSc', 'MSc']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue;
              });
            })
      ],
    );

    final insertBtn = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: (){
          _insertData(fullNameController.text,
              ageController.text,
              dateController.text,
              timeController.text,
              selectGender,
              dropdownvalue!

          );
        },
        child: const Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add")),

        backgroundColor: Colors.pink,
      ),
      key: _scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              children: <Widget>[
                const SizedBox(height: 10.0),
                fullName,
                const SizedBox(height: 12.0),
                age,
                const SizedBox(height: 12.0),
                date,
                const SizedBox(height: 12.0),
                time,
                const SizedBox(height: 12.0),
                gender,
                const SizedBox(height: 12.0),
                education,
                const SizedBox(height: 18.0),
                insertBtn,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _insertData(String full_name, String age, String date, String time, String gender, String education) async {
    Member member = Member(
        fullName: full_name,
        age: int.parse(age),
        time: time,
        date: DateTime.parse(date),
        gender: gender,
        education: education
    );
    print(member.fullName);
    print(member.age);
    print(member.date);
    print(member.time);
    print(member.gender);
    print(member.education);

    var response = await SqliteDatabase().insertRecord(member);
    print(response);

    if(response != 0){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Successfully member saved.")));
      _clearAll();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something wrong while Inserting Record.")));
    }
  }

  _clearAll(){
    fullNameController.clear();
    ageController.clear();
    dateController.clear();
    timeController.clear();
  }
}
