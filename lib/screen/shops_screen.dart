import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/shops_bloc.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/screen/add_shop.dart';
import 'package:gazzabko_admin_app/widget/empty_list_message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShopsScreen extends StatefulWidget {
  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  ShopsBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ShopsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shops")),
      body: Container(
        child: StreamBuilder<List<Shop>>(
          stream: _bloc.shops,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting bids!");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return snapshot.data.isEmpty
                    ? EmptyListMessage(
                        message: "Sorry! No registered shops yet.")
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return Dismissible(
                            onDismissed: (direction) {
                              _bloc
                                  .deleteShop(snapshot.data[index].createdAt)
                                  .whenComplete(() {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Shop has been deleted.")));
                              });
                            },
                            key: Key(snapshot.data[index].createdAt),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => Provider(
                                                  child: AddShop(
                                                    job: "update",
                                                    shop: snapshot.data[index],
                                                  ),
                                                  create: (_) => ShopsBloc(),
                                                )));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Text(
                                        "${snapshot.data[index].name}",
                                        style: GoogleFonts.playfairDisplay(
                                            fontSize: 25),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Text(
                                            "${snapshot.data[index].area},",
                                            style: GoogleFonts.quicksand(),
                                          ),
                                          Text(
                                            " created by John Doe,",
                                            style: GoogleFonts.quicksand(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                break;
              default:
                return EmptyListMessage(message: "Sorry! Contact It Support.");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Provider(
                        create: (_) => ShopsBloc(),
                        dispose: (context, ShopsBloc bloc) => bloc.dispose(),
                        child: AddShop(),
                      )));
        },
      ),
    );
  }
}
