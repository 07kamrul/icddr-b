import 'package:flutter/material.dart';
import 'package:icddrb/screens/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

  void _submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  void showPassword(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 50.0,
      child: Image.asset('assets/images/logo.png'),
    );

    final username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          icon: Icon(Icons.mail),
          labelText: 'Username',
          hintText: "Enter your username..",
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter valid username';
        }
      },
    );
    final password = TextFormField(
      autofocus: false,
      obscureText: _isHidden,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Password',
          hintText: "Enter your password...",
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          suffix: InkWell(
            onTap: showPassword,
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          )
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter valid username';
        }
      },
    );

    final loginBtn = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),

        onPressed: _submit,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),

        backgroundColor: Colors.pink,
      ),
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
                logo,
                const SizedBox(height: 10.0),
                username,
                const SizedBox(height: 10.0),
                password,
                const SizedBox(height: 10.0),
                loginBtn,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
