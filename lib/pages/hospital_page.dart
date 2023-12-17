part of 'pages.dart';

class HospitalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "images/hospital_cover.png",
                ),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent
                ])),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      LocalizationService.of(context).translate("nearby_hospital")!,
                      style: whiteTextFont.copyWith(
                          fontSize: 38, color: Colors.white),
                    ),
                    Text(
                      "3 Tersedia",
                      style: whiteTextFont.copyWith(
                          fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: accentColor7,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: defaultMargin,
                          ),
                          ListTile(
                            leading: Image.asset("images/hospital_cover.png"),
                            title: const Text("Rumah sakit siloam"),
                            subtitle: const Text("Jln. Diponegoro Lippo Karawaci"),
                          ),
                          ListTile(
                            leading: Image.asset("images/hospital_cover.png"),
                            title: const Text("Rumah sakit siloam"),
                            subtitle: const Text("Jln. Diponegoro Lippo Karawaci"),
                          ),
                          ListTile(
                            leading: Image.asset("images/hospital_cover.png"),
                            title: const Text("Rumah sakit siloam"),
                            subtitle: const Text("Jln. Diponegoro Lippo Karawaci"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
