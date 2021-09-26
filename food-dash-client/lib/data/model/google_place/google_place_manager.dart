class GooglePlaceManager {
  static final String _apiKey = 'AIzaSyDojHLUq_g6MHoF57SJ3fDHFmerXEVVgsI';
  static final photoAPI = 'https://maps.googleapis.com/maps/api/place/photo';
  static String getPlacePhotoUrl(String photoRef, int maxWidth, int maxHeight) {
    return '$photoAPI?photoreference=$photoRef&maxheight=$maxHeight&maxwidth=$maxWidth&key=$_apiKey';
  }
}
