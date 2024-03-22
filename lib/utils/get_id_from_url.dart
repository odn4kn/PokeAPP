int getIdFromUrl(String url) {
  final uri = Uri.parse(url);
  return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
}
