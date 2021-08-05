import 'package:flutter/material.dart';
import 'package:my_book_club/models/reviewModel.dart';
import 'package:my_book_club/screens/reviews/reviewHistory/localWidgets/reviewItem.dart';
import 'package:my_book_club/services/bookService.dart';

class ReviewHistoryScreen extends StatefulWidget {
  final String groupId;
  final String bookId;

  ReviewHistoryScreen({required this.groupId, required this.bookId});

  @override
  _ReviewHistoryScreenState createState() => _ReviewHistoryScreenState();
}

class _ReviewHistoryScreenState extends State<ReviewHistoryScreen> {
  late Future<List<ReviewModel>> reviews;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reviews = BookService().getReviewHistory(widget.groupId, widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: reviews,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReviewModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        BackButton(),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ReviewItem(
                      review: snapshot.data![index - 1],
                    ),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
