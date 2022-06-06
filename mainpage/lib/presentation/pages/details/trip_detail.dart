import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class TripDetailPage extends StatelessWidget {
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
                    color: backgroundPrimary1,
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
                                  style: kHeading5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const VerticalDivider(
                                    thickness: 5,
                                    color: backgroundPrimary2,
                                    indent: 2,
                                    endIndent: 2,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('08:30', style: kSubtitle),
                                      Text(
                                        'Meet up in the hotel and \nget ready to get a trip',
                                        style: kSubtitle,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text('08:30', style: kSubtitle),
                                      Text(
                                        'Meet up in the hotel and \nget ready to get a trip',
                                        style: kSubtitle,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text('08:30', style: kSubtitle),
                                      Text(
                                        'Meet up in the hotel and \nget ready to get a trip',
                                        style: kSubtitle,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text('08:30', style: kSubtitle),
                                      Text(
                                        'Meet up in the hotel and \nget ready to get a trip',
                                        style: kSubtitle,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text('08:30', style: kSubtitle),
                                      Text(
                                        'Meet up in the hotel and \nget ready to get a trip',
                                        style: kSubtitle,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
