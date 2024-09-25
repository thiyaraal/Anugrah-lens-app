import 'package:anugrah_lens/models/customers_model.dart';
import 'package:anugrah_lens/screen/angsuran/menu_angsuran.dart';
import 'package:anugrah_lens/services/customer_services.dart';
import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:anugrah_lens/widget/card.dart';
import 'package:anugrah_lens/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RiwayatPageScreen extends StatefulWidget {
  RiwayatPageScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatPageScreen> createState() => _RiwayatPageScreenState();
}

class _RiwayatPageScreenState extends State<RiwayatPageScreen> {
  final CostumersService _costumersService = CostumersService();
  final TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.whiteColors,
      appBar: AppBar(
        backgroundColor: ColorStyle.whiteColors,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 20, // You can adjust the height as needed
            child: Image.asset(
              'assets/images/AnugrahLensLogo.png',
              fit: BoxFit.contain, // Ensures the image scales properly
            ),
          ),
        ),
      ),
      body: FutureBuilder<CustomersModel>(
        future: _costumersService.fetchCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data?.customer == null) {
            return const Center(child: Text('Tidak ada pelanggan'));
          }

          // Mengambil daftar pelanggan
          List<Customer> customers = snapshot.data!.customer!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                SearchDropdownFieldHome(
                  onSelected: (String selectedName) {
                    // Memastikan navigasi hanya terjadi jika nama dipilih dari dropdown
                    Customer? selectedCustomer = customers
                        .firstWhere((element) => element.name == selectedName);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuAngsuranScreen(
                          idCustomer: selectedCustomer.id ?? '',
                          customerName: selectedCustomer.name ?? '',
                        ),
                      ),
                    );
                  },
                  prefixIcons: const Icon(Icons.search,
                      color: Color.fromARGB(255, 53, 35, 35)),
                  suffixIcons: null,
                  controller: name,
                  hintText: 'cari nama pelanggan',
                  items: customers.map((e) => e.name ?? '').toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text('Semua Pelanggan',
                      style: FontFamily.title.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];

                      // Select the first glass if it exists
                      Glass? selectedGlass =
                          customer.glasses?.isNotEmpty == true
                              ? customer.glasses!.first
                              : null;

                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CardNameWidget(
                          onPressed: () {
                            if (selectedGlass != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuAngsuranScreen(
                                    idCustomer: customer.id ?? '',
                                    customerName: customer.name ?? '',

                                    // Pass the selected glass ID
                                  ),
                                ),
                              );
                            } else {
                              showTopSnackBar(
                                context,
                                'Pelanggan ini belum memiliki kacamata',
                                backgroundColor: ColorStyle.errorColor,
                              );
                            }
                          },
                          name: customer.name ?? 'Nama tidak tersedia',
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void showTopSnackBar(
    context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        duration: duration ?? const Duration(milliseconds: 3000),
        backgroundColor: backgroundColor ?? ColorStyle.primaryColor,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            left: 10,
            right: 10),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: FontFamily.caption.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
