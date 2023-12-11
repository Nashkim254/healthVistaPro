part of 'pages.dart';

class NotifiedPage extends StatelessWidget {
  final RemoteMessage? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
          color: Colors.grey
          ),
        ),
        title:  Text(label!.notification!.title!, style: const TextStyle(
          color: Colors.black
        ),),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[400]
          ),
          child: Text(label!.notification!.body!, style: const TextStyle(
            color: Colors.white,
            fontSize: 30
          ),),
        ),
      ),
    );
  }
}