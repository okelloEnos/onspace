import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onspace/features/profile/ui/screens/profile_screens.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/resources/common_widget/custom_container.dart';

class TagsCard extends StatelessWidget {
  const TagsCard(
      {required this.isRecent, required this.userProfile, super.key,});

  final bool isRecent;
  final Profile userProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<ProfileScreens>(
          builder: (context) => ProfileScreens(
            profile: userProfile,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: userProfile.avatar == null
                  ? Image.asset(
                      'assets/images/profile_picture.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: userProfile.avatar ?? '',
                      imageBuilder: (
                        context,
                        imageProvider,
                      ) =>
                          Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                        height: 50,
                        width: 50,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (
                        context,
                        url,
                        error,
                      ) =>
                          Image.asset(
                        'assets/images/profile_picture.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${userProfile.name}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                        fontFamily: 'Spline',
                        fontWeight: FontWeight.bold,),),
                Text(userProfile.location?.street ?? 'No address',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                        fontFamily: 'Spline',
                        fontWeight: FontWeight.normal,),),
              ],
            ),
            const Spacer(),
            if (isRecent) CustomContainer(
                    child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.battery_3_bar_outlined,
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                  ),) else Text('12min updated',
                    style: TextStyle(
                        color: theme.colorScheme.tertiary,
                        fontSize: 14,
                        fontFamily: 'Spline',
                        fontWeight: FontWeight.normal,),),
            const SizedBox(
              width: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Transform.rotate(
                  angle: 1,
                  child: Icon(Icons.navigation_outlined,
                      color: theme.colorScheme.secondary,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
