import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../widgets/profile/profile_header_card.dart';
import '../widgets/profile/profile_menu_card.dart';
import '../widgets/profile/profile_section_title.dart';
import '../widgets/profile/profile_logout_button.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/icons/app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'Profile',
        titleOnRight: false,
        rightActions: [
          IconButton(
            icon: Icon(AppIcons.settings, color: AppColors.textPrimary),
            tooltip: 'Settings',
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // Profile Header Card
            ProfileHeaderCard(
              name: 'Mochamad Ramdhan Alfikri',
              email: '231080200093@umsida.ac.id',
              imageAsset: 'assets/images/student1.JPG',
              onEditProfile: () {
                // TODO: Edit profile
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            // Account Section
            const ProfileSectionTitle(title: 'Account'),
            const SizedBox(height: AppSpacing.sm),
            ProfileMenuCard(
              items: [
                ProfileMenuItem(
                  icon: AppIcons.cart,
                  title: 'My Orders',
                  subtitle: 'Check your order status',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: AppIcons.heart,
                  title: 'Wishlist',
                  subtitle: 'Your favorite items',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: AppIcons.mapPin,
                  title: 'Addresses',
                  subtitle: 'Manage delivery addresses',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Preferences Section
            const ProfileSectionTitle(title: 'Preferences'),
            const SizedBox(height: AppSpacing.sm),
            ProfileMenuCard(
              items: [
                ProfileMenuItem(
                  icon: AppIcons.bell,
                  title: 'Notifications',
                  subtitle: 'Manage notifications',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: AppIcons.creditCard,
                  title: 'Payment Methods',
                  subtitle: 'Manage payment options',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Support Section
            const ProfileSectionTitle(title: 'Support'),
            const SizedBox(height: AppSpacing.sm),
            ProfileMenuCard(
              items: [
                ProfileMenuItem(
                  icon: AppIcons.helpCircle,
                  title: 'Help Center',
                  subtitle: 'Get help and support',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: AppIcons.info,
                  title: 'About',
                  subtitle: 'Learn more about us',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Logout Button
            ProfileLogoutButton(
              onLogout: () {
                // TODO: Logout
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
