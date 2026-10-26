import 'package:flutter/material.dart';
import 'package:mobileluqman/book/detail_page.dart';
import 'package:mobileluqman/book/book.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SubTitle
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Daftar Manhwa",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),

        //ListBook
        Expanded(
          child: ListView.builder(
            itemCount: listBook.length,
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final book = listBook[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(book: book),
                    ),
                  );
                },

                child: Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Image.asset(book.image, width: 60),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book.categoryBook,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
