
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final MealComplexity complexity;
  final Affordability affordability;
  final int duration;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.complexity,
    @required this.affordability,
    @required this.duration,
  });

  String get complexityText {
    switch (complexity) {
      case MealComplexity.Simple:
        {
          return 'Simple';
        }
        break;
      case MealComplexity.Hard:
        {
          return 'Hard';
        }
        break;
      case MealComplexity.Challenging:
        {
          return 'Challenging';
        }
        break;
    }
    return '';
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Pricey:
        {
          return 'Pricey';
        }
        break;
      case Affordability.Luxurious:
        {
          return 'Expensive';
        }
        break;
      case Affordability.Affordable:
        {
          return 'Affordable';
        }
        break;
    }
    return '';
  }

  void didSelectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailsScreen.routeName,arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => didSelectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  generateRow('$duration min', Icons.schedule),
                  generateRow('$complexityText', Icons.work),
                  generateRow('$affordabilityText', Icons.attach_money),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget generateRow(String text, IconData icon) {
  return Row(
    children: <Widget>[
      Icon(icon),
      SizedBox(
        width: 6,
      ),
      Text(text)
    ],
  );
}
