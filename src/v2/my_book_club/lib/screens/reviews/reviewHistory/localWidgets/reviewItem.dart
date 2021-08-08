import 'package:flutter/material.dart';
import 'package:my_book_club/models/reviewModel.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/services/userService.dart';
import 'package:my_book_club/widgets/shadowContainer.dart';

class ReviewItem extends StatefulWidget {
  final ReviewModel review;

  ReviewItem({required this.review});

  @override
  _ReviewItemState createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  late UserModel user = UserModel();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    user = await UserService().getUser(widget.review.userId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (user.uid != null) ? user.fullName! : "loading..",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          (widget.review.rating! > 5)
              ? Text(
                  "Rating " + widget.review.rating.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  "Rating " + widget.review.rating.toString(),
                  style: TextStyle(
                      fontSize: 20,
                    color: Colors.red[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
          (widget.review.review != null)
              ? Text(
                  widget.review.review!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                )
              : Text(""),
        ],
      ),
    );
  }
}
