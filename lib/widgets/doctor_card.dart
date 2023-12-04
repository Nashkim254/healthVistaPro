part of 'widgets.dart';

class DoctorCard extends StatelessWidget {
  final User? doctorType;
  final VoidCallback onTap;
  DoctorCard({this.doctorType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        width: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: accentColor2.withOpacity(0.4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "images/Icon_dokter_umum.png",
              height: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "I need a",
              style: blackTextFont,
            ),
            Text(
              doctorType!.job!,
              style: blackTextFont.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
