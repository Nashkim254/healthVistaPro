part of 'pages.dart';

class DoctorRatingPage extends StatefulWidget {
  final m.Call? call;
  DoctorRatingPage({this.call});
  @override
  _DoctorRatingPageState createState() => _DoctorRatingPageState();
}

class _DoctorRatingPageState extends State<DoctorRatingPage> {
  double? _rating;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (widget.call!.callerStatus == "Patient")
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("How was the consultation with Dr. ${widget.call!.receiverName} ?"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                    ),
                    onPressed: () {
                      UserServices.setDoctorRating(widget.call!.receiverId!, _rating!.toDouble());
                      context.read<PageBloc>().add(GoToMainPage());
                    },
                    child: Text(
                      "Submit doctor rating",
                      style: greyTextFont.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("How was the consultation with Dr. ${widget.call!.callerName} ?"),
                  const SizedBox(
                    height: 10,
                  ),
                   Container(
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                    ),
                    onPressed: () {
                      UserServices.setDoctorRating(widget.call!.callerId!, _rating!.toDouble());
                      context.read<PageBloc>().add(GoToMainPage());
                    },
                    child: Text(
                      "Submit doctor rating",
                      style: greyTextFont.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
