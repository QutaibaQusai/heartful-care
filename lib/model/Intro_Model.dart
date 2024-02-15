class Content {
  String image;
  String title;
  String discription;
// this page for the intro page
  Content({this.image = '', this.title = '', this.discription = ''});
}

List<Content> contents = [
  Content(
    title: 'Register yourself !',
    image: 'images/intro_page.jpg',
    discription:
        "Register yourself to find the best services available for you and a lot of nurse centers who offer home care.",
  ),
  Content(
    title: 'Medical Devices !',
    image: 'images/24.jpg',
    discription:
        " Find the best medical devices available for you and explore a wide range of healthcare \nequipment.",
  ),
];
