import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bulleted_list/bulleted_list.dart';

class PublicationsPage extends StatelessWidget {
  const PublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = const TextStyle(fontSize: 16, height: 1.5);
    TextStyle linkStyle =
        bodyStyle.copyWith(color: const Color.fromRGBO(2, 98, 182, 1));

    double bodyWidth = 1070;
    double screenWidth = MediaQuery.of(context).size.width;
    // Makes body design look good on different screen widths
    if (screenWidth <= 750) {
      bodyWidth = 500;
    } else if (screenWidth <= 900) {
      bodyWidth = 700;
    } else if (screenWidth <= 1100) {
      bodyWidth = 850;
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              width: bodyWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      bottom: 15,
                    ),
                    child: Text(
                      'Publications',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  BulletedList(
                    listItems: getPublicationList(bodyStyle, linkStyle),
                    bulletColor: Colors.black,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<dynamic> getPublicationList(TextStyle bodyStyle, TextStyle linkStyle) {
    return [
      _displayPublication(
        'Huang, C. Derrick and Baghersad, Milad and Behara, Ravi S. and Zobel, Christopher W. “Optimal Investment in Prevention and Recovery for Mitigating Epidemic Risks” Risk Analysis , 2021 ',
        bodyStyle,
        linkStyle,
        'https://doi.org/10.1111/risa.13707',
      ),
      _displayPublication(
        'Martín, Yago and Li, Zhenlong and Ge, Yue and Huang, Xiao “Introducing Twitter Daily Estimates of Residents and Non-Residents at the County Level” Social Sciences , v.10 , 2021 ',
        bodyStyle,
        linkStyle,
        'https://doi.org/10.3390/socsci10060227',
      ),
      _displayPublication(
        'Pamukcu, D. and Zobel, C.W. and Ge, Y. “Analysis of Orange County 311 System service requests during the COVID-19 pandemic” Proceedings of the 18th International Conference on Information Systems for Crisis Response and Management , 2021',
        bodyStyle,
        linkStyle,
      )
    ];
  }
}

dynamic _displayPublication(
    String publicationText, TextStyle bodyStyle, TextStyle linkStyle,
    [String? publicationLink]) {
  return RichText(
    text: TextSpan(
      style: bodyStyle,
      children: <TextSpan>[
        TextSpan(
          text: publicationText,
          style: bodyStyle,
        ),
        if (publicationLink != null)
          TextSpan(
            text: publicationLink,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(Uri.parse(publicationLink)),
          ),
      ],
    ),
  );
}
