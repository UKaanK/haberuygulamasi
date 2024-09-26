import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haberuygulamasi/views/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Güncel",
                  style: GoogleFonts.inter(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text(
                  "Haber",
                  style: GoogleFonts.inter(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          )
        ],
      ),
    );
  }
}
