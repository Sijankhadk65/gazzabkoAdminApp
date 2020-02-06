import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzabko_admin_app/model/user.dart';

class UserCard extends StatefulWidget {
  final User userSnapshot;

  const UserCard({Key key, this.userSnapshot}) : super(key: key);
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: "${widget.userSnapshot.photoUrl}",
                    imageBuilder: (context, imageProvider) => Center(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-3, -5),
                              blurRadius: 5)
                        ]),
                        child: SvgPicture.asset("assets/svg/error.svg"),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.userSnapshot.name,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        widget.userSnapshot.email,
                        style: TextStyle(
                            fontFamily: "Oswald", color: Colors.black38),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
