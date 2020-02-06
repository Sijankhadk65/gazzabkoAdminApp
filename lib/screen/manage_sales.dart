import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/add_sales_bloc.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:gazzabko_admin_app/widget/adder_button.dart';
import 'package:gazzabko_admin_app/widget/drop_down.dart';
import 'package:gazzabko_admin_app/widget/item_displayer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ManageSales extends StatefulWidget {
  final String userName, shopName, job, area, timeStamp;
  final User user;

  const ManageSales({
    Key key,
    @required this.userName,
    @required this.shopName,
    @required this.job,
    this.area,
    this.timeStamp,
    this.user,
  }) : super(key: key);
  @override
  _ManageSalesState createState() => _ManageSalesState();
}

class _ManageSalesState extends State<ManageSales> {
  AddSalesBloc _addSalesbloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addSalesbloc = Provider.of<AddSalesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    _addSalesbloc.changeDeliveryPoint(widget.shopName);
    _addSalesbloc.getCartItems();
    return Scaffold(
      key: Key("salesScaffold"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 2.5, left: 5, right: 5),
              child: Text(
                "${widget.shopName}",
                style: GoogleFonts.playfairDisplay(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 5, right: 5),
              child: Text("${widget.userName}",
                  style: GoogleFonts.quicksand(
                      fontSize: 10,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: DropDownContainer(
                bloc: _addSalesbloc,
              )),
              Container(
                  margin:
                      EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
                  child: Builder(
                    builder: (context) {
                      return AdderButton(
                        onPressed: () {
                          widget.job == "new"
                              ? _addSalesbloc.addCartItem().then((value) {
                                  if (value == 0) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Already added!"),
                                    ));
                                  }
                                })
                              : _addSalesbloc
                                  .addSalesItem(widget.timeStamp)
                                  .then((value) {
                                  if (value == 0) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Already added!"),
                                    ));
                                  }
                                });
                        },
                      );
                    },
                  )),
            ],
          ),
          Expanded(
              child: ItemDisplayer(
            user: widget.user,
            area: widget.area,
            bloc: _addSalesbloc,
            job: widget.job,
            shopName: widget.shopName,
            timeStamp: widget.timeStamp,
          )),
        ],
      ),
    );
  }
}
