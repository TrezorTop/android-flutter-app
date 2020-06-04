import 'dart:async';

import 'package:buddiesgram/widgets/HeaderWidget.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  submitUsername(){
    final form = _formKey.currentState;
    if(form.validate()) {
      form.save();

      SnackBar snackBar = SnackBar(content: Text("Добро пожаловать, " + username));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 4), (){
        Navigator.pop(context, username);
      });
    }
  }


  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, strTitle: "Регистрация", disappearedBackButton: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 26.0),
                    child: Center(
                      child: Text("Укажите ваш логин, он будет виден всем пользователям", style: TextStyle(fontSize: 13.0),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Container(
                      child: Form(
                        key: _formKey ,
                        autovalidate: true,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (val){
                            if(val.trim().length < 4 || val.isEmpty) {
                              return "Логин слишком короткий";
                            }
                            else if (val.trim().length > 15) {
                              return "Логин слишком длинный";
                            }
                            else {
                              return null;
                            }
                          },
                          onSaved: (val) => username = val,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: OutlineInputBorder(),
                            labelText: "Логин",
                            labelStyle: TextStyle(fontSize: 20.0),
                            hintText: "Должно быть как минимум 4 символа",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: submitUsername,
                    child: Container(
                      height: 55.0,
                      width: 360.0,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "Продолжить",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
