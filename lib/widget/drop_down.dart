import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/add_sales_bloc.dart';

class DropDownContainer extends StatefulWidget {
  final AddSalesBloc bloc;

  const DropDownContainer({Key key, @required this.bloc}) : super(key: key);
  @override
  _DropDownContainerState createState() => _DropDownContainerState();
}

class _DropDownContainerState extends State<DropDownContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.bloc.item,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Select lot');
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
              child: DropdownButton<String>(
                value: snapshot.data,
                hint: Text("Items"),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                underline: Container(),
                onChanged: widget.bloc.changeItem,
                items: widget.bloc.cartItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}
