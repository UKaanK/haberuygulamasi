import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style:
                  GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.red,
            dividerColor: Colors.transparent,
            controller: tabController,
            tabs: const [
              Tab(text: "Tümü"),
              Tab(text: "Spor"),
              Tab(text: "Siyasi"),
              Tab(text: "Ekonomi"),
              Tab(text: "Siyasi"),
              Tab(text: "Teknoloji"),
            ]),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          // Expanded yerine SizedBox veya Container kullanabilirsin.
          width: MediaQuery.of(context)
              .size
              .width, // Ekran genişliğine göre ayarla
          child: TabBarView(
            controller: tabController,
            children: const [
              Text("Tümü"),
              Text("Spor"),
              Text("Siyasi"),
              Text("Ekonomi"),
              Text("Siyasi"),
            ],
          ),
        ),
      ),
    );
  }
}
