import 'package:flutter/material.dart';
import 'package:mobileluqman/news/client.dart';
import 'package:mobileluqman/news/detail_news_page.dart';
import 'package:mobileluqman/news/response_articles.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<Article> listArticle;
  bool isLoading = true;

  Future getListArticle() async {
    setState(() {
      isLoading = true;
    });

    listArticle = await Client.fetchArticle();
    // ignore: avoid_print
    print(listArticle);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getListArticle();
  }

  @override
  Widget build(BuildContext context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (listArticle.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              
            return ListView.builder(
              itemCount: listArticle.length,
              itemBuilder: (context, index) {
                final article = listArticle[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push (
                      context,
                    MaterialPageRoute(
                      builder: (context) =>
                        DetailNewsPage(article: article)
                    ),
                  );
                },
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            article.urlToImage,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  article.author,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                article.publishedAt.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.cyan,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
  }
}
