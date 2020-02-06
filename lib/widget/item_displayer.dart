import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/add_sales_bloc.dart';
import 'package:gazzabko_admin_app/model/cart_item.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:gazzabko_admin_app/widget/save_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDisplayer extends StatefulWidget {
  final AddSalesBloc bloc;
  final String job, shopName, area, timeStamp;
  final User user;

  const ItemDisplayer(
      {Key key,
      this.bloc,
      this.job,
      this.shopName,
      this.area,
      this.timeStamp,
      this.user})
      : super(key: key);
  @override
  _ItemDisplayerState createState() => _ItemDisplayerState();
}

class _ItemDisplayerState extends State<ItemDisplayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Color(0xFFEBEBEB)),
      margin: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Items",
            style: GoogleFonts.playfairDisplay(fontSize: 35),
          ),
          Divider(
            height: 0,
          ),
          widget.job == "new"
              ? Expanded(
                  child: StreamBuilder<List<CartItem>>(
                      stream: widget.bloc.salesItems,
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('Select lot');
                          case ConnectionState.waiting:
                            return Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "No items have been added",
                                  style: GoogleFonts.quicksand(),
                                ));
                          case ConnectionState.active:
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map((item) => Builder(builder: (context) {
                                        return Dismissible(
                                          key: Key(item.name),
                                          onDismissed: (direction) {
                                            widget.bloc
                                                .removeItemFromCart(item)
                                                .then((value) {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          "Item Deleted")));
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(item.name),
                                                Spacer(),
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: RawMaterialButton(
                                                    onPressed: () {},
                                                    child: Icon(
                                                        Icons.arrow_drop_up),
                                                    fillColor: Colors.blue,
                                                  ),
                                                ),
                                                Text("${item.quantity}"),
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: RawMaterialButton(
                                                    onPressed: () {},
                                                    child: Icon(
                                                        Icons.arrow_drop_down),
                                                    fillColor: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                                  .toList(),
                            );
                          default:
                            return null;
                        }
                      }),
                )
              : StreamBuilder(
                  stream: widget.bloc.getSalesItem(widget.timeStamp),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Select lot');
                      case ConnectionState.waiting:
                        return Text(
                          "No items have been added",
                          style: GoogleFonts.quicksand(),
                        );
                      case ConnectionState.active:
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data
                              .map<Widget>((item) =>
                                  Builder(builder: (context) {
                                    return Dismissible(
                                      key: Key(item.name),
                                      onDismissed: (direction) {
                                        widget.bloc
                                            .removeSalesItem(
                                                item, widget.timeStamp)
                                            .whenComplete(() {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Item Deleted")));
                                        });
                                      },
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(item.name),
                                            Spacer(),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                child:
                                                    Icon(Icons.arrow_drop_up),
                                                fillColor: Colors.blue,
                                              ),
                                            ),
                                            Text("${item.quantity}"),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                child:
                                                    Icon(Icons.arrow_drop_down),
                                                fillColor: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }))
                              .toList(),
                        );
                      default:
                        return null;
                    }
                  }),
          widget.job == "new"
              ? Divider(
                  height: 0,
                )
              : Container(),
          widget.job == "new"
              ? Builder(builder: (context) {
                  return SaveButton(
                    label: "Save",
                    onPressed: () {
                      widget.bloc
                          .saveNewSales(
                              area: widget.area,
                              shopName: widget.shopName,
                              user: widget.user)
                          .whenComplete(() {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Transaction Complete")));
                      });
                    },
                  );
                })
              : Container(),
        ],
      ),
    );
  }
}
