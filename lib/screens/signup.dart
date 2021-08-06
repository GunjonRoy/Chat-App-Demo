import 'package:chatapp/services/methods.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCnt = TextEditingController();
  final TextEditingController _emailCnt = TextEditingController();
  final TextEditingController _passwordCnt = TextEditingController();
  late String _name;
  late String _email;
  late String _password;

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoding
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/img2.png'),
                      radius: 50,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Registration',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 13),
                    _buildNameInput(_nameCnt),
                    _buildEmailInput(_emailCnt),
                    _buildPasswordInput(_passwordCnt),
                    SizedBox(height: 10),
                    _buildSignupButton(),
                    SizedBox(height: 10),
                    _buildCancelButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildNameInput(TextEditingController _nameCnt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _nameCnt,
        maxLines: 1,
        keyboardType: TextInputType.name,
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Name",
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
        // validator: (value) => value!.isEmpty ? 'Name can\'t be empty' : null,
        // onSaved: (value) => _name = value!.trim(),
      ),
    );
  }

  Widget _buildEmailInput(TextEditingController _emailCnt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _emailCnt,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Email",
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        // validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
        // onSaved: (value) => _email = value!.trim(),
      ),
    );
  }

  Widget _buildPasswordInput(TextEditingController _passwordCnt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _passwordCnt,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        // validator: (value) =>
        //     value!.isEmpty ? 'Password can\'t be empty' : null,
        // onSaved: (value) => _password = value!.trim(),
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: RaisedButton(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Text(
            'Signup',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (_nameCnt.text.isEmpty &&
                _emailCnt.text.isEmpty &&
                _passwordCnt.text.isEmpty) {
              setState(() {
                isLoding = true;
              });

              createAccount(_nameCnt.text, _emailCnt.text, _passwordCnt.text)
                  .then((user) {
                if (user != null) {
                  setState(() {
                    isLoding = false;
                  });
                  print('Registration successful');
                } else {
                  print("Registration failed");
                }
              });
            } else {
              print("Failed");
            }
          },
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: RaisedButton(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.red,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}