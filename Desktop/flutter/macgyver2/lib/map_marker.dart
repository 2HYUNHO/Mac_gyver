import 'package:latlong2/latlong.dart';

class MapMarker {
  const MapMarker(
      {required this.image,
      required this.title,
      required this.address,
      required this.location,
      required this.marker});

  final String image;
  final String title;
  final String address;
  final LatLng location;
  final String marker;
}

// final _locations = [
//   LatLng(37.5029568, 127.046507),
//   LatLng(37.5264966, 127.027651),
//   LatLng(37.5041551, 127.046395),
//   LatLng(37.5180913, 127.022185),
//   LatLng(37.5259285, 127.029438),
//   LatLng(37.4910143, 127.031596),
//   LatLng(37.5257578, 127.027232),
// ];

const _path = 'lib/assets/';

final mapMarkers = [
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}1.jpeg',
    title: '잡스네전파상',
    address: '서울 강남구 강남대로158길 45 3층',
    location: LatLng(37.5200916, 127.022117),
  ),
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}2.jpeg',
    title: '스피드맥북수리',
    address: '서울 강남구 개포로 508',
    location: LatLng(37.4891974, 127.067937),
  ),
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}3.jpeg',
    title: '압구정로데오역 컴퓨터출장수리 애플맥북수리as 데이타복구',
    address: '서울 강남구 압구정로42길 13',
    location: LatLng(37.5279542, 127.035514),
  ),
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}4.jpeg',
    title: '삼성역 컴퓨터출장수리 애플맥북수리 데이타복구 유지보수',
    address: '서울 강남구 테헤란로98길 8 3층 V018호',
    location: LatLng(37.5076891, 127.061982),
  ),
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}5.jpeg',
    title: ' 수서 컴퓨터수리 애플맥북수리',
    address: '서울 강남구 광평로56길 10 4층 LS37호',
    location: LatLng(37.4870814, 127.103778),
  ),
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}6.jpeg',
    title: '맥북수리',
    address: '서울 강남구 삼성로92길 13',
    location: LatLng(37.5079977, 127.057526),
  ),
  MapMarker(
    marker: '${_path}marker1.png',
    image: '${_path}7.jpeg',
    title: '강남맥북수리',
    address: '서울 강남구 테헤란로 109 강남제일빌딩 301-4호',
    location: LatLng(37.4987995, 127.028976),
  ),

// ---------------------------------------------------------

  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}1.jpeg',
    title: '아이픽스 강남수리센터',
    address: '서울 강남구 테헤란로 322 \n한신인터밸리24빌딩 1층 \n서관 115호',
    location: LatLng(37.5029568, 127.046507),
  ),
  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}2.jpeg',
    title: '아이픽스존\n압구정 아이폰수리',
    address: '서울 강남구 압구정로 164',
    location: LatLng(37.5264966, 127.027651),
  ),
  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}3.jpeg',
    title: '아이폰119 강남 선릉 \n아이폰 수리센터',
    address: '서울 강남구 테헤란로 323 \n휘닉스오피스텔 지하1층 25호',
    location: LatLng(37.5041551, 127.046395),
  ),
  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}4.jpeg',
    title: '아이픽스존 신사 아이폰\n수리센터',
    address: '서울 강남구 강남대로152길 35 \n현정빌딩 제4층 402호',
    location: LatLng(37.5180913, 127.022185),
  ),
  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}5.jpeg',
    title: ' 아이픽스 압구정\n아이폰수리',
    address: '서울 강남구 압구정로30길 23 \n미승빌딩 305호',
    location: LatLng(37.5259285, 127.029438),
  ),
  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}6.jpeg',
    title: '강남 양재 \n아이폰 수리센터',
    address: '서울 강남구 강남대로 310 \n지하1층 01호 유니온센타',
    location: LatLng(37.4910143, 127.031596),
  ),
  MapMarker(
    marker: '${_path}marker.png',
    image: '${_path}7.jpeg',
    title: '강남 아이폰 수리 \n     아이 투폰',
    address: '서울 강남구 논현로175길 \n17 1층',
    location: LatLng(37.5257578, 127.027232),
  ),
];
