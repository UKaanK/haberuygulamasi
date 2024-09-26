import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final String image;

  const NewsDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.url,
    required this.image,
  }) : super(key: key);

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red, // Uygun bir arka plan rengi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Kenar yuvarlama
                child: Image.network(
                  image,
                  fit: BoxFit.cover, // Resmi kutunun tamamını doldur
                  height: 200, // Resmin yüksekliği
                  width: double.infinity, // Genişliği doldur
                ),
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Başlık rengi
                ),
              ),
              SizedBox(height: 12),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  height: 1.5, // Satır yüksekliği
                  color: Colors.grey[700], // Açık gri renk
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  onPressed: () => _launchURL(url),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Düğme köşe yuvarlama
                    ),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Haber Detayına Git"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
