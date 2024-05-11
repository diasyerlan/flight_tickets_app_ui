import 'package:flights_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });
  final Function(int) onItemTapped;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          onItemTapped(value);
        },
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: darkBlue,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/plane.svg',
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset('assets/icons/plane_filled.svg'),
              label: 'Авиабилеты'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/hotels.svg'),
              activeIcon: SvgPicture.asset('assets/icons/hotels_filled.svg'),
              label: 'Отели'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/location.svg'),
              activeIcon: SvgPicture.asset('assets/icons/location_filled.svg'),
              label: 'Короче'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/subscriptions.svg'),
              activeIcon:
                  SvgPicture.asset('assets/icons/subscriptions_filled.svg'),
              label: 'Подписки'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/profile.svg'),
              activeIcon: SvgPicture.asset('assets/icons/profile_filled.svg'),
              label: 'Профиль')
        ]);
  }
}
