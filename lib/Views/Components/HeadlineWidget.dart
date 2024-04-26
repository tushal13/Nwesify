import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nwesify/modal/NewsModal.dart';
import 'package:provider/provider.dart';

import '../../controller/ThemeController.dart';

class HeadlineTile extends StatelessWidget {
  final NewsModal headline;
  final VoidCallback callBack;
  final VoidCallback ontap;

  const HeadlineTile(
      {required this.headline, required this.callBack, required this.ontap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDark = Provider.of<ThemeController>(context, listen: true).isDark;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              headline.urlToImage != null
                  ? Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 100,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/logo.png',
                            placeholderCacheHeight: 200,
                            placeholderFit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/logo.png');
                            },
                            image: headline.urlToImage ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(width: 10),
              Expanded(
                flex: 8,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        headline.title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.29,
                                child: Text(
                                  headline.source.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.sanchez(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 14),
                            ],
                          ),
                          GestureDetector(
                            onTap: callBack,
                            child: Text('Read more',
                                style: GoogleFonts.sanchez(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
        decoration: BoxDecoration(
            color: isDark ? Color(0xff181818) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black : Colors.grey.shade300,
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 3),
              )
            ]),
      ),
    );
  }
}
