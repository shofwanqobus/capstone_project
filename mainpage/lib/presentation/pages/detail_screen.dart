import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://infowisatabandung.com/wp-content/uploads/2019/11/img-0316-01-7ab7b3ab254c54bdd3b0deb72d7cbde3_600x400.jpeg',
            width: screenWidth,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_outline_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: backgroundPrimary2,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Floating Market Lembang',
                                  style: headingDetail,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber[400],
                                      ),
                                      Text('4.6', style: kBodyText),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.price_change,
                                        color: Colors.amber[400],
                                      ),
                                      Text('Rp. 124.999/pax', style: kBodyText),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_pin,
                                      color: Colors.amber[400]),
                                  Text('Location', style: kBodyText),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Description',
                                style: kHeading6,
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque pharetra, porta odio a. Vel aliquam, id ante suspendisse quam vestibulum aenean sed. Donec mauris mattis ullamcorper sit viverra quisque tristique sed interdum. Egestas varius molestie consequat, nullam tempus enim arcu. In adipiscing porttitor diam sed. Interdum sit cursus.",
                                style: kBodyText,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Accommodations',
                                style: kHeading6,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pushNamed(context, homePage),
                                    child: Text('Review', style: textButton2),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shadowColor: Colors.black,
                                      primary: backgroundPrimary1,
                                      minimumSize: const Size(60, 60),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, paymentScreen),
                                    child: Text('Book Now', style: textButton2),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shadowColor: Colors.black,
                                      primary: backgroundPrimary1,
                                      minimumSize: const Size(60, 60),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, tripDetail),
                                    child:
                                        Text('Trip Detail', style: textButton2),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shadowColor: Colors.black,
                                      primary: backgroundPrimary1,
                                      minimumSize: const Size(60, 60),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
