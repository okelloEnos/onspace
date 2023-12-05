import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? _remoteImage;
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),
            child: _remoteImage == null
                ? const CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage(
                  'assets/images/image_placeholder.png',),
            )
                : CachedNetworkImage(
              imageUrl:
              _remoteImage ?? '',
              imageBuilder: (context,
                  imageProvider,) =>
                  Container(
                    decoration:
                    BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(
                          10,),
                      image:
                      DecorationImage(
                        image:
                        imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 60,
                    width: 60,
                  ),
              placeholder:
                  (context, url) =>
                  const CircularProgressIndicator(),
              errorWidget: (context,
                  url, error,) =>
                  const CircleAvatar(
                    radius: 10,
                    backgroundImage:
                    AssetImage(
                        'assets/images/image_placeholder.png',),
                  ),
            ),
          ),
          const Text('Profile'),
        ],
      ),
    );
  }
}
