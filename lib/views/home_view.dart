import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haberuygulamasi/views/news_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:haberuygulamasi/providers/news_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Text(
                "Güncel",
                style: GoogleFonts.inter(
                    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Text(
                "Haber",
                style: GoogleFonts.inter(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black38,
                  indicatorColor: Colors.red,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        newsProvider.setCategory('general');
                        break;
                      case 1:
                        newsProvider.setCategory('sports');
                        break;
                      case 2:
                        newsProvider.setCategory('economy');
                        break;
                      case 3:
                        newsProvider.setCategory('technology');
                        break;
                    }
                  },
                  tabs: const [
                    Tab(text: "Genel"),
                    Tab(text: "Spor"),
                    Tab(text: "Ekonomi"),
                    Tab(text: "Teknoloji"),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Son",
                    style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "Dakika",
                    style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            Expanded(
              child: newsProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: newsProvider.news.length,
                      itemBuilder: (context, index) {
                        final news = newsProvider.news[index];
                        return GestureDetector(
                          onTap: () {
                            // Tıklandığında NewsDetailPage'e yönlendirme
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(
                                  title: news['name'],
                                  description: news['description'],
                                  url: news['url'] ?? '', // URL'yi gönderiyoruz
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text(news['name']),
                              subtitle: Text(news['description']),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
