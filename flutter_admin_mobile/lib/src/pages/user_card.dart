import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../elements/CardWidget.dart';
import '../elements/User.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';
class UserCard extends StatefulWidget {
  const UserCard({Key key,@required double gap,this.con, this.title})  : gap = gap, super(key: key);
  final UserController con;
  final double gap;
  final String title;
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(widget.gap),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          UserAvatar(
                userAvatar: currentUser.value.image,
                width: 75,
                height: 75,
              ),
              SizedBox(height: 15),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Member since October 2015',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(widget.con.profileDetails.general.email),
                ],
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).rating,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(widget.con.profileDetails.rating.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).total_orders,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(widget.con.profileDetails.totalOrders.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).total_products,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(widget.con.profileDetails.totalProducts.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
