import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/add_sales_bloc.dart';
import 'package:gazzabko_admin_app/bloc/sales_bloc.dart';
import 'package:gazzabko_admin_app/model/sales.dart';
import 'package:gazzabko_admin_app/screen/manage_sales.dart';
import 'package:provider/provider.dart';

class SalesItem extends StatefulWidget {
  final Sales salesItem;
  final SalesBloc salesBloc;
  const SalesItem({Key key, this.salesItem, this.salesBloc}) : super(key: key);
  @override
  _SalesItemState createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Material(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFF73D977),
          elevation: 5.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Provider(
                            create: (_) => AddSalesBloc(),
                            dispose: (context, AddSalesBloc bloc) =>
                                bloc.dispose(),
                            child: ManageSales(
                              job: "edit",
                              shopName: widget.salesItem.to.name,
                              userName: widget.salesItem.by.name,
                              timeStamp: widget.salesItem.deliveryDate,
                            ),
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.salesItem.to.name,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                      "delivered at ${DateTime.parse(widget.salesItem.deliveryDate).hour <= 12 ? DateTime.parse(widget.salesItem.deliveryDate).hour : DateTime.parse(widget.salesItem.deliveryDate).hour - 12} ${DateTime.parse(widget.salesItem.deliveryDate).hour <= 12 ? "AM" : "PM"}, on ${DateTime.parse(widget.salesItem.deliveryDate).day}/${DateTime.parse(widget.salesItem.deliveryDate).month}/${DateTime.parse(widget.salesItem.deliveryDate).year}")
                ],
              ),
            ),
          )),
    );
  }
}
