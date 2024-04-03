import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwesify/modal/news_modal.dart';

class WebviewPage extends StatelessWidget {
  final NewsModal news;
  const WebviewPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          news.source.name ?? '',
          style: GoogleFonts.sanchez(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(news.url ?? ''),
        ),
      ),
    );
  }
}
