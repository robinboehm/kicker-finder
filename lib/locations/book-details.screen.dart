import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'book.service.dart';

class BookDetailArguments {
  final String isbn;

  BookDetailArguments(this.isbn);
}

class BookDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BookDetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder<Book>(
              future: fetchBook(http.Client(), args.isbn),
              builder: (context, snapshot) {
                final Book book = snapshot.data;
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(book.title),
                        Text(book.subtitle),
                        Text(book.abstract),
                        Text(book.isbn),
                        Text('Pages:${book.numPages}'),
                        Text(book.author),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return CircularProgressIndicator();
              },
            ),
          )),
    );
  }
}
