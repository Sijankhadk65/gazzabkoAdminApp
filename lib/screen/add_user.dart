import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/users_bloc.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widget/input_fields.dart';

class AddUser extends StatefulWidget {
  final String job, adminEmail;
  final User user;

  const AddUser({Key key, @required this.job, this.adminEmail, this.user})
      : super(key: key);
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController _nameController, _emailController, _passwordController;

  File _image;
  chooseFile() {
    ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      this.setState(() {
        _image = image;
      });
    });
  }

  UserBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<UserBloc>(context);
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    updateControllers();
    super.initState();
  }

  updateControllers() {
    if (widget.job == "update") {
      _nameController.text = widget.user.name;
      _emailController.text = widget.user.email;
      _passwordController.text = widget.user.password;
    }
  }

  updateSubjects() {
    if (widget.job == "update") {
      _bloc.changeName(widget.user.name);
      _bloc.changePassword(widget.user.password);
      _bloc.changeArea(widget.user.area);
      _bloc.changeAccType(widget.user.accType);
      _bloc.changeEmail(widget.user.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    updateSubjects();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: _bloc.name,
              builder: (context, snapshot) {
                return InputFields(
                  controller: widget.job == "update" ? _nameController : null,
                  bottomPadding: snapshot.hasError ? 5 : 0,
                  errorText: snapshot.error,
                  label: "Name",
                  hintText: "John Doe",
                  onChanged: _bloc.changeName,
                );
              },
            ),
            StreamBuilder(
              stream: _bloc.email,
              builder: (context, snapshot) {
                return InputFields(
                  controller: widget.job == "update" ? _emailController : null,
                  bottomPadding: snapshot.hasError ? 5 : 0,
                  onChanged: _bloc.changeEmail,
                  hintText: "you@example.com",
                  label: "Email",
                  errorText: snapshot.error,
                );
              },
            ),
            StreamBuilder(
              stream: _bloc.password,
              builder: (context, snapshot) {
                return InputFields(
                  controller:
                      widget.job == "update" ? _passwordController : null,
                  bottomPadding: snapshot.hasError ? 5 : 0,
                  onChanged: _bloc.changeEmail,
                  hintText: "Password",
                  label: "Password",
                  errorText: snapshot.error,
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder(
                      stream: _bloc.accType,
                      initialData:
                          widget.job == "update" ? widget.user.accType : "RSM",
                      builder: (context, snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Account Type",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox.fromSize(
                              size: Size.fromHeight(5),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFC2C2C2),
                                        blurRadius: 10.0,
                                        offset: Offset(0, 8))
                                  ]),
                              child: DropdownButton<String>(
                                value: snapshot.data,
                                underline: Container(),
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                style: TextStyle(
                                    fontFamily: "Oswald",
                                    color: Colors.black87),
                                onChanged: _bloc.changeAccType,
                                items: [
                                  'RSM',
                                  "SM",
                                  "ASM"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: _bloc.area,
                      initialData:
                          widget.job == "update" ? widget.user.accType : "",
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('Select lot');
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.active:
                            return Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Area",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox.fromSize(
                                    size: Size.fromHeight(5),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFFC2C2C2),
                                              blurRadius: 10.0,
                                              offset: Offset(0, 8))
                                        ]),
                                    child: DropdownButton<String>(
                                      value: snapshot.data,
                                      icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      underline: Container(),
                                      style: TextStyle(
                                          fontFamily: "Oswald",
                                          color: Colors.black87),
                                      onChanged: _bloc.changeArea,
                                      items: _bloc.areaslist
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          default:
                            return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // _image != null
            //     ? Image.file(
            //         _image,
            //         height: 150,
            //       )
            //     : Container(height: 150),
            // _image == null
            //     ? RaisedButton(
            //         child: Text('Choose File'),
            //         onPressed: chooseFile,
            //         color: Colors.cyan,
            //       )
            //     : Container(),
            widget.job == "update"
                ? Builder(builder: (context) {
                    return StreamBuilder(
                      stream: _bloc.submitValid,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2.0,
                          color: Theme.of(context).appBarTheme.color,
                          disabledColor: Color(0xfFA46D40),
                          onPressed: snapshot.data == true
                              ? () {
                                  _bloc
                                      .updateUser(widget.adminEmail)
                                      .whenComplete(() {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("User Updated."),
                                    ));
                                  });
                                }
                              : null,
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    );
                  })
                : Builder(builder: (context) {
                    return StreamBuilder(
                      stream: _bloc.submitValid,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2.0,
                          color: Theme.of(context).appBarTheme.color,
                          disabledColor: Color(0xfFA46D40),
                          onPressed: snapshot.data == true
                              ? () {
                                  _bloc
                                      .saveUser(_image, widget.adminEmail)
                                      .whenComplete(() {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("User added"),
                                    ));
                                  });
                                }
                              : null,
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    );
                  })
          ],
        ),
      ),
    );
  }
}
