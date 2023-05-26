import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:technewsagg/models/user.dart';
import 'package:technewsagg/providers/user.dart';
import 'package:technewsagg/screens/home_screen.dart';
import 'package:technewsagg/screens/profile_manager_screen.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  _SelectUserScreenState createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool editMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showFeedback = false;

    Widget _defaultProfile(String image, String profileName, bool editMode) {
      Logger.root.info("Building default profile $editMode");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/profile_images/$image',
                fit: BoxFit.cover,
                height: 128.0,
                color: editMode ? Colors.grey.withOpacity(0.65) : null,
                colorBlendMode: BlendMode.modulate,
              ),
              if (editMode) ...[
                const Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.edit, color: Colors.white),
                ))
              ]
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(profileName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Choose a profile',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      editMode = !editMode;
                    });
                  },
                  icon: const Icon(Icons.edit))
            ]),
        body: FutureBuilder<Map<String, dynamic>>(
            future: context.watch<UserProvider>().getAllUsers(),
            builder: (context, snapshot) {
              var usersCount = snapshot.data?['users']?.length ?? 0;
              if (snapshot.data?['canCreateMoreUsers'] == true) {
                ++usersCount;
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: usersCount,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          // color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      child: Stack(children: [
                        ((index == usersCount - 1 &&
                                snapshot.data?['canCreateMoreUsers'] == true)
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileManagerScreen(
                                                isNew: true,
                                              )));
                                },
                                child: _defaultProfile(
                                    'add_profile.png', 'New member', false),
                              )
                            : InkWell(
                                onTap: () {
                                  if (editMode == true) {
                                    setState(() {
                                      editMode = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileManagerScreen(
                                                  isNew: false,
                                                  userState: snapshot
                                                      .data?['users'][index],
                                                )));
                                    return;
                                  }
                                  Logger.root.info(
                                      "Setting current user to: ${snapshot.data?['users'][index].toJson()}");
                                  context.read<UserProvider>().setCurrentUser(
                                      snapshot.data?['users'][index]);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));
                                },
                                child: _defaultProfile(
                                    snapshot
                                        .data?['users'][index].profilePicture,
                                    snapshot.data?['users'][index].username,
                                    editMode),
                              ))
                      ]));
                },
              );
            }));
  }
}
