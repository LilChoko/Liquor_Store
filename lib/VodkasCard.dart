import 'package:flutter/material.dart';
import 'colors.dart';
import 'drink.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class Vodkascard extends StatelessWidget {
  Drink drink;
  double pageOffset;
  double animation;
  double animate = 0;
  double rotate = 0;
  double columnAnimation = 0;
  int index;

  Vodkascard(this.drink, this.pageOffset, this.index, this.animation);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .62;
    double count = 0;
    double page;
    rotate = index - pageOffset;
    for (page = pageOffset; page > 1;) {
      page--;
      count++;
    }
    animation = Curves.easeOutBack.transform(page);
    animate = 100 * (count + animation);
    columnAnimation = 50 * (count + animation);
    for (int i = 0; i < index; i++) {
      animate -= 100;
      columnAnimation -= 50;
    }

    return Container(
      child: Stack(
        clipBehavior: Clip.none, // Reemplaza overflow: Overflow.visible
        children: <Widget>[
          buildTopText2(),
          buildBackgroundImage2(cardWidth, cardHeight, size),
          buildAboveCard2(cardWidth, cardHeight, size),
          buildCupImage2(size),
        ],
      ),
    );
  }

  Widget buildTopText2() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Text(
            drink.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 46.5,
                color: drink.lightColor),
          ),
          Text(
            drink.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 46.5,
                color: drink.darkColor),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage2(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            drink.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildAboveCard2(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            //color: drink.darkColor.withOpacity(.50),
            borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columnAnimation, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Vodkas',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                drink.description,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 0,
                  ),
                  Image.asset(
                    'assets/18.png',
                    width: 65.0,
                    height: 65.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: tRed, borderRadius: BorderRadius.circular(60)),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '\$',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '899',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCupImage2(Size size) {
    return Positioned(
      bottom: 35,
      right: -size.width * .27 / 2 + 30,
      child: Transform.rotate(
        angle: -math.pi / 14 * rotate,
        child: Image.asset(
          drink.cupImage,
          height: size.height * .55,
          width: size.width * .45,
        ),
      ),
    );
  }
}
