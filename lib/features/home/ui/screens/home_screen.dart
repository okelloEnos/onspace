import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onspace/features/chat/ui/chat_screen.dart';
import 'package:onspace/features/driving/driving_screen.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:onspace/features/home/bloc/bottom_navigation_bar_cubit/bottom_navigation_history_cubit.dart';
import 'package:onspace/features/safety/safety_screen.dart';
import 'package:onspace/features/tag_location/ui/screens/tags_location_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        final previousNavOptions =
            context.read<BottomNavigationHistoryCubit>().state;
        if (previousNavOptions.isEmpty) {
          final actionSelected = await showAnimatedDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                  'Do you wish to exit the app?',
                  style: TextStyle(
                    color: theme.colorScheme.tertiary,
                    fontSize: 16,
                    fontFamily: 'Spline',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context, true),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 14,
                                  fontFamily: 'Spline',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context, false),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 14,
                                  fontFamily: 'Spline',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            animationType: DialogTransitionType.slideFromTop,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );

          return actionSelected ?? false;
        } else {
          previousNavOptions.removeAt(previousNavOptions.length - 1);
          if (previousNavOptions.isEmpty) {
            context.read<BottomNavigationBarCubit>().updateCurrentTab(index: 0);
          } else {
            context
                .read<BottomNavigationBarCubit>()
                .updateCurrentTab(index: previousNavOptions.last);
          }
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: BlocBuilder<BottomNavigationBarCubit, int>(
          builder: (context, currentTab) {
            return Stack(
              children: [
                IndexedStack(
                  index: currentTab,
                  children: const [
                    TagsLocationScreen(),
                    DrivingScreen(),
                    SafetyScreen(),
                    ChatScreen(),
                  ],
                ),
                Positioned(
                  bottom: 15,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BottomNavigationBar(
                        elevation: 0,
                        currentIndex: currentTab,
                        onTap: (index) {
                          context
                              .read<BottomNavigationBarCubit>()
                              .updateCurrentTab(index: index);
                          context
                              .read<BottomNavigationHistoryCubit>()
                              .updateTabHistory(index: index);
                        },
                        backgroundColor: theme.colorScheme.secondary,
                        selectedItemColor: theme.colorScheme.tertiary,
                        unselectedItemColor: theme.hintColor,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.map_outlined),
                            label: 'Location',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.drive_eta),
                            label: 'Driving',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.security),
                            label: 'Safety',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.chat),
                            label: 'Chat',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
