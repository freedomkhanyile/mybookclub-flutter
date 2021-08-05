import 'package:flutter/material.dart';
import 'package:my_book_club/models/reviewModel.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/services/userService.dart';

class ReviewItem extends StatefulWidget {
  final ReviewModel review;

  ReviewItem({required this.review});

  @override
  _ReviewItemState createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  late UserModel user;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    user = await UserService().getUser(widget.review.userId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            (user != null) ? user.fullName! : "loading..",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Rating " + widget.review.rating.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          (widget.review.review != null)
              ? Text(
                  widget.review.review!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                )
              : Text(""),
        ],
      ),
    );
  }
}
