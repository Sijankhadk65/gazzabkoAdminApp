import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/add_sales_bloc.dart';
import 'package:gazzabko_admin_app/bloc/sales_bloc.dart';
import 'package:gazzabko_admin_app/model/sales.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:gazzabko_admin_app/screen/add_sales.dart';
import 'package:gazzabko_admin_app/widget/empty_list_message.dart';
import 'package:gazzabko_admin_app/widget/sales_item.dart';
import 'package:provider/provider.dart';

class SalesScreen extends StatefulWidget {
  final User user;

  const SalesScreen({Key key, this.user}) : super(key: key);
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  SalesBloc _salesBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _salesBloc = Provider.of<SalesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    _salesBloc.setName(widget.user.name);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: StreamBuilder<String>(
                        stream: _salesBloc.salesQuery,
                        builder: (context, snapshot) {
                          return Container(
                            child: Material(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5.0, top: 5, bottom: 5, left: 10),
                                child: TextField(
                                  style: TextStyle(fontFamily: "Quicksand"),
                                  onChanged: (value) {
                                    _salesBloc.changeSalesQuery(value);
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black26),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              color: Colors.white,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          );
                        })),
              ],
            ),
          ),
          StreamBuilder<List<Sales>>(
            stream: _salesBloc.sales,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Select lot');
                case ConnectionState.waiting:
                  return Text('Awaiting bids...');
                case ConnectionState.active:
                  return snapshot.data.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(snapshot.data[index].deliveryDate),
                              onDismissed: (direction) {
                                _salesBloc
                                    .deleteSalesData(
                                        snapshot.data[index].deliveryDate)
                                    .whenComplete(() {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Item Deleted"),
                                  ));
                                });
                              },
                              child: SalesItem(
                                salesItem: snapshot.data[index],
                                salesBloc: _salesBloc,
                              ),
                            );
                          },
                        )
                      : EmptyListMessage(message: "No Sales Found!");
                default:
                  return null;
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group_add),
        backgroundColor: Color(0Xff1B4F7F),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Provider<AddSalesBloc>(
                  create: (context) => AddSalesBloc(),
                  dispose: (context, AddSalesBloc bloc) => bloc.dispose(),
                  child: AddSales(
                    user: widget.user,
                  ),
                ),
              ));
        },
      ),
    );
  }
}
