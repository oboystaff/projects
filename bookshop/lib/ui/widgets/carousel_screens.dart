import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselScreens extends StatefulWidget {
  final List<Widget> list;
  CarouselScreens({Key key, this.list}) : super(key: key);

  @override
  _CarouselScreensState createState() => _CarouselScreensState();
}

class _CarouselScreensState extends State<CarouselScreens> {
  int current = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          CarouselSlider(
            // carouselController: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: widget.list.map((item) {
            //     int index = widget.list.indexOf(item);
            //     return Container(
            //       width: 10.0,
            //       height: 10.0,
            //       margin: EdgeInsets.only(
            //         bottom: 20.0,
            //         left: 5.0,
            //         right: 5.0,
            //       ),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: current == index
            //             ? Color.fromRGBO(255, 255, 255, 1.0)
            //             : Color.fromRGBO(255, 255, 255, 0.3),
            //       ),
            //     );
            //   }).toList(),
            // ),
            items: widget.list
                .map(
                  (item) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: item,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  current = index;
                });
              },
              viewportFraction: 1.0,
              height: MediaQuery.of(context).size.height,
              initialPage: 1,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
