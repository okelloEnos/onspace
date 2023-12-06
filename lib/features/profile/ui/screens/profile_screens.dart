import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onspace/features/profile/cubit/tag_location_history_cubit.dart';
import 'package:onspace/features/tag_location/cubit/tag_location_cubit.dart';

class ProfileScreens extends StatefulWidget {
  final String? userId;
  const ProfileScreens({super.key, required this.userId});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  @override
  void initState() {
    context.read<TagLocationHistoryCubit>().fetchTagsLocationHistory(userId: widget.userId!);
    super.initState();
  }

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
          BlocBuilder<TagLocationHistoryCubit, TagLocationHistoryState>(
              builder: (context, state){
            if(state is TagsLocationHistoryLoading){
              return const CircularProgressIndicator();
            }
            else if(state is TagsLocationHistoryLoaded){
              return Text("data");
            }
            else if(state is TagsLocationHistoryLoaded){
              return Text("Error");
            }
            else{
              return Container();
            }
          })
        ],
      ),
    );
  }
}
