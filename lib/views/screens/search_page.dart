import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwesify/controller/news_controller.dart';
import 'package:nwesify/views/screens/detail_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context, listen: true).isDark;
    return Scaffold(
        body: Consumer<NewsController>(builder: (context, nw, child) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: nw.search.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: DatailPage(news: nw.search[index]),
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(5),
                  child: Column(
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
                          placeholderFit: BoxFit.fill,
                          image: nw.search[index].urlToImage ?? '',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: nw.search[index].title ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            wordSpacing: 1,
                            letterSpacing: 1,
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                            text: '\n${nw.search[index].author}' ?? '',
                            style: GoogleFonts.sanchez(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.cyanAccent.withOpacity(0.8),
                            ))
                      ])),
                      Text(
                        nw.search[index].description ?? '',
                        style: GoogleFonts.sanchez(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              nw.search[index].publishedAt!.day.toString() +
                                  '-' +
                                  nw.search[index].publishedAt!.month
                                      .toString() +
                                  '-' +
                                  nw.search[index].publishedAt!.year.toString(),
                              style: GoogleFonts.sanchez(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              nw.search[index].source.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.sanchez(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }));
  }
}
