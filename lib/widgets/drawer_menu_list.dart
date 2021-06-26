import 'package:flutter/material.dart';

class DrawerMenuList extends StatefulWidget {
  // const DrawerMenuList({Key? key}) : super(key: key);

  @override
  _DrawerMenuListState createState() => _DrawerMenuListState();
}

class _DrawerMenuListState extends State<DrawerMenuList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomListTile(
          text: "Edit Info",
          onTap: (){},//add method for changing email or name or both
          icon: Icons.edit,
        ),
        CustomListTile(
          text: "Verify",
          onTap: (){},// add method to verify the resources only for admin
          icon: Icons.rule,
        ),
        CustomListTile(
          text: "Log Out",
          onTap: (){},// add method to log out
          icon: Icons.logout,
          color: Colors.red,
          rightArrowNeeded: false,
        ),
      ],
    );
  }
}


class CustomListTile extends StatelessWidget {

  String text = 'default';
  IconData icon;
  Function onTap;
  Color color ;
  bool rightArrowNeeded;

  CustomListTile({this.icon, this.text, this.onTap,this.color=Colors.black,this.rightArrowNeeded=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
            splashColor: Colors.lightBlue.shade300,
            onTap: onTap,
            child: Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon,color: color,),
                      Padding(
                        child: Text(text,style: TextStyle(fontSize: 16.0),),
                        padding: EdgeInsets.fromLTRB(10.0, 0, 8.0, 0),
                      )
                    ],
                  ),
                  if(rightArrowNeeded)Icon(Icons.arrow_right),
                ],
              ),
            )
        ),
      ),
    );
  }
}
