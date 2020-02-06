import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/shops_bloc.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/widget/adder_button.dart';
import 'package:gazzabko_admin_app/widget/input_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddShop extends StatefulWidget {
  final String job;
  final Shop shop;

  const AddShop({Key key, this.job, this.shop}) : super(key: key);
  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  TextEditingController _nameController;
  ShopsBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ShopsBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    updateControllers();
  }

  updateControllers() {
    if (widget.job == "update") {
      _nameController.text = widget.shop.name;
    }
  }

  updateSubjects() {
    if (widget.job == "update") {
      _bloc.changeName(widget.shop.name);
      _bloc.changeArea(widget.shop.area);
      _bloc.changeItemsList(widget.shop.items.asList());
    }
  }

  @override
  Widget build(BuildContext context) {
    updateSubjects();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _bloc.name,
              builder: (context, snapshot) {
                return InputFields(
                  onChanged: _bloc.changeName,
                  controller: _nameController,
                  hintText: "The Sijan Complex",
                  label: "Name",
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
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
                      child: StreamBuilder(
                        stream: _bloc.item,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Select lot');
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            case ConnectionState.active:
                              return DropdownButton<String>(
                                value: snapshot.data,
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                onChanged: _bloc.changeItem,
                                underline: Container(),
                                items: _bloc.itemsList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.oswald(),
                                    ),
                                  );
                                }).toList(),
                              );
                            default:
                              return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                      child: Builder(
                        builder: (context) {
                          return AdderButton(
                            onPressed: widget.job == "update"
                                ? _bloc.appendItemsToShop
                                : _bloc.addItemsToShop,
                          );
                        },
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
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
              child: StreamBuilder(
                stream: _bloc.area,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Select lot');
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.active:
                      return DropdownButton<String>(
                        value: snapshot.data,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        underline: Container(),
                        onChanged: _bloc.changeArea,
                        items: _bloc.areasList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.oswald(),
                            ),
                          );
                        }).toList(),
                      );
                    default:
                      return null;
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFC2C2C2),
                          blurRadius: 10.0,
                          offset: Offset(0, 8))
                    ]),
                child: StreamBuilder<List<String>>(
                  stream: _bloc.items,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text(snapshot.error);
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("Awaiting Bids!!!");
                        break;
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                        return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 7,
                                          offset: Offset(2, 5))
                                    ],
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xff15A881),
                                          Color(0xFF77CD07),
                                        ])),
                                child: Text(
                                  "${snapshot.data[index]}",
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        );
                        break;
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ),
            StreamBuilder(
              stream: _bloc.name,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    onPressed: snapshot.hasData
                        ? widget.job == "update"
                            ? () {
                                _bloc.updateShop(widget.shop.createdAt);
                              }
                            : _bloc.saveShop
                        : null,
                    child: Text(
                      widget.job == "update" ? "Update" : "Save",
                      style: GoogleFonts.playfairDisplay(fontSize: 18),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
