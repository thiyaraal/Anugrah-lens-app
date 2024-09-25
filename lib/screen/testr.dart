import 'package:anugrah_lens/models/customers_model.dart';
import 'package:anugrah_lens/services/customer_services.dart';
import 'package:anugrah_lens/style/color_style.dart';
import 'package:flutter/material.dart';

class CommunityMenteeScreen extends StatefulWidget {
  CommunityMenteeScreen({Key? key}) : super(key: key);

  @override
  State<CommunityMenteeScreen> createState() => _CommunityMenteeScreenState();
}

class _CommunityMenteeScreenState extends State<CommunityMenteeScreen> {

  @override
  void initState() {
    super.initState();
  }

  final CostumersService _costumersService = CostumersService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pelanggan'),
        backgroundColor: ColorStyle.primaryColor,
      ),
      body: FutureBuilder<CustomersModel>(
        future: _costumersService.fetchCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data?.customer == null) {
            return Center(child: Text('Tidak ada pelanggan'));
          }

          // Mengambil daftar pelanggan
          List<Customer> customers = snapshot.data!.customer!;

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(customers[index].name ?? 'Nama tidak tersedia'),
              );
            },
          );
        },
      ),
    );
  }
}
