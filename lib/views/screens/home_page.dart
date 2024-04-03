import 'package:country_icons/country_icons.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwesify/controller/news_controller.dart';
import 'package:nwesify/views/screens/headline_page.dart';
import 'package:nwesify/views/screens/search_page.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDark = Provider.of<ThemeController>(context, listen: true).isDark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: GestureDetector(
              onTap: () {
                print('oommm');
                Provider.of<ThemeController>(context, listen: false)
                    .changeTheme();
              },
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            actions: [
              SizedBox(
                width: 50,
                child: Consumer<NewsController>(builder: (context, nw, child) {
                  return IconButton(
                    onPressed: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                              backgroundColor:
                                  isDark ? Color(0xff1c1d2a) : Colors.white,
                              bottomSheetHeight: size.height * 0.6,
                              flagSize: 25,
                              searchTextStyle: GoogleFonts.poppins(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                              inputDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: 'Search Your Country',
                                  hintStyle: GoogleFonts.poppins(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.8)
                                        : Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  )),
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  color: isDark ? Colors.white : Colors.black)),
                          onSelect: (Country country) => setState(() {
                                nw.country = country.countryCode;
                                nw.fatcheadline();
                              }));
                    },
                    icon: CountryIcons.getSvgFlag(nw.country),
                  );
                }),
              )
            ],
            title: Container(
              height: 40,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) {
                  Provider.of<NewsController>(context, listen: false)
                      .searchtext(value);
                  Provider.of<NewsController>(context, listen: false)
                      .searchnews();
                },
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.grey.withOpacity(0.5),
                  hintText: 'Search for News',
                  hintStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            pinned: false,
            floating: true,
            bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text(
                    'For You',
                    style: GoogleFonts.kodchasan(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Search',
                    style: GoogleFonts.kodchasan(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
              child: TabBarView(
            controller: _tabController,
            children: [
              HeadlinePage(),
              SearchPage(),
            ],
          ))
        ],
      ),
    );
  }
}
