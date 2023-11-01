class Content {
  String image;
  String title;
  String discription;

  Content({this.image = '', this.title = '', this.discription = ''});
}

List<Content> contents = [
  Content(
    title: 'Register yourself !',
    image: 'images/intro_pageOne.jpg',
    discription:
        "Register yourself to find the best services available\n for you and a lot of nurse centers who offer\n home care.",
  ),
  Content(
    title: 'Medical Devices !',
    image: 'images/intro_pageTwo.png',
    discription:
        " Find the best medical devices available for you and explore a wide range of healthcare \nequipment.",
  ),
];
