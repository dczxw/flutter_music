

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget{

   final String url;
   final double width;

   RoundImage({Key key, this.width,this.url}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        alignment: Alignment.topRight,
        width: width,
        height: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill),
          borderRadius:
          BorderRadius.all(Radius.circular(5))),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

}