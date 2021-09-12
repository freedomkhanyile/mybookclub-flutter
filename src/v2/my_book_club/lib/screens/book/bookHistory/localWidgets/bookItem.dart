import 'package:flutter/material.dart';
import 'package:my_book_club/models/bookModel.dart';
import 'package:my_book_club/screens/reviews/reviewHistory/reviewHistory.dart';
import 'package:my_book_club/widgets/shadowContainer.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  final String groupId;

  BookItem({required this.book, required this.groupId});

  void _goToReviewHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewHistoryScreen(
          groupId: groupId,
          bookId: book.id!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            book.name!,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            book.author!,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: RaisedButton(
              child: Text(
                "Reviews",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _goToReviewHistory(context),
            ),
          )
        ],
      ),
    );
  }
}
