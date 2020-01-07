import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class SkeletonList extends StatelessWidget {
  final bool showPic;

  const SkeletonList({Key key, this.showPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // TODO: implement build
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        period: Duration(seconds: 1),
        baseColor: isDark ? Colors.grey[700] : Colors.grey[350],
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
        child: Column(
          children: List.generate(6, (index) {
            return SkeletonItemWidget();
          }),
        ),
      ),
    );
  }
}

class SkeletonItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey[200]),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        padding: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 54,
                  height: 8,
                  decoration: getSkeletonDecoration(),
                ),
                Spacer(),
                Container(
                  width: 100,
                  height: 8,
                  decoration: getSkeletonDecoration(),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 10),
                        decoration: getSkeletonDecoration(),
                      ),
//                    Container(
//                      margin: EdgeInsets.only(top: 6),
//                      width: 250,
//                      height: 10,
//                      decoration: getSkeletonDecoration(),
//                    ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        constraints: BoxConstraints.expand(height: 8),
                        height: 8,
                        decoration: getSkeletonDecoration(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        height: 8,
                        width: 220,
                        decoration: getSkeletonDecoration(),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                Spacer(
                  flex: 1,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 104,
                  height: 8,
                  decoration: getSkeletonDecoration(),
                ),
                Spacer(),
                Container(
                  width: 12,
                  height: 12,
                  decoration: getSkeletonDecoration(),
                ),
              ],
            ),
          ],
        ));
  }

  BoxDecoration getSkeletonDecoration() {
    return BoxDecoration(color: Colors.grey[350]);
  }
}
