import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/gradient_appbar.dart';

class FinanceOfficer extends StatefulWidget {
  FinanceOfficer({
    required this.profImage,
    required this.position,
  });
  final String profImage;
  final String position;

  @override
  State<FinanceOfficer> createState() =>
      _FinanceOfficerState(profImage: profImage, position: position);
}

class _FinanceOfficerState extends State<FinanceOfficer> {
  _FinanceOfficerState({
    required this.profImage,
    required this.position,
  });
  final String profImage;
  final String position;

  final Stream<QuerySnapshot> _partiesStream = FirebaseFirestore.instance.collection('finance_officer').snapshots();
  String? userId = FirebaseAuth.instance.currentUser!.uid!;
  int bb =0;
  Future<int> votes()async{
    final  votes = await FirebaseFirestore.instance.collection('myVotes').doc('Votes-$userId').get();
    bb = votes['voteCount'];
    return bb;
  }

  Color col = Colors.red;
  String a = '';
  //copy
  int voteCount = 0;
  bool finBool = false;
  bool voted = false;
  int decV() {
    setState(() {
      bb--;
      voteCount=bb;
    });
    return voteCount;
  }
//End
  @override
  Widget build(BuildContext context) {
    //CRUD START
    votes();
    //voteCount = bb;
    //END

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0.0, 50.0),
        child: GradientAppBar(position!),
      ),
      body: StreamBuilder(
        stream: _partiesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "2022/23 SRC Elections",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage("$profImage"),
                radius: 40,
              ),
              /*SizedBox(
                height: 10,
              ),
              Text(
                position!,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),*/
              // Copy This**************************
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('myVotes')
                    .doc('Fin-$userId')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Text(
                      '!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    );
                  }
                  return Column(
                    children: [
                      Text(
                        snapshot.data!['finBool'] ? 'You voted ${snapshot.data!['sPname']}' : '',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        snapshot.data!['finBool'] ? '${snapshot.data!['sName']},' : '',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
              // End here**************************
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 60,
                  child: const Divider(
                    color: Colors.green,
                  )),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,

                  // childAspectRatio: (1 / 1.3),
                ),
                itemBuilder: (BuildContext context, int index) {
                  // if(snapshot.data!.docChanges[index].doc['color']=='amberAccent'){
                  //   col = Colors.amberAccent;
                  // }else if(snapshot.data!.docChanges[index].doc['color']=='red'){
                  //   col = Colors.red;
                  // }else if(snapshot.data!.docChanges[index].doc['color']=='lightBlue'){
                  //   col = Colors.lightBlue;
                  // }
                  return GestureDetector(
                    child: _partiesBox2(
                        '${snapshot.data!.docChanges[index].doc['image_url1']}',
                        '${snapshot.data!.docChanges[index].doc['image_url2']}',
                        '${snapshot.data!.docChanges[index].doc['pname']}',
                        '${snapshot.data!.docChanges[index].doc['name']}'),
                    onTap: () {},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _partiesBox2(String paImage,String faceImage, String? pName, String? name) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        image: DecorationImage(
          image: NetworkImage(paImage),
        ),
        //color: pCol,
      ),
      // padding: EdgeInsets.all(10),
      //  width: 40,
      //  height: 40,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(faceImage),
                radius: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  color: Colors.white,
                  child: Text(
                    pName!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          //SizedBox(height: 10,),
          const SizedBox(
            height: 10,
          ),
          Container(
              color: Colors.white,
              child: Text(
                name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          const Spacer(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('myVotes')
                .doc('Fin-$userId')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Text(
                  '!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                );
              }
              //voteCount = snapshot.data!['voteCount'];
              finBool = snapshot.data!['finBool'];
              return finBool
                  ? Container(
                width: 130,
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text(
                      "Voted",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              )
                  : GestureDetector(
                child: Container(
                  width: 130,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.lightBlue,
                  ),
                  child: Center(
                      child: Text(
                        "Vote",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
                onTap: () {
                  setState(() {
                    voteCount = decV();
                    if (voteCount != 0) {
                      FirebaseFirestore.instance
                          .collection('myVotes')
                          .doc('Fin-$userId')
                          .set({
                        'voteCount': voteCount,
                        'sName': name,
                        'sPname': pName,
                        'finBool': true,
                      });
                      /* FirebaseFirestore.instance
                                .collection('myVotes')
                                .doc('userIdFin')
                                .update({
                              'voteCount': voteCount,
                            });*/
                      print("I am clicked");
                    } else {
                      print(
                          " Ryza bro i am finaly zero now stoooop**************");
                    }
                    FirebaseFirestore.instance
                        .collection('myVotes')
                        .doc('Votes-$userId')
                        .update({
                      'voteCount': voteCount,
                    });
                    voted = true;
                    //FirebaseFirestore.instance.collection('myVotes').doc('userId').update({'chairBool': true});
                    //FirebaseFirestore.instance.collection('myVotes').doc('userId').set({'voteCount': decV()});
                  });
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
