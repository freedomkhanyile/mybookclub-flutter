import 'package:flutter/material.dart';
import 'package:we_book_club/models/bookModel.dart';
import 'package:we_book_club/screens/book/bookHistory/localWidgets/bookItem.dart';
import 'package:we_book_club/services/bookService.dart';

class BookHistoryScreen extends StatefulWidget {
  final String groupId;
  BookHistoryScreen({required this.groupId});
  @override
  _BookHistoryScreenState createState() => _BookHistoryScreenState();
}

class _BookHistoryScreenState extends State<BookHistoryScreen> {
  late Future<List<BookModel>> books;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    books = BookService().getBookHistory(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: books,
        builder:
            (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
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
                    child: BookItem(
                      book: snapshot.data![index - 1],
                      groupId: widget.groupId,
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
