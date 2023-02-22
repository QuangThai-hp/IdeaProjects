import 'package:flutter/material.dart';
import 'package:room_finder_flutter/providers/customer.dart';
import 'package:room_finder_flutter/providers/customers.dart';
//
import '../components/RFCustomerListComponent.dart';
import '../components/RFHotelListComponent.dart';
import '../models/RoomFinderModel.dart';
import '../utils/RFDataGenerator.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  // const CustomerList({Key? key}) : super(key: key);
  late final String trangThaiKhachHang;
  CustomerList(this.trangThaiKhachHang);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
// = 'Khách hàng chung';
  List<RoomFinderModel> hotelListData = hotelList();
  late List<Customer> customers = [];
  late String trangThaiCu = '';

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  Future<void> _reloadCustomers(BuildContext context) async{
    final provider = Provider.of<Customers>(context, listen: false);
    provider.getListCustomerWithStatus(widget.trangThaiKhachHang).then((value){
      setState(() {
        customers = provider.items;
      });
    });
    setState(() {this.trangThaiCu = widget.trangThaiKhachHang;});

  }

  @override
  Widget build(BuildContext context) {
    if(trangThaiCu != widget.trangThaiKhachHang)
      _reloadCustomers(context);
    // final customersData = Provider.of<Customers>(context, listen: false);
    // customersData.getListCustomerWithStatus(widget.trangThaiKhachHang);
    // customers = customersData.items;
    print(widget.trangThaiKhachHang);
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: customers.take(3).length,
      itemBuilder: (BuildContext context, int index) {
        Customer data = customers[index];
        return RFCustomerListComponent(customer: data);
      },
    );
  }
}
