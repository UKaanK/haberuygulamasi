import 'package:flutter/material.dart';
import 'package:haberuygulamasi/models/news_model.dart';
import 'package:haberuygulamasi/services/news_services.dart';
import 'package:haberuygulamasi/views/news_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:haberuygulamasi/providers/news_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // fetchNews() çağrısını WidgetsBinding kullanarak geciktiriyoruz
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchNews();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Kullanıcı sayfanın sonuna ulaştığında daha fazla haber yükle
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchNews(); // Burada fetchNews metodunu çağırın
    }
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
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
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
                    // Seçilen kategoriye göre haberleri getir
                    switch (index) {
                      case 0:
                        newsProvider.setCategory('general');
                        break;
                      case 1:
                        newsProvider.setCategory('sport');
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
          children: [
            Expanded(
              child: newsProvider.isLoading && newsProvider.news.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : newsProvider.error != null
                      ? Center(child: Text(newsProvider.error!))
                      : ListView.builder(
                          controller:
                              _scrollController, // ScrollController'ı ekleyin
                          itemCount: newsProvider.news.length +
                              1, // Son eleman için bir boş alan ekleyin
                          itemBuilder: (context, index) {
                            if (index >= newsProvider.news.length) {
                              // Yükleme göstergesi
                              return newsProvider.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : SizedBox.shrink(); // Hiçbir şey gösterme
                            }

                            final news = newsProvider.news[index];
                            return GestureDetector(
                              onTap: () {
                                // Haber detayına git
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailPage(
                                      title: news.name,
                                      description: news.description,
                                      url: news.url,
                                      image: news.image,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.transparent,
                                child: ListTile(
                                  title: Text(news.name),
                                  subtitle: Text(news.description),
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
