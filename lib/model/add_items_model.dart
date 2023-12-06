class AddItemsModel {
  final String image;
  final String name;

  AddItemsModel({
    required this.image,
    required this.name,
  });
}

List<AddItemsModel> addItemsModel = [
  AddItemsModel(
    image: 'assets/images/bs.png',
    name: 'Baby Shower',
  ),
  AddItemsModel(
    image: 'assets/images/baloons.png',
    name: 'Baloons',
  ),
  AddItemsModel(
    image: 'assets/images/wedding.png',
    name: 'Wedding',
  ),
  AddItemsModel(
    image: 'assets/images/retirement.png',
    name: 'Retirement',
  ),
  AddItemsModel(
    image: 'assets/images/quinciera.png',
    name: 'Quinciera',
  ),
  AddItemsModel(
    image: 'assets/images/dp.png',
    name: 'Dinner Party',
  ),
  AddItemsModel(
    image: 'assets/images/decades.png',
    name: 'Decades',
  ),
  AddItemsModel(
    image: 'assets/images/bm.png',
    name: 'Bar Mitzvah',
  ),
];
