import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/target_bloc.dart';
import 'package:gazzabko_admin_app/model/target.dart';
import 'package:gazzabko_admin_app/widget/input_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddTarget extends StatefulWidget {
  final String job;
  final Target target;

  const AddTarget({Key key, this.job, this.target}) : super(key: key);
  @override
  _AddTargetState createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  TextEditingController _targetController;
  TargetBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<TargetBloc>(context);
  }

  @override
  void initState() {
    _targetController = TextEditingController();
    super.initState();
    if (widget.job == "update") {
      _targetController.text = widget.target.target.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.job == "update") {
      _bloc.changeTargetValue(widget.target.target.toString());
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                child: Material(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top: 5, bottom: 5),
                  child: Text(
                    widget.job == "'update"
                        ? "${widget.target.year}/${widget.target.month}"
                        : "${_bloc.getYear()}/${_bloc.getMonth()}",
                    style: GoogleFonts.oswald(fontSize: 20),
                  ),
                ))),
            Container(
              margin: EdgeInsets.all(10),
              child: StreamBuilder(
                stream: _bloc.targetValue,
                builder: (context, snapshot) {
                  return InputFields(
                    controller: _targetController,
                    onChanged: _bloc.changeTargetValue,
                    hintText: "1122",
                    type: TextInputType.number,
                    label: "Target",
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    default:
                      return null;
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: StreamBuilder<String>(
                  stream: _bloc.targetValue,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      child: Text(widget.job == "update" ? "Update" : "Add"),
                      onPressed: snapshot.hasData
                          ? () {
                              widget.job == "update"
                                  ? _bloc.updateTarget(
                                      widget.target.month,
                                      widget.target.year,
                                      widget.target.createdAt)
                                  : _bloc.saveTarget();
                            }
                          : null,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
