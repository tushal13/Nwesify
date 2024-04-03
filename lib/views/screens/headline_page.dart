import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwesify/controller/news_controller.dart';
import 'package:nwesify/utility/category_list.dart';
import 'package:nwesify/views/screens/detail_page.dart';
import 'package:nwesify/views/screens/webview_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../components/headline_widget.dart';

class HeadlinePage extends StatelessWidget {
  const HeadlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<NewsController>(builder: (context, nw, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            nw.changeCategory(
                                newsCategories[index].toLowerCase());
                            nw.fatcheadline();
                          },
                          child: Text(newsCategories[index].toLowerCase(),
                              style: GoogleFonts.robotoMono(
                                  fontSize: 10,
                                  color: nw.category ==
                                          newsCategories[index].toLowerCase()
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: nw.category ==
                                          newsCategories[index].toLowerCase()
                                      ? FontWeight.w600
                                      : FontWeight.w400)),
                        ),
                        decoration: BoxDecoration(
                          color:
                              nw.category == newsCategories[index].toLowerCase()
                                  ? Color(0xff3f66c2)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: nw.category !=
                                  newsCategories[index].toLowerCase()
                              ? Border.all(color: Colors.grey, width: 1)
                              : Border.all(color: Colors.transparent, width: 0),
                        ));
                  }),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 3),
                scrollPhysics: BouncingScrollPhysics(),
              ),
              items: nw.headline.map((news) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageTransition(
                        child: DatailPage(news: news),
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/img.png',
                      placeholderCacheHeight: 200,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/img.png');
                      },
                      placeholderFit: BoxFit.fill,
                      image: news.urlToImage ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nw.headline.length,
              itemBuilder: (context, index) {
                return HeadlineTile(
                  headline: nw.headline[index],
                  callBack: () {
                    Navigator.of(context).push(PageTransition(
                        child: DatailPage(news: nw.headline[index]),
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter));
                  },
                  ontap: () {
                    Navigator.of(context).push(PageTransition(
                      child: WebviewPage(
                        news: nw.headline[index],
                      ),
                      type: PageTransitionType.fade,
                    ));
                  },
                );
              },
            ),
          ],
        ),
      );
    }));
  }
}
