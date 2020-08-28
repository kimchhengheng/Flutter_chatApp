import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String imageurl;
  String message;
  String username;
  bool isMe;


  MessageBubble({this.imageurl, this.message, this.username, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(

              padding: EdgeInsets.all(7),

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
//                mainAxisSize: MainAxisSize.min,
                      children: [
                    Text(username),
                    Text(message)
                  ]),
                ),

              height: min(50,100),
              width: 180,
              decoration: BoxDecoration(
                  color: !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  border: Border.all(
                    color: !isMe ? Colors.grey[400] : Theme.of(context).accentColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomRight: isMe? Radius.circular(0): Radius.circular(10.0),
                    bottomLeft: isMe? Radius.circular(10.0): Radius.circular(0),
                  )
                ),
              )

            ]
        ),
            Positioned(
              top:-10,
              left: isMe? null: 160,
              right: isMe? 160: null,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageurl),
              ),
            ),

      ],



    );
  }
}
