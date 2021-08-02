final String imageAssetsRoot = "images/";//
final String image1 = _getImagePath("Dfin.png"); //
final String image2 = _getImagePath("rsz_pnt.png");//
final String image3 = _getImagePath("SHF.png");//
final String image4 = _getImagePath("rsz_ts.png");
final String logo = _getImagePath("logo.png");
// Paths to the images

String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}