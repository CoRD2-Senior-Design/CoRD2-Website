import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import './full_abstract_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String imgSrc = 'assets/images/';
    TextStyle linkStyle =
        const TextStyle(color: Color.fromRGBO(2, 98, 182, 1), fontSize: 16);
    TextStyle bodyStyle =
        const TextStyle(fontSize: 16, height: 1.5, letterSpacing: 1);
    TextStyle detailStyle =
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w900);

    bool desktopLayout = MediaQuery.of(context).size.width >= 1080;
    bool mobileLayout = MediaQuery.of(context).size.width < 600;
    bool tabletLayout = !desktopLayout && !mobileLayout;

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.fromLTRB(50, 150, 50, 100),
              width: 900,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    '${imgSrc}partnerList.webp',
                    height: 137,
                  ),
                  if (mobileLayout)
                    Column(
                      children: [
                        _displayNFSLogo(imgSrc),
                        _displayArticleTitle(linkStyle),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10))
                      ],
                    ),
                  if (!mobileLayout)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _displayNFSLogo(imgSrc),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                _displayArticleTitle(linkStyle),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 60)),
                                if (desktopLayout)
                                  _displayArticleAbstract(
                                      linkStyle, bodyStyle, context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (tabletLayout || mobileLayout)
                    _displayArticleAbstract(linkStyle, bodyStyle, context),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Time Period: 09/01/2020 – 08/31/2023',
                      style: detailStyle,
                    ),
                  ),
                  Text(
                    'Award #: 1952792',
                    style: detailStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns a widget for the article title
  Tooltip _displayArticleTitle(TextStyle linkStyle) {
    String titleLink =
        'https://www.nsf.gov/awardsearch/showAward?AWD_ID=1952792&HistoricalAwards=false';
    return Tooltip(
      message: titleLink,
      verticalOffset: 50,
      child: AutoSizeText.rich(
        TextSpan(
          text:
              'Leveraging Smart Technologies and Managing Community Resilience through Networked Communities and Cross-Sector Partnerships',
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse(titleLink)),
        ),
        style: linkStyle.copyWith(
          fontSize: 20,
          letterSpacing: 1,
        ),
        maxLines: 6,
        maxFontSize: 23,
      ),
    );
  }

  // Returns an image of the NFS logo as a Widget
  Padding _displayNFSLogo(String imgSrc) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(
        '${imgSrc}nsfLogo.webp',
        height: 110,
      ),
    );
  }

  // Returns the article abstract as a widget
  Column _displayArticleAbstract(
      TextStyle linkStyle, TextStyle bodyStyle, BuildContext context) {
    // Sends user to abstract page
    void goToAbstractRoute() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FullAbstractRoute()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tooltip(
          message: 'Full Abstract',
          child: RichText(
            text: TextSpan(
              text: 'Abstract',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => goToAbstractRoute(),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 8),
          child: Text(
            'June 30, 2021',
            style: TextStyle(fontSize: 13),
          ),
        ),
        SizedBox(
          child: RichText(
            text: TextSpan(
              style: bodyStyle,
              children: <TextSpan>[
                const TextSpan(
                  text:
                      "This Smart & Connected Communities grant will leverage existing community partnerships and resources and evaluate the information technology applications aided by artificial intelligence in enhancing community resilience management. The east central Florida region (including 8 counties and 78 member towns/cities) is selected … ",
                ),
                TextSpan(
                  text: 'Read more',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => goToAbstractRoute(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
