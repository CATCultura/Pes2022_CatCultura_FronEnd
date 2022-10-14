import 'package:flutter/material.dart';
import 'package:tryproject2/constants/theme.dart';
import 'package:tryproject2/views/widgets/myDrawer.dart';

class AnotherProfile extends StatelessWidget {
  const AnotherProfile({super.key});
  final double coverHeight = 280;
  final double profileHeight = 144;

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
          "Profile", username: "Alejandro", email: "alejandro@gmail.com"),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
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
      SizedBox(height: 8),
      Text(
        'Alejandro',
        style: TextStyle(fontSize: 28, color: Colors.teal),
      ),
      SizedBox(height: 8),
      Text (
        'Usuari de CATCultura',
        style: TextStyle(fontSize: 20, color: Colors.grey),
      )


    ]



  );

  Widget buildTop() {
    final top = coverHeight - profileHeight/2;
    return Stack (
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
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