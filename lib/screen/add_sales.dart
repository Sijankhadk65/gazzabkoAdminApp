import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/add_sales_bloc.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'manage_sales.dart';

class AddSales extends StatefulWidget {
  final User user;

  const AddSales({Key key, this.user}) : super(key: key);
  @override
  _AddSalesState createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  AddSalesBloc _addSalesbloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addSalesbloc = Provider.of<AddSalesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    _addSalesbloc.setArea(widget.user.area);
    _addSalesbloc.getShops();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black38),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Add Sales",
            style:
                GoogleFonts.playfairDisplay(color: Colors.black, fontSize: 22),
          ),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 5),
                      child: Text(
                        "Name",
                        style: GoogleFonts.playfairDisplay(fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        "${widget.user.name}",
                        style: GoogleFonts.quicksand(fontSize: 35),
                      ),
                    ),
                    StreamBuilder<List<Shop>>(
                      stream: _addSalesbloc.deliveryPoints,
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('Select lot');
                          case ConnectionState.waiting:
                            return Text('Awaiting bids...');
                          case ConnectionState.active:
                            return GridView.count(
                              shrinkWrap: true,
                              childAspectRatio: 4 / 1.5,
                              crossAxisCount: 2,
                              children: snapshot.data
                                  .map<Widget>((dp) => Container(
                                      margin: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 10),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xFF537895),
                                                Color(0xFF09203f),
                                              ]),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(2, 3),
                                                blurRadius: 8)
                                          ]),
                                      child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            Provider(
                                                              create: (_) =>
                                                                  AddSalesBloc(),
                                                              dispose: (context,
                                                                      AddSalesBloc
                                                                          bloc) =>
                                                                  bloc.dispose(),
                                                              child:
                                                                  ManageSales(
                                                                user:
                                                                    widget.user,
                                                                userName: widget
                                                                    .user.name,
                                                                shopName:
                                                                    dp.name,
                                                                job: "new",
                                                                area: dp.area,
                                                              ),
                                                            )));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  dp.name,
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )))))
                                  .toList(),
                            );

                          default:
                            return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
