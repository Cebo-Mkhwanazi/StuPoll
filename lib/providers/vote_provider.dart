import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//final Stream<QuerySnapshot> _partiesStream = FirebaseFirestore.instance.collection('myVotes').snapshots();


class Vote with ChangeNotifier{
  int voteCount=2;
  int chairVote=1;
  int secVote=1;
  int finVote=1;
  int supVote=1;
  int resVote = 1;
  int get myVote => voteCount;
  int get chairVoteG => chairVote;
  int get secVoteG => secVote;
  int get finVoteG => finVote;
  int get supVoteG => supVote;
  int get resVoteG => resVote;
  // var document = FirebaseFirestore.instance.collection('myVotes').doc('userId').get();
  // voteCount = document['voteCount'];
  Future<int> done()async{
    var document = await FirebaseFirestore.instance.collection('myVotes').doc('userId').get();
    // document.get() => then(function(document) {
    // print(document("name"));
    // });
    voteCount = document['voteCount'];
    return voteCount;
  }
  // void incrementVote(){
  //   voteCount++;
  // }
  void chairVoteDec(){
    chairVote=0;
    voteCount--;
  }
  void secVoteDec(){
    secVote=0;
    voteCount--;
  }
  void finVoteDec(){
    finVote=0;
    voteCount--;
  }
  void supVoteDec(){
    supVote=0;
    voteCount--;
  }
  void resVoteDec(){
    resVote=0;
    voteCount--;
  }
}
