import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  RoundImage({Key key, this.width, this.url, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          height: height,
          child: CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            placeholder: (context, url) => Container(child: CircularProgressIndicator(),width: width/2,),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ));
  }
}
