import 'package:flutter/material.dart';
import 'package:flutter_userlist_app/ui/frienddetails/friend_details_page.dart';
import 'package:flutter_userlist_app/ui/friends/friend.dart';
import 'package:http/http.dart' as http;

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => new _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<Friend> _friends = [];
  String url = 'https://randomuser.me/api/?results=25';

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  _loadFriends() async {
    http.Response response = await http.get(url);
    //
    setState(() {
      _friends = Friend.allFromResponse(response.body);
    });
  }

  Widget _buildFriendItem(BuildContext context, int index) {
    Friend friend = _friends[index];

    return new ListTile(
      onTap: () => _navigateToFriendDetails(friend, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(friend.avatar),
        ),
      ),
      title: new Text(friend.name),
      subtitle: new Text(friend.email),
    );

  }

  _navigateToFriendDetails(Friend friend, Object avatarTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new FriendDetailsPage(friend, avatarTag: avatarTag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (_friends.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _friends.length,
        itemBuilder: _buildFriendItem,
      );
    }

    return new Scaffold(
      appBar: new AppBar(title: new Text('Friends')),
      body: content,
    );
  }
}
