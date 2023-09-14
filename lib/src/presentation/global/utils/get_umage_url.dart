String getImageUrl(
  String path, {
  ImageQuality imageQuality = ImageQuality.w500,
}) {
  return 'https://image.tmdb.org/t/p/${imageQuality.name}$path';
}

enum ImageQuality {
  w500,
  w780,
  original,
}
