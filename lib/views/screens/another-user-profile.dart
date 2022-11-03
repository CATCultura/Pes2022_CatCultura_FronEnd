import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:like_button/like_button.dart';
import 'package:CatCultura/constants/theme.dart';
import 'package:CatCultura/views/widgets/myDrawer.dart';

class AnotherProfile extends StatelessWidget {
  AnotherProfile({super.key, required this.selectedUser});
  String selectedUser;
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: MyColorsPalette.lightBlue,
      ),
      backgroundColor: Colors.grey[200],
      // key: _scaffoldKey,
      drawer: const MyDrawer(
          "AnotherProfile", username: "SuperJuane", email: "juaneolivan@gmail.com"),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          SizedBox(height: 18),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                selectedUser,
                style: TextStyle(fontSize: 28, color: Colors.teal),
              ),
            ]
          ),
          buildContent(),
          SizedBox(height: 32),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const Text (
                'Afegir amic:  ',
                style: TextStyle(fontSize: 18, height: 1.4, color: Colors.black54),
              ),
              LikeButton(
                size: 40,
                likeBuilder: (isTapped){
                  return Icon(
                    Icons.bookmark,
                    size: 40,
                    color: isTapped ? Colors.deepPurple : Colors.grey,
                  );
                }
              ),
            ],
          ),
        ],
      ),
      /*
      body: Container(
          color: MyColors.warning,
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                MyColorsPalette.orange)),
            child: const Text('Add to friends'),
            onPressed: () {

            },
          )
       */
    );
  }

  Widget buildContent() => Column(
      children: const [

      SizedBox(height: 12),
      Text (
        'Usuari de CATCultura',
        style: TextStyle(fontSize: 20, height: 1.4, color: Colors.grey),
      ),
     /* Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [


        ],
      ),

*/
    ]

  );

  Widget buildTop() {
    final bottom = profileHeight/2;
    final top = coverHeight - profileHeight/2;
    return Stack (
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container (
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfilePicture(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network('https://tecnohotelnews.com/wp-content/uploads/2019/05/shutterstock_214016374.jpg'),
      height: coverHeight,
      width: double.infinity,
      //fit: BoxFit.cover,
  );

  Widget buildProfilePicture() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage('https://i.pinimg.com/736x/f4/be/5d/f4be5d2d0f47b755d87e48a6347ff54d.jpg'),
  );


}