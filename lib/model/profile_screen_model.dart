class ProfileModel {
  final String icon;
  final String title;
  final String subtitle;

  ProfileModel({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

List<ProfileModel> profile = [
  ProfileModel(
    icon: 'assets/images/my_listing.png',
    title: 'Selling',
    subtitle: 'Edit You Details, accont setting',
  ),
  ProfileModel(
    icon: 'assets/images/sold.png',
    title: 'Sold',
    subtitle: 'item you sold showing here',
  ),
  ProfileModel(
    icon: 'assets/images/sales.png',
    title: 'Sales',
    subtitle: 'Total sales',
  ),
  ProfileModel(
    icon: 'assets/images/reviews.png',
    title: 'Reviews',
    subtitle: 'You got a new Reviews',
  ),
  // ProfileModel(
  //   icon: 'assets/images/setting.png',
  //   title: 'Setting',
  //   subtitle: 'Security And Privacy',
  // ),
  ProfileModel(
    icon: 'assets/images/support.png',
    title: 'Support',
    subtitle: 'Help center and legal terms',
  ),
  ProfileModel(
    icon: 'assets/images/about.png',
    title: 'Know More',
    subtitle: 'Click to know more',
  ),
];
