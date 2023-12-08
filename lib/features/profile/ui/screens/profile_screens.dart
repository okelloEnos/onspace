import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onspace/features/profile/cubit/tag_location_history_cubit.dart';
import 'package:onspace/features/tag_location/data/model/profile.dart';
import 'package:onspace/resources/common_widget/circular_button_widget.dart';
import 'package:onspace/resources/common_widget/curved_card.dart';
import 'package:onspace/resources/common_widget/custom_container.dart';
import 'package:onspace/resources/common_widget/error_card_widget.dart';

import 'package:onspace/resources/common_widget/loading_widget.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({required this.profile, super.key});

  final Profile profile;

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  late Profile _profile;

  @override
  void initState() {
    _profile = widget.profile;
    context
        .read<TagLocationHistoryCubit>()
        .fetchTagsLocationHistory(userId: '${_profile.userId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: CircularIconButton(
                          containerSize: 45,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${_profile.name}',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Spline',
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircularIconButton(
                        containerColor: theme.colorScheme.tertiary,
                        child: Transform.rotate(
                          angle: 1,
                          child: Icon(
                            Icons.navigation_outlined,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _profile.avatar == null
                            ? Image.asset(
                                'assets/images/profile_picture.png',
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: _profile.avatar ?? '',
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
                                  height: 150,
                                  width: 150,
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
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.secondary,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.info_outline,
                                color: theme.colorScheme.tertiary,
                                size: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              elevation: 0,
                              color: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 15,
                                ),
                                child: Text(
                                  'id ${_profile.userId}',
                                  style: TextStyle(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 14,
                                    fontFamily: 'Spline',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CustomContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.chat_outlined,
                                color: theme.colorScheme.tertiary,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: CurvedCard(
                      color: theme.colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Now is',
                                  style: TextStyle(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 22,
                                    fontFamily: 'Spline',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: theme.colorScheme.tertiary,
                                  size: 24,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                bottom: 4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_profile.location?.street}',
                                    style: TextStyle(
                                      color: theme.colorScheme.tertiary,
                                      fontSize: 16,
                                      fontFamily: 'Spline',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'Since '
                                    "${DateTime.tryParse("${_profile.location?.
                                    updatedOn}")?.hour}"
                                    ":${NumberFormat("00").format(
                                      DateTime.tryParse(
                                              "${_profile.
                                              location?.updatedOn}",)
                                          ?.minute,
                                    )}",
                                    style: TextStyle(
                                      color: theme.colorScheme.tertiary,
                                      fontSize: 16,
                                      fontFamily: 'Spline',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'School',
                                  style: TextStyle(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 14,
                                    fontFamily: 'Spline',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '9min updated',
                                  style: TextStyle(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 14,
                                    fontFamily: 'Spline',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CurvedCard(
                      color: theme.colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Last updates',
                                  style: TextStyle(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 22,
                                    fontFamily: 'Spline',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomContainer(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: theme.colorScheme.tertiary,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: BlocBuilder<TagLocationHistoryCubit,
                                      TagLocationHistoryState>(
                                  builder: (context, state) {
                                if (state is TagsLocationHistoryLoading) {
                                  return const LoadingWidget(
                                    loadingText:
                                        'Loading past location history...',
                                  );
                                } else if (state is TagsLocationHistoryLoaded) {
                                  final locationHistory =
                                      state.tagsLocationHistory;
                                  return ListView.builder(
                                      itemCount: locationHistory.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        final history = locationHistory[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${history.street}',
                                                style: TextStyle(
                                                    color: theme
                                                        .colorScheme.tertiary,
                                                    fontSize: 16,
                                                    fontFamily: 'Spline',
                                                    fontWeight:
                                                        FontWeight.normal,),
                                              ),
                                              Text(
                                                'Since '
                                                "${DateTime.tryParse("${history
                                                    .updatedOn}")?.hour}"
                                                ":${NumberFormat("00")
                                                    .format(DateTime
                                                    .tryParse("${history
                                                    .updatedOn}")?.minute,)}",
                                                style: TextStyle(
                                                    color: theme
                                                        .colorScheme.tertiary,
                                                    fontSize: 16,
                                                    fontFamily: 'Spline',
                                                    fontWeight:
                                                        FontWeight.bold,),
                                              ),
                                            ],
                                          ),
                                        );
                                      },);
                                } else if (state is TagsLocationHistoryLoaded) {
                                  return ErrorCardWidget(
                                      errorText: 'An error occurred while '
                                          'loading location history',
                                      retry: () => context
                                          .read<TagLocationHistoryCubit>()
                                          .fetchTagsLocationHistory(
                                              userId: '${_profile.userId}',),);
                                } else {
                                  return Container();
                                }
                              },),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10,),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 4, right: 4,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularIconButton(
                          containerColor: theme.colorScheme.tertiary,
                          child: Icon(
                            Icons.call_outlined,
                            color: theme.colorScheme.secondary,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            elevation: 0,
                            color: theme.colorScheme.tertiary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40,),
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                    color: theme.colorScheme.secondary,
                                    fontSize: 16,
                                    fontFamily: 'Spline',
                                    fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ),
                        ),
                        CircularIconButton(
                          containerColor: theme.colorScheme.tertiary,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.battery_3_bar_outlined,
                              color: theme.colorScheme.secondary,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
