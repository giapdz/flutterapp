import 'package:flutter/material.dart';
import 'package:HotelsHN/models/hotel.dart';
import 'package:HotelsHN/models/category.dart';
import 'package:wemapgl/wemapgl.dart';
const FAKE_CATEGORIES = const [
  Category(id: 1, content: 'Khách sạn 1-2 sao', color: Colors.deepOrange),
  Category(id: 2, content: 'Khách sạn 3-4 sao', color: Colors.teal),
  Category(id: 3, content: 'Khách sạn 5 sao', color: Colors.pink),
  Category(id: 4, content: 'Căn hộ', color: Colors.blueAccent),
  Category(id: 5, content: 'Kí túc xá', color: Colors.deepPurple),
  Category(id: 6, content: 'Nhà trọ', color: Colors.green),
];
var FAKE_HOTELS = [
  //array of food's objects
  Hotel(
      name: "Hanoi Canina Hotel",
      urlImage: "https://exp.cdn-hotels.com/hotels/46000000/45710000/45703600/45703586/3af3a977_z.jpg?impolicy=fcrop&w=702&h=468&q=high",
      evaluate: 9.7,
      price: 160000,
      star: 1,
      Location: '16A Ngõ Trung Yên, Hàng Bạc, Hoàn Kiếm, Hà Nội',
      Convenients: ['Máy sấy tóc', 'Điều hoà', 'Bồn tắm','Wifi'],
      categoryId: 1,
      coordinate: LatLng(21.03374797940352, 105.85222002630796)
  ),
  Hotel(
      name: "Acoustic Hotel & Spa",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/283/283156032.jpg?hp=1",
      evaluate: 9,
      price: 200550,
      star: 1,
      Location: '39 Thợ Nhuộm, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Wifi', 'Cà phê', 'Thang máy'],
      categoryId: 1,
      coordinate: LatLng(21.027767058447157, 105.8446060128145)),


  Hotel(
      name: "Halais Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/176/176479054.jpg?hp=1",
      evaluate: 9.5,
      price: 200550,
      star: 1,
      Location: '48 Tran Nhan Tong, Nguyen Binh Khiem, Quận Hai Bà Trưng, Hà Nội, Việt Nam',
      Convenients: ['Ti vi', 'Bồn tắm', 'Cà phê', 'Dịch vụ giặt là'],
      categoryId: 1,
      coordinate: LatLng(21.017334712091802, 105.84869859747211)),

  Hotel(
      name: "Eco Luxury Hanoi",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/482/48253152.jpg?hp=1",
      evaluate: 9.6,
      price: 180000,
      star: 1,
      Location: '17 Cua Dong, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Chỗ đậu xe', 'Bồn tắm', 'Ti vi'],
      categoryId: 1,
      coordinate: LatLng(21.034606122512457, 105.84661499932129)),

  Hotel(
      name: "Hanoi Posh Boutique Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/864/86499289.jpg?hp=1",
      evaluate: 9.7,
      price: 200000,
      star: 1,
      Location: '4A Hàng Giấy, Đồng Xuân, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Dịch vụ giặt là', 'Thang máy', 'Ti vi'],
      categoryId: 1,
      coordinate: LatLng(21.040001616344025, 105.84782231281461)),

  Hotel(
      name: "My Moon Hotel Hanoi",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/965/96535013.jpg?hp=1",
      evaluate: 9.6,
      price: 170000,
      star: 1,
      Location: '59 Cua Dong, Hoan Kiem, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Máy sấy tóc', 'Ti vi', 'Ghế tình yêu'],
      categoryId: 1,
      coordinate: LatLng(21.034776636224947, 105.84503112630787)),

  Hotel(
      name: "Labevie Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/284/284337777.jpg?hp=1",
      evaluate: 9.5,
      price: 200550,
      star: 1,
      Location: '34 Hang Tre Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Dịch vụ giặt là', 'Wifi', 'Chỗ đậu xe'],
      categoryId: 1,
      coordinate: LatLng(21.03225975482204, 105.85554296863678)),

  Hotel(
      name: "Hanoi La Storia Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/890/89080420.jpg?hp=1",
      evaluate: 9.6,
      price: 190000,
      star: 1,
      Location: '45 Hang Dong street, Hoan Kiem district, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Ti vi', 'Bồn tắm', 'Cà phê'],
      categoryId: 1,
      coordinate: LatLng(21.03604060381727, 105.8477171821302)),

  Hotel(
      name: "Hanoi Pho Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/108/108024869.jpg?hp=1",
      evaluate: 9.7,
      price: 210000,
      star: 1,
      Location: '46 Nguyen Van To, Hoan Kiem, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Bồn tắm', 'Cà phê', 'Dịch vụ giặt là'],
      categoryId: 1,
      coordinate: LatLng(21.031831825683728, 105.84553129747236)),

  Hotel(
      name: "Hanoi Chic Boutique Hotel",
      urlImage: "https://ik.imagekit.io/tvlk/apr-asset/dgXfoyh24ryQLRcGq00cIdKHRmotrWLNlvG-TxlcLxGkiDwaUSggleJNPRgIHCX6/hotel/asset/10020275-b6bec11207074771ed50a65b6bf1971d.jpeg?tr=q-40,c-at_max,w-740,h-500&_src=imagekit",
      evaluate: 9.7,
      price: 382000,
      star: 4,
      Location: '51-53 Bát Sứ, Hàng Bồ, Quận Hoàn Kiếm, Hà Nội',
      Convenients: ['Máy sấy tóc', 'Điều hoà', 'Bồn tắm','Wifi'],
      categoryId: 2,
      coordinate: LatLng(21.03434129494397, 105.84737579747235)),

  Hotel(
      name: "Khách sạn Serenity Diamond",
      urlImage: "https://ik.imagekit.io/tvlk/apr-asset/dgXfoyh24ryQLRcGq00cIdKHRmotrWLNlvG-TxlcLxGkiDwaUSggleJNPRgIHCX6/hotel/asset/10029260-840x460-FIT_AND_TRIM-ac22a8bb1945837c67b42ae43542a5bb.jpeg?tr=q-40,c-at_max,w-740,h-500&_src=imagekit",
      evaluate: 9.8,
      price: 275550,
      star: 4,
      Location: '1B Cửa Đông, Cửa Đông, Quận Hoàn Kiếm, Hà Nội',
      Convenients: ['Máy sấy tóc', 'Dịch vụ giặt là', 'Wifi'],
      categoryId: 2,
      coordinate: LatLng(21.03462026425195, 105.84690226863688)),
  Hotel(
      name: "Serenity Diamond Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/141/141958029.jpg?hp=1",
      evaluate: 9.7,
      price: 300550,
      star: 4,
      Location: '1 Cua Dong Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Wifi', 'Cà phê', 'Thang máy'],
      categoryId: 2,
      coordinate: LatLng(21.034481022655395, 105.84672206863674)),

  Hotel(
      name: "Hanoi Paradise hotel & Spa",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/135/135339547.jpg?hp=1",
      evaluate: 9.7,
      price: 250550,
      star: 3,
      Location: '62 Hang Bac Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Máy sấy tóc', 'Cà phê', 'Thang máy', 'Bồn tắm'],
      categoryId: 2,
      coordinate: LatLng(21.034135697234774, 105.85246546918798)),

  Hotel(
      name: "Hanoi Golden Holiday Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/284/284828363.jpg?hp=1",
      evaluate: 9.8,
      price: 300000,
      star: 4,
      Location: '43 Hang Dong, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Điều hòa', 'Ti vi', 'Dịch vụ giặt là', 'Cà phê'],
      categoryId: 2,
      coordinate: LatLng(21.03582071045069, 105.84767955329465)),

  Hotel(
      name: "Aira Boutique Hanoi Hotel & Spa",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/282/282635560.jpg?hp=1",
      evaluate: 9.8,
      price: 280550,
      star: 3,
      Location: '38 Tran Phu, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Máy sấy tóc', 'Cà phê', 'Thang máy', 'Bồn tắm'],
      categoryId: 2,
      coordinate: LatLng(21.030900612580826, 105.84147545329456)),

  Hotel(
      name: "Silk Collection Hotel & Spa",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/224/224033388.jpg?hp=1",
      evaluate: 9.7,
      price: 350550,
      star: 4,
      Location: '58 Hang Gai Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Wifi', 'Ghế tình yêu', 'Thang máy', 'Ti vi'],
      categoryId: 2,
      coordinate: LatLng(21.032438181252928, 105.85010334165018)),

  Hotel(
      name: "JM Marvel Hotel & Spa",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/133/133580036.jpg?hp=1",
      evaluate: 9.8,
      price: 280550,
      star: 4,
      Location: '16 Hang Da, Hoan Kiem, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Dịch vụ giặt là', 'Cà phê', 'Truyền hình cáp', 'Điều hòa'],
      categoryId: 2,
      coordinate: LatLng(21.031176983988374, 105.84668218397908)),

  Hotel(
      name: "La Sinfonía del Rey Hotel & Spa",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/209/209352115.jpg?hp=1",
      evaluate: 9.8,
      price: 350550,
      star: 4,
      Location: '33-35 Hàng Dầu , Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Bồn tắm', 'Ghế tình yêu', 'Điều hòa', 'Thang máy'],
      categoryId: 2,
      coordinate: LatLng(21.03123605564806, 105.85399013980123)),

  Hotel(
      name: "The Oriental Jade Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/221/221824920.jpg?hp=1",
      evaluate: 9.7,
      price: 280000,
      star: 4,
      Location: '92 - 94 Hàng Trống, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Ghế tình yêu', 'Máy sấy tóc', 'Wifi', 'Truyền hình cáp'],
      categoryId: 2,
      coordinate: LatLng(21.029783185300282, 105.85031118397899)),

  Hotel(
      name: "La Siesta Premium Hang Be",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/214/214884779.jpg?hp=1",
      evaluate: 9.9,
      price: 350000,
      star: 5,
      Location: '212a Hàng Bông, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Wifi', 'Cà phê', 'Thang máy', 'Điều hòa', 'Ghế tình yêu'],
      categoryId: 3,
      coordinate: LatLng(21.028679557711037, 105.84373023980122)),

  Hotel(
      name: "Rising Dragon Palace Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/837/83739948.jpg?hp=1",
      evaluate: 9.8,
      price: 300550,
      star: 5,
      Location: '24 Hang Ga Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Ti vi', 'Cà phê', 'Wifi', 'Thang máy', 'Máy sấy tóc'],
      categoryId: 3,
      coordinate: LatLng(21.035376121632222, 105.84686679562351)),


  Hotel(
      name: "Emerald Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/284/284492160.jpg?hp=1",
      evaluate: 9.9,
      price: 350550,
      star: 5,
      Location: '64 Trieu Viet Vuong, Quận Hai Bà Trưng, Hà Nội, Việt Nam',
      Convenients: ['Ti vi', 'Truyền hình cáp', 'Wifi', 'Điều hòa', 'Thang máy'],
      categoryId: 3,
      coordinate: LatLng(21.016739318530984, 105.85038018397873)),

  Hotel(
      name: "Mövenpick Hotel Hanoi",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/246/246024187.jpg?hp=1",
      evaluate: 9.9,
      price: 400000,
      star: 5,
      Location: '83A Ly Thuong Kiet Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Ti vi', 'Truyền hình cáp', 'Điều hòa', 'Ghế tình yêu', 'Máy sấy tóc'],
      categoryId: 3,
      coordinate: LatLng(21.024844019095195, 105.84429202630771)),

  Hotel(
      name: "Sofitel Legend Metropole Hanoi",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/175/175082969.jpg?hp=1",
      evaluate: 9.9,
      price: 380000,
      star: 5,
      Location: '15 Ngo Quyen Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Cà phê', 'Dịch vụ giặt là', 'Truyền hình cáp', 'Điều hòa', 'Ghế tình yêu'],
      categoryId: 3,
      coordinate: LatLng(21.025922549607134, 105.85661869212801)),

  Hotel(
      name: "InterContinental Hanoi Westlake, an IHG Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/272/272419579.jpg?hp=1",
      evaluate: 10,
      price: 400500,
      star: 5,
      Location: '5 Tu Hoa Street, Tay Ho District, Quận Tây Hồ, Hà Nội, Việt Nam',
      Convenients: ['Điều hòa', 'Ti vi', 'Chỗ đậu xe', 'Dịch vụ giặt là', 'Ghế tình yêu'],
      categoryId: 3,
      coordinate: LatLng(21.058645330379633, 105.83180901836168)),

  Hotel(
      name: "Pan Pacific Hanoi",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/896/89617607.jpg?hp=1",
      evaluate: 9.9,
      price: 360000,
      star: 5,
      Location: '1 Thanh Nien Road, Quận Ba Đình, 10000 Hà Nội, Việt Nam',
      Convenients: ['Wifi', 'Máy sấy tóc', 'Điều hòa', 'Thang máy', 'Bồn tắm'],
      categoryId: 3,
      coordinate: LatLng(21.049977756480008, 105.83982895329483)),

  Hotel(
      name: "Hilton Hanoi Opera",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/115/115553985.jpg?hp=1",
      evaluate: 9.8,
      price: 340000,
      star: 5,
      Location: '01 Le Thanh Tong, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Điều hòa', 'Ghế tình yêu', 'Chỗ đậu xe', 'Cà phê', 'Truyền hình cáp'],
      categoryId: 3,
      coordinate: LatLng(21.02427201971034, 105.85718566863665)),

  Hotel(
      name: "Hotel de l'Opera Hanoi - MGallery",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/228/228352658.jpg?hp=1",
      evaluate: 9.9,
      price: 380000,
      star: 5,
      Location: '29 Trang Tien Street, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Truyền hình cáp', 'Wifi', 'Cà phê', 'Ghế tình yêu', 'Ti vi'],
      categoryId: 3,
      coordinate: LatLng(21.024656019297407, 105.85558322630779)),

  Hotel(
      name: "Apricot Hotel",
      urlImage: "https://cf.bstatic.com/images/hotel/max1024x768/560/56019219.jpg?hp=1",
      evaluate: 9.8,
      price: 337200,
      star: 5,
      Location: '136 Hang Trong, Quận Hoàn Kiếm, Hà Nội, Việt Nam',
      Convenients: ['Ti vi', 'Truyền hình cáp', 'Wifi', 'Điều hòa', 'Thang máy'],
      categoryId: 3,
      coordinate: LatLng(21.028323272718836, 105.8508873300056)),

];