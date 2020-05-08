import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music/models/banners.dart';

class BannerView extends StatelessWidget {
  final List<Banners> dataList;

  BannerView({Key key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.buildViewPage(context, dataList);
  }

  Widget buildViewPage(BuildContext context, List<Banners> bannerList) {
    var list = new List<NetworkImage>();
    if(bannerList.length>0){
      bannerList.forEach((banner) => list.add(NetworkImage(banner.pic)));
    }

    if(list.length>0){
      return Swiper(
          itemCount: bannerList.length,
          scrollDirection: Axis.horizontal,
          autoplay: true,
          itemBuilder: (c, i) {
            return Container(
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil.getInstance().setWidth(48),
                  ScreenUtil.getInstance().setWidth(10),
                  ScreenUtil.getInstance().setWidth(48),
                  ScreenUtil.getInstance().setWidth(10)),
              //卡片大小
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(image: list[i], fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            );
          },
          pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
            builder: DotSwiperPaginationBuilder(
              // 指示器构建
              space: 4,
              // 点之间的间隔
              size: 8,
              // 没选中时的大小
              activeSize: 8,
              // 选中时的大小
              color: Colors.white,
              // 没选中时的颜色
              activeColor: Colors.red, // 没选中时的颜色
            ),
          ));
    }else{
      return Text("");
    }

  }
}
