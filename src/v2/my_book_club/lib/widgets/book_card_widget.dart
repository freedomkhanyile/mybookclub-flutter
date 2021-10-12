import 'package:flutter/material.dart';
import 'package:we_book_club/models/bookModel.dart';
import 'package:we_book_club/utils/ourTheme.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({
    Key? key,
    required this.book,
    required this.bookDue,
    required this.press,
    required this.size,
  }) : super(key: key);

  final Size size;
  final String bookDue;
  final GestureTapCallback press;
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                // TODO Move colors to constants.
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "You are currently readinging.",
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor("#94989B"),
                      ),
                    ),
                  ),
                  Text(
                    (book.name != null) ? book.name! : 'loading..',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: HexColor("#94989B"),
                        ),
                        children: [
                          TextSpan(
                              text: (book.author != null)
                                  ? book.author!
                                  : 'loading..'),
                        ]),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: HexColor("#94989B"),
                        ),
                        children: [
                          TextSpan(text: "Due in: \n"),
                          TextSpan(
                            text: bookDue,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            // TODO Retrieve from FireStore Storage.
            child: Image.asset(
              "assets/images/book_cover_placeholder.png",
              width: size.width * .3,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: RaisedButton(
                onPressed: press,
                // TODO Move colors to constants.dart file
                color: HexColor("#71A748"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(29.0),
                    topLeft: Radius.circular(29.0),
                  ),
                ),
                child: Text(
                  "Finished",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
