import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/providers/SanPham.dart';
import 'package:room_finder_flutter/providers/customer.dart';
import 'package:room_finder_flutter/screens/RFAboutUsScreen.dart';
import 'package:room_finder_flutter/screens/RFHelpScreen.dart';
import 'package:room_finder_flutter/screens/RFNotificationScreen.dart';
import 'package:room_finder_flutter/screens/RFRecentlyViewedScreen.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';

List<RoomFinderModel> categoryList() {
  List<RoomFinderModel> categoryListData = [];
  categoryListData.add(RoomFinderModel(roomCategoryName: "Flat"));
  categoryListData.add(RoomFinderModel(roomCategoryName: "Rooms"));
  categoryListData.add(RoomFinderModel(roomCategoryName: "Hall"));
  categoryListData.add(RoomFinderModel(roomCategoryName: "Rent"));
  categoryListData.add(RoomFinderModel(roomCategoryName: "House"));

  return categoryListData;
}

List<RoomFinderModel> hotelList() {
  List<RoomFinderModel> hotelListData = [];
  hotelListData.add(RoomFinderModel(
      img: rf_hotel1, color: greenColor.withOpacity(0.6), roomCategoryName: "134 Văn Cao thông Nam Pháp", price: "4.25", rentDuration: " tỷ", location: "Nam Pháp", address: "Tiềm năng", description: "Hướng Đông | ", views: "2 KH Đã xem"));
  hotelListData.add(RoomFinderModel(img: rf_hotel2, color: Colors.blue, roomCategoryName: "Nhà 3 tầng mặt ngõ  169 Phạm Hữu Điều", price: "2.8 ", rentDuration: " tỷ", location: "Trần Nguyên Hãn", address: "Tiềm năng", description: "Tây Tứ Trạch | ", views: "10 KH Đã xem"));
  hotelListData.add(RoomFinderModel(
      img: rf_hotel3, color: greenColor.withOpacity(0.6), roomCategoryName: "Bán nhà 3 mặt thoáng 48,6 m2 x 4 tầng mới xây", price: "3.1 triệu / ", rentDuration: " căn", location: "Thiên Lôi", address: "Đang giao dịch", description: "Đông Nam | ", views: "06 KH Đã xem"));
  hotelListData
      .add(RoomFinderModel(img: rf_hotel4, color: redColor, roomCategoryName: "Nhà mặt ngõ nguyễn công hoà cách mặt đường ~ 100m", price: "3 ", rentDuration: " tỷ", location: "Nguyễn Công Hoà", address: "Tiềm năng", description: "Tây Nam | ", views: "12 KH Đã xem"));
  hotelListData
      .add(RoomFinderModel(img: rf_hotel5, color: greenColor.withOpacity(0.6), roomCategoryName: "Bán nhà 52m2 x 4tầng", price: "3.350 ", rentDuration: " tỷ", location: "Thư Trung", address: "Tiềm năng", description: "Thư Trung | ", views: "25 KH Đã xem"));
  hotelListData.add(RoomFinderModel(img: rf_hotel6, color: redColor, roomCategoryName: "MIẾU HAI XÃ NGÕ TO NÔNG RỘNG MÀ CHỈ CÓ HƠN TỎI", price: "1.950 ", rentDuration: " tỷ", location: "Miếu Hai Xã", address: "Đang giao dịch", description: "Đông | ", views: "10 KH Đã xem"));

  return hotelListData;
}

List<Customer> customersList() {
  List<Customer> customersListData = [];
  customersListData.add(Customer(hoTen: 'ANH TIẾN', field_dien_thoai: '0982703783', field_dia_chi: '', field_trang_thai: 'Đã xem lần 1', field_nhu_cau_khoang_gia: '2.0 - 3.0', field_nhu_cau_dien_tich: '30 - 40'));
  customersListData.add(Customer(hoTen: 'CHỊ HUỆ', field_dien_thoai: '0358023818', field_dia_chi: '', field_trang_thai: 'Đã xem lần 2', field_nhu_cau_khoang_gia: '3.0 - 3.5', field_nhu_cau_dien_tich: '40 - 60'));
  customersListData.add(Customer(hoTen: 'CHỊ YẾN', field_dien_thoai: '0366898770', field_dia_chi: '', field_trang_thai: 'Tiềm năng', field_nhu_cau_khoang_gia: '0.8 - 1.5', field_nhu_cau_dien_tich: '30 - 35'));
  customersListData.add(Customer(hoTen: 'CHỊ THANH', field_dien_thoai: '0342389023', field_dia_chi: '', field_trang_thai: 'Tiềm năng', field_nhu_cau_khoang_gia: '1.2 - 1.5', field_nhu_cau_dien_tich: '40 - 45'));
  customersListData.add(Customer(hoTen: 'Hằng Hằng', field_dien_thoai: '0973125028', field_dia_chi: '', field_trang_thai: 'Đang giao dịch', field_nhu_cau_khoang_gia: '1.0 - 1.5', field_nhu_cau_dien_tich: '50 - 55'));
  customersListData.add(Customer(hoTen: 'Nguyễn Hoàng My', field_dien_thoai: '0357306896', field_dia_chi: '', field_trang_thai: 'Tiềm năng', field_nhu_cau_khoang_gia: '1.5 - 2.0', field_nhu_cau_dien_tich: '40 - 50'));
  customersListData.add(Customer(hoTen: 'Mai Hương', field_dien_thoai: '0983201976', field_dia_chi: '', field_trang_thai: 'Đã xem lần 2', field_nhu_cau_khoang_gia: '2.5 - 3.0', field_nhu_cau_dien_tich: '40 - 45'));

  return customersListData;
}

List<RoomFinderModel> locationList() {
  List<RoomFinderModel> locationListData = [];
  locationListData.add(RoomFinderModel(img: rf_location1, price: "10 Sản phẩm", location: "Chợ Hàng"));
  locationListData.add(RoomFinderModel(img: rf_location2, price: "4 Sản phẩm", location: "Thiên Lôi"));
  locationListData.add(RoomFinderModel(img: rf_location3, price: "12 Sản phẩm", location: "Trại Lẻ"));
  locationListData.add(RoomFinderModel(img: rf_location4, price: "16 Sản phẩm", location: "Niệm Nghĩa"));
  locationListData.add(RoomFinderModel(img: rf_location5, price: "20 Sản phẩm", location: "Hàng Kênh"));
  locationListData.add(RoomFinderModel(img: rf_location6, price: "25 Sản phẩm", location: "Trần Nguyên Hãn"));

  return locationListData;
}

List<RoomFinderModel> faqList() {
  List<RoomFinderModel> faqListData = [];
  faqListData.add(
      RoomFinderModel(img: rf_faq, price: "What do we get here in this app?", description: "That which doesn't kill you makes you stronger, right? Unless it almost kills you, and renders you weaker. Being strong is pretty rad though, so go ahead."));
  faqListData
      .add(RoomFinderModel(img: rf_faq, price: "What is the use of this App?", description: "Sometimes, you've just got to say 'the party starts here'. Unless you're not in the place where the aforementioned party is starting. Then, just shut up."));
  faqListData.add(RoomFinderModel(
      img: rf_faq, price: "How to get from location A to B?", description: "If you believe in yourself, go double or nothing. Well, depending on how long it takes you to calculate what double is. If you're terrible at maths, don't."));

  return faqListData;
}

List<RoomFinderModel> notificationList() {
  List<RoomFinderModel> notificationListData = [];
  notificationListData.add(RoomFinderModel(price: "Welcome", unReadNotification: false, description: "Don’t forget to complete your personal info."));
  notificationListData.add(RoomFinderModel(price: "There are 4 available properties, you recently selected. ", unReadNotification: true, description: "Click here for more details."));

  return notificationListData;
}

List<RoomFinderModel> yesterdayNotificationList() {
  List<RoomFinderModel> yesterdayNotificationListData = [];
  yesterdayNotificationListData.add(RoomFinderModel(price: "There are 4 available properties, you recently selected. ", unReadNotification: false, description: "Click here for more details."));
  yesterdayNotificationListData.add(RoomFinderModel(price: "There are 4 available properties, you recently selected. ", unReadNotification: true, description: "Click here for more details."));
  yesterdayNotificationListData.add(RoomFinderModel(price: "There are 4 available properties, you recently selected. ", unReadNotification: true, description: "Click here for more details."));

  return yesterdayNotificationListData;
}

List<RoomFinderModel> settingList() {
  List<RoomFinderModel> settingListData = [];
  settingListData.add(RoomFinderModel(img: rf_notification, roomCategoryName: "Notifications", newScreenWidget: RFNotificationScreen()));
  settingListData.add(RoomFinderModel(img: rf_recent_view, roomCategoryName: "Recent Viewed", newScreenWidget: RFRecentlyViewedScreen()));
  settingListData.add(RoomFinderModel(img: rf_faq, roomCategoryName: "Get Help", newScreenWidget: RFHelpScreen()));
  settingListData.add(RoomFinderModel(img: rf_about_us, roomCategoryName: "About us", newScreenWidget: RFAboutUsScreen()));
  settingListData.add(RoomFinderModel(img: rf_sign_out, roomCategoryName: "Sign Out", newScreenWidget: SizedBox()));

  return settingListData;
}

List<RoomFinderModel> applyHotelList() {
  List<RoomFinderModel> applyHotelListData = [];
  applyHotelListData.add(RoomFinderModel(roomCategoryName: "Applied (5)"));
  applyHotelListData.add(RoomFinderModel(roomCategoryName: "Liked"));

  return applyHotelListData;
}

List<RoomFinderModel> availableHotelList() {
  List<RoomFinderModel> availableHotelListData = [];
  availableHotelListData.add(RoomFinderModel(roomCategoryName: "All Available(14)"));
  availableHotelListData.add(RoomFinderModel(roomCategoryName: "Booked"));

  return availableHotelListData;
}

List<RoomFinderModel> appliedHotelList() {
  List<RoomFinderModel> appliedHotelData = [];
  appliedHotelData.add(RoomFinderModel(img: rf_hotel1, roomCategoryName: "1 BHK at Lalitpur", price: "RS 8000 ", rentDuration: "1.2 km from Gwarko", location: "Mahalaxmi Lalitpur", address: "Booked", views: "3.0"));
  appliedHotelData.add(RoomFinderModel(img: rf_hotel2, roomCategoryName: "Big Room", price: "RS 5000 ", rentDuration: "1.2 km from Mahalaxmi", location: "Imadol", address: "Booked", views: "4.0"));
  appliedHotelData.add(RoomFinderModel(img: rf_hotel3, roomCategoryName: "4 Room for Student", price: "RS 6000 ", rentDuration: "1.2 km from Imadol", location: "Kupondole", address: "Booked", views: "2.5"));
  appliedHotelData.add(RoomFinderModel(img: rf_hotel4, roomCategoryName: "Hall and Room", price: "RS 5000 ", rentDuration: "1.2 km from Kupondole", location: "Koteshwor Lalitpur", address: "Booked", views: "4.5"));
  appliedHotelData.add(RoomFinderModel(img: rf_hotel5, roomCategoryName: "Big Room", price: "RS 2000 ", rentDuration: "1.2 km from Koteshwor", location: "Imadol", address: "Booked", views: "5.0"));

  return appliedHotelData;
}

List<SanPham> sanPhamList() {
  List<SanPham> sanPhamListData = [];
  sanPhamListData.add(SanPham(field_image: rf_hotel1, title: 'nhà độc lập 3 tầng miếu 2 xã', field_dia_chi: '4/20/52', field_so_tang: '2', field_duong: '2.50 m', field_huong: 'Tây Nam', field_gia: '1 - 1.1 tỷ'));
  sanPhamListData.add(SanPham(field_image: rf_hotel2, title: 'nhà 2 tầng 47m2 ngõ 109 trại lẻ', field_dia_chi: 'ngõ 109 trại lẻ', field_so_tang: '2', field_duong: '3.0 m', field_huong: 'Đông', field_gia: '2 tỷ'));
  sanPhamListData.add(SanPham(field_image: rf_hotel3, title: 'Bán nhà ngõ trung tâm ở Minh Khai', field_dia_chi: '14/7 Minh Khai', field_so_tang: '4', field_duong: '4.0 m', field_huong: 'Tây', field_gia: '5 - 5.5 tỷ'));
  sanPhamListData.add(SanPham(field_image: rf_hotel4, title: 'Nhà 30m* 3 ,5 tầng Trần Nguyên Hãn', field_dia_chi: '78/430 Trần nguyên hãn', field_so_tang: '3', field_duong: '3.0 m', field_huong: 'Nam', field_gia: '4 tỷ'));
  sanPhamListData.add(SanPham(field_image: rf_hotel5, title: 'nhà 4 tầng 162 trung lực', field_dia_chi: '', field_so_tang: '3', field_duong: '2.0 m', field_huong: 'Tây Nam', field_gia: '2 tỷ'));

  return sanPhamListData;
}

List<RoomFinderModel> hotelImageList() {
  List<RoomFinderModel> hotelImageListData = [];
  hotelImageListData.add(RoomFinderModel(img: rf_hotel1));
  hotelImageListData.add(RoomFinderModel(img: rf_hotel2));
  hotelImageListData.add(RoomFinderModel(img: rf_hotel3));
  hotelImageListData.add(RoomFinderModel(img: rf_hotel4));

  return hotelImageListData;
}
