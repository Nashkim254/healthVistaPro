part of 'pages.dart';

class ViewImage extends StatelessWidget {
  final m.Message message;
  ViewImage(this.message);
  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));

    final TransformationController _transformationController = TransformationController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "${LocalizationService.of(context).translate('photo_from')} ${message.senderName}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: Center(
        child: Container(
          child: InteractiveViewer(
            transformationController: _transformationController,
            onInteractionEnd: (details) {
              _transformationController.value = Matrix4.identity();
            },
            maxScale: 5.0,
            child: Image.network(
              message.photoUrl!,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
