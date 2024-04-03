import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwesify/controller/theme_controller.dart';
import 'package:nwesify/views/screens/webview_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../modal/news_modal.dart';

class DatailPage extends StatelessWidget {
  final NewsModal news;

  const DatailPage({required this.news, Key? key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context, listen: true).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text(news.source.name ?? ''),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/img.png',
                placeholderCacheHeight: 200,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/img.png');
                },
                placeholderFit: BoxFit.cover,
                image: news.urlToImage ?? '',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: news.title ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  wordSpacing: 1,
                  letterSpacing: 1,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '\nby\t\t',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  wordSpacing: 1,
                  letterSpacing: 1,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                  text: news.author ?? '',
                  style: GoogleFonts.sanchez(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyanAccent.withOpacity(0.8),
                  ))
            ])),
            Text(
              news.description ?? '',
              style: GoogleFonts.sanchez(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            Text(
              news.content ?? '',
              style: GoogleFonts.sanchez(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Source :\t',
                    style: GoogleFonts.sanchez(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    )),
                TextSpan(
                    text: news.source.name ?? '',
                    style: GoogleFonts.sanchez(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.withOpacity(0.8),
                    ))
              ]),
            ),
            Text(
              'Published At : ' +
                  news.publishedAt!.day.toString() +
                  '-' +
                  news.publishedAt!.month.toString() +
                  '-' +
                  news.publishedAt!.year.toString(),
              style: GoogleFonts.sanchez(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(PageTransition(
                  child: WebviewPage(
                    news: news,
                  ),
                  type: PageTransitionType.fade,
                ));
              },
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Read More',
                      style: GoogleFonts.sanchez(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff3f66c2),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
