import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:onspace/features/chat/ui/chat_screen.dart';
import 'package:onspace/features/driving/driving_screen.dart';
import 'package:onspace/features/safety/safety_screen.dart';
import 'package:onspace/features/tag_location/ui/screens/tags_location_screen.dart';

import '../../bloc/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../../bloc/bottom_navigation_bar_cubit/bottom_navigation_history_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        List<int> previousNavOptions =
            context.read<BottomNavigationHistoryCubit>().state;
        if (previousNavOptions.isEmpty) {
          var actionSelected = await showAnimatedDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                  'Do you wish to exit the app?',
                  style: theme.textTheme.titleMedium,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context, true),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 40.0,
                                  right: 40.0,
                                  top: 5.0,
                                  bottom: 5.0),
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.error,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: Center(
                                child: Text('Yes',
                                    style: theme.textTheme.displayMedium),
                              ),
                            )),
                        GestureDetector(
                            onTap: () => Navigator.pop(context, false),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 40.0,
                                  right: 40.0,
                                  top: 5.0,
                                  bottom: 5.0),
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: Center(
                                child: Text('No',
                                    style: theme.textTheme.displayMedium,),
                              ),
                            ))
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
          return IndexedStack(
            index: currentTab,
            children: const [
              TagsLocationScreen(),
              DrivingScreen(),
              SafetyScreen(),
              ChatScreen(),
            ],
          );
        },),
        bottomNavigationBar: BlocBuilder<BottomNavigationBarCubit, int>(
            builder: (context, currentTab) {
          // return CustomAnimatedBottomBar(
          //     containerHeight: 60,
          //     backgroundColor: theme.colorScheme.onPrimary,
          //     selectedIndex: currentTab,
          //     showElevation: true,
          //     itemCornerRadius: 24,
          //     curve: Curves.easeIn,
          //     onItemSelected: (int index) {
          //       context
          //           .read<BottomNavigationBarCubit>()
          //           .updateCurrentTab(index: index);
          //       context
          //           .read<BottomNavigationHistoryCubit>()
          //           .updateTabHistory(index: index);
          //     },
          //     items: <BottomNavyBarItem>[
          //       BottomNavyBarItem(
          //         icon: Icon(
          //           Icons.home,
          //           color: currentTab == 0
          //               ? theme.colorScheme.primary
          //               : Colors.grey.shade400,
          //           size: currentTab == 0 ? 26 : 24,
          //         ),
          //         title: Text(
          //           'Home',
          //           style: theme.textTheme.labelSmall,
          //         ),
          //         activeColor: theme.colorScheme.primary,
          //         inactiveColor: theme.colorScheme.secondary,
          //         textAlign: TextAlign.center,
          //       ),
          //       BottomNavyBarItem(
          //         icon: Icon(
          //           Icons.list_alt_rounded,
          //           color: currentTab == 1
          //               ? theme.colorScheme.primary
          //               : Colors.grey.shade400,
          //           size: currentTab == 1 ? 26 : 24,
          //         ),
          //         title: Text(
          //           'My Leads',
          //           style: theme.textTheme.labelSmall,
          //         ),
          //         activeColor: theme.colorScheme.primary,
          //         inactiveColor: theme.colorScheme.secondary,
          //         textAlign: TextAlign.center,
          //       ),
          //       BottomNavyBarItem(
          //         icon: SizedBox(
          //             height: currentTab == 2 ? 24 : 22,
          //             width: currentTab == 2 ? 24 : 22,
          //             child: Image.asset('assets/images/money.png',
          //                 color: currentTab == 2
          //                     ? theme.colorScheme.primary
          //                     : Colors.grey.shade400)),
          //         title: Text(
          //           'My Money',
          //           style: theme.textTheme.labelSmall,
          //         ),
          //         activeColor: theme.colorScheme.primary,
          //         inactiveColor: theme.colorScheme.secondary,
          //         textAlign: TextAlign.center,
          //       ),
          //       BottomNavyBarItem(
          //         icon: SizedBox(
          //             height: currentTab == 3 ? 24 : 22,
          //             width: currentTab == 3 ? 24 : 22,
          //             child: Image.asset('assets/images/userprofile_dash.png',
          //                 color: currentTab == 3
          //                     ? theme.colorScheme.primary
          //                     : Colors.grey.shade400)),
          //         title: Text(
          //           'Profile',
          //           style: theme.textTheme.labelSmall,
          //         ),
          //         activeColor: theme.colorScheme.primary,
          //         inactiveColor: theme.colorScheme.secondary,
          //         textAlign: TextAlign.center,
          //       ),
          //       BottomNavyBarItem(
          //         icon: Icon(
          //           Icons.notifications_active_outlined,
          //           color: currentTab == 4
          //               ? theme.colorScheme.primary
          //               : Colors.grey.shade400,
          //           size: currentTab == 4 ? 26 : 24,
          //         ),
          //         title: Text(
          //           'Notifications',
          //           style: theme.textTheme.labelSmall,
          //         ),
          //         activeColor: theme.colorScheme.primary,
          //         inactiveColor: theme.colorScheme.secondary,
          //         textAlign: TextAlign.center,
          //       ),
          //     ]);
              return BottomNavigationBar(
                currentIndex: currentTab,
                onTap: (index) {
                  context
                      .read<BottomNavigationBarCubit>()
                      .updateCurrentTab(index: index);
                  context
                      .read<BottomNavigationHistoryCubit>()
                      .updateTabHistory(index: index);
                },
                backgroundColor: theme.colorScheme.onPrimary,
                selectedItemColor: theme.colorScheme.primary,
                unselectedItemColor: theme.colorScheme.secondary,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_rounded),
                    label: 'My Leads',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.money),
                    label: 'My Money',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_active_outlined),
                    label: 'Notifications',
                  ),
                ],
              );
        }),
      ),
    );
  }
}
