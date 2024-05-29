
//HexColor('#878C8D') // الرصاصي
//HexColor("#C93D3E") // الاحمر

//token=AmrXHsMGP0XZF9WrZGLyqz9hocRh4aPMMGrdBMX4SOyaRKCJloc6Cv3U8geXmiP3iaPejS

// List<dynamic> business = [];
//   // ignore: non_constant_identifier_names
//   void Getdataa() {
//     Dio_helper.Getdata(url: 'v2/top-headlines', query: {
//       'country': 'us',
//       'category': 'business',
//       'apikey': 'a339064673ed4da3a448e39309103665',
//     }).then((value) {
//       business = value.data['articles'];
//       print(business[0]["title"]);

//       emit(GetdataState());
//     }).catchError((Error) {
//       print(Error.toString());
//       emit(GetdataErrorState(Error.toString()));
//     });
//   }