import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities/personalization.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: backgroundColor2,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: backgroundColor2,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline,
              color: backgroundColor2,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              height: 24,
              width: 24,
              // color: backgroundColor2,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/band.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Title of the Post',
                  style: headline1,
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/lp_image.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Title of vendor',
                      style: headline1detail,
                    ),
                  ),
                  const Spacer(),
                  MaterialButton(
                    color: backgroundColor2.withOpacity(0.7),
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    onPressed: () {},
                    child: Text(
                      'Subscribe',
                      style: headline2Profile,
                    ),
                  )
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: backgroundColor2.withOpacity(0.7),
                ),
                title: Text(
                  'Date of event',
                  style: headline1detail,
                ),
                subtitle: Text(
                  '14:00 - 18:00 GMT + 03:00',
                  style: headline2Detail,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: backgroundColor2.withOpacity(0.7),
                ),
                title: Text(
                  'Location Venue',
                  style: headline1detail,
                ),
                subtitle: Text(
                  'Lorem ipsum makaveli',
                  style: headline2Detail,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.receipt,
                  color: backgroundColor2.withOpacity(0.7),
                ),
                title: Text(
                  'Ksh. 141.95',
                  style: headline1detail,
                ),
                subtitle: Text(
                  'on Eventend',
                  style: headline2Detail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'About',
                  style: headline1,
                ),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consenter advising elite, sed do elusion '
                'tempore incident ut laborer et dolores magna aliquant. Ut enid ad minim venial, '
                'quia nostrum exercitation ullages labors nisi ut aliquot ex ea commode consequent.',
                style: commonTextMain,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Location',
                  style: headline1,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Kshs. 142.65',
              style: headline1detail,
            ),
            MaterialButton(
              onPressed: () {},
              color: backgroundColor2,
              child: Text('Buy Ticket', style: headline1Profile),
            ),
          ],
        ),
      ),
    );
  }
}
