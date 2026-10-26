import 'package:flutter/material.dart';
import 'package:mobileluqman/news/news_page.dart';
import 'package:mobileluqman/book/book_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Luqmann.")),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Semua Yang Kamu Suka Hanya Ada Di Sini",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset("images/banner.webp", width: 120),
                ],
              ),
              const SizedBox(height: 15),

              Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 0;
                          });
                        },
                        icon: const Icon(Icons.article),
                        label: const Text("News"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedMenu == 0
                              ? Colors.blue
                              : Colors.grey,
                          foregroundColor: _selectedMenu == 0
                              ? Colors.white
                              : Colors.black,
                          elevation: _selectedMenu == 0 ? 2 : 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 1;
                          });
                        },
                        icon: const Icon(Icons.book),
                        label: const Text("Komik"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedMenu == 1
                              ? Colors.blue
                              : Colors.grey,
                          foregroundColor: _selectedMenu == 1
                              ? Colors.white
                              : Colors.black,
                          elevation: _selectedMenu == 1 ? 2 : 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                Expanded(
                  child: _selectedMenu == 0 ? const NewsPage() : const BookPage(),
                )
            ],
          ),
        ),
      );
  }
}
