import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/login_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  LoginBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Text(
              "Siddhibiniyak",
              style: TextStyle(
                fontFamily: "BebasNeue",
                fontSize: 80,
                color: Color(0xFF373737),
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 3.0),
                    blurRadius: 10.0,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
            Text(
              "sales app",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 40,
                color: Color(0xFF373737),
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 3.0),
                    blurRadius: 10.0,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              child: Material(
                color: Color(0xFFFB8320),
                borderRadius: BorderRadius.circular(5),
                elevation: 10,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      StreamBuilder(
                          stream: _bloc.email,
                          builder: (context, snapshot) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 5, left: 5, right: 5),
                              child: Material(
                                color: Colors.grey.shade200.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: _bloc.changeEmail,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        color: Colors.black38),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                            );
                          }),
                      StreamBuilder<String>(
                          stream: _bloc.password,
                          builder: (context, snapshot) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 5, left: 5, right: 5),
                              child: Material(
                                  color: Colors.grey.shade200.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: TextField(
                                            obscureText: _isObscure,
                                            onChanged: _bloc.changePassword,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                color: Colors.black38),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "Password",
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white70)),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.black45,
                                          ),
                                          onPressed: () {
                                            this.setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          }),
                      StreamBuilder<bool>(
                          stream: _bloc.submitValidtor(),
                          builder: (context, snapshot) {
                            return RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: snapshot.data == true
                                  ? () {
                                      _bloc.login();
                                    }
                                  : () {},
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontFamily: "BebasNeue",
                                    fontSize: 18,
                                    color: Color(0xFF373737)),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "\" You can't login if you're not a registered staff. \"",
                style: TextStyle(fontFamily: "Oswald"),
              ),
            ),
            // Expanded(child: Container()),
            Text(
              "Develped by whoknnowswho.",
              style: TextStyle(color: Colors.black12, fontFamily: "BebasNeue"),
            ),
          ],
        ),
      ),
    );
  }
}
