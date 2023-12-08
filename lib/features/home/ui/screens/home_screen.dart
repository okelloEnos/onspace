import 'package:flutter/material.dart';
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

    return Scaffold(
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
    );
  }
}
