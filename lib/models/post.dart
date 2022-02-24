

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String profileImage;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final likes;

  const Post ({
    required this.description,
    required this.uid,
    required this.profileImage,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    "description": description,
    "uid": uid,
    "profileImage": profileImage,
    "username": username,
    "postId": postId,
    "datePublished": datePublished,
    "postUrl": postUrl,
    "likes": likes,
  };

  // Format document Snapshot to userModel
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      profileImage: snapshot['profileImage'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
    );
  }
}