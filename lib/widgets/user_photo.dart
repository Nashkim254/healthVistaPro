part of 'widgets.dart';

Widget userPhoto({required double radius, required String url}) {
  return CircleAvatar(
    radius: radius,
    child: CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        );
      },
      placeholder: (context, url) {
        return const CircularProgressIndicator();
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}