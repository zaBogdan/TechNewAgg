import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:technewsagg/api/rss_feeds.dart';
import 'package:technewsagg/models/user.dart';

import 'package:technewsagg/providers/user.dart';
import 'package:technewsagg/screens/select_user_screen.dart';

class ProfileManagerScreen extends StatefulWidget {
  final bool isNew;
  final User? userState;

  const ProfileManagerScreen({this.isNew = false, Key? key, this.userState})
      : super(key: key);

  @override
  _ProfileManagerScreenState createState() => _ProfileManagerScreenState();
}

class _ProfileManagerScreenState extends State<ProfileManagerScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _currentUser;

  List<String> profilePictures = [
    'bunny.jpg',
    'girl.jpg',
    'boy.jpg',
    'monster.jpg',
    'eyes.jpg'
  ];

  List<Map<String, dynamic>> websiteList = RSSFeeds().feedNames.map((e) {
    return {
      'name': e,
      'selected': false,
    };
  }).toList();

  @override
  void initState() {
    super.initState();
    _currentUser = widget.userState ?? User.newEmptyUser();
    _currentUser.websites.forEach((element) {
      websiteList.firstWhere(
          (website) => website['name'] == element)['selected'] = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateUser() {
    _currentUser.setWebsites = [];
    websiteList.forEach((element) {
      if (element['selected']) {
        _currentUser.addWebsite(element['name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void backToSelectUsers() {
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isNew ? 'Your new profile' : 'Edit profile',
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 26,
                  right: 26,
                ),
                child: TextFormField(
                  initialValue: _currentUser.username,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _currentUser.setUsername = value;
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              const Text('Profile picture',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                  height: 325,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 26,
                        right: 26,
                      ),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2 / 3,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: profilePictures.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/profile_images/${profilePictures[index]}'),
                                  fit: BoxFit.cover,
                                )),
                                child: CheckboxListTile(
                                  value: _currentUser.profilePicture ==
                                      profilePictures[index],
                                  onChanged: (value) => {
                                    setState(() {
                                      if (_currentUser.profilePicture ==
                                          profilePictures[index]) {
                                        _currentUser.profilePicture = '';
                                      } else {
                                        _currentUser.profilePicture =
                                            profilePictures[index];
                                      }
                                    })
                                  },
                                ));
                          }))),
              const SizedBox(height: 30.0),
              const Text('News websites',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                  height: 250,
                  child: ListView(
                    children: websiteList
                        .map((option) => CheckboxListTile(
                              title: Text(option['name']),
                              value: option['selected'],
                              onChanged: (value) {
                                setState(() {
                                  option['selected'] = value;
                                });
                              },
                            ))
                        .toList(),
                  )),
              if (widget.isNew)
                TextButton(
                    onPressed: () async {
                      updateUser();
                      bool response =
                          await context.read<UserProvider>().save(_currentUser);
                      if (response) {
                        Logger.root.info("User successfully saved");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('User successfully created'),
                        ));
                      } else {
                        Logger.root.severe("User not saved");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Failed to create user'),
                        ));
                      }
                      backToSelectUsers();
                    },
                    child: const Text('Save')),
              if (!widget.isNew)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () async {
                          updateUser();
                          bool response = await context
                              .read<UserProvider>()
                              .save(_currentUser);
                          if (response) {
                            Logger.root.info("User successfully updated");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('User successfully updated'),
                            ));
                          } else {
                            Logger.root.severe("Failed to update user");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Failed to update user'),
                            ));
                          }
                          backToSelectUsers();
                        },
                        child: const Text('Update')),
                    ElevatedButton(
                        onPressed: () async {
                          Logger.root.info("Delete button pressed");
                          bool response = await context
                              .read<UserProvider>()
                              .delete(_currentUser);
                          if (response) {
                            Logger.root.info("User successfully deleted");
                          } else {
                            Logger.root.severe("Failed to delete user");
                          }
                          backToSelectUsers();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Delete'))
                  ],
                )
            ],
          ),
        ));
  }
}
