import 'package:flutter/material.dart';
import 'package:mobileluqman/book/book.dart';
import 'dart:ui';

class DetailPage extends StatelessWidget {
  final Book book;
  const DetailPage ({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: ListView(
        children: [
          //Gambar
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height /4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Center(
                child: Image.asset(
                  book.image,
                  width: 120,
                ),
              ),
            ),
          ),

          //Judul
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                book.name,
                style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          //InfoBuku
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bookInfo(book.rate.toString(), "Rating"),
              bookInfo(book.page.toString(), "Page"),
              bookInfo(book.languange, "Languange")
            ],
          ),

          //Deskripsi
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 2),
            ),
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: bookDesc(book.description),
          )
        ],
      ),
    );
  }
}

  Widget bookInfo(String value, String info) {
    return Column (
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          info,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget bookDesc(String desc) {
    return Column (
      children: [
        Text(
          desc,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }