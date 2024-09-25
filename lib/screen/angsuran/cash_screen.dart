import 'package:anugrah_lens/models/customer_data_model.dart';
import 'package:anugrah_lens/screen/angsuran/detail_angsuran_screen.dart';
import 'package:anugrah_lens/services/customer_services.dart';
import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashScreen extends StatefulWidget {
  final String idCustomer;
  final String customerName;

  const CashScreen({
    super.key,
    required this.idCustomer,
    required this.customerName,
  });

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  late Future<CustomerData> customersData;

  @override
  void initState() {
    super.initState();
    customersData = CostumersService().fetchCustomerById(widget.idCustomer);
  }

  @override
  Widget build(BuildContext context) {
      String formatRupiah(int amount) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
      return formatCurrency.format(amount);
    }

    return FutureBuilder<CustomerData>(
      future: customersData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2.0,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final customer = snapshot.data!.customer!;
            final glasses = customer.glasses!
              .where((glass) =>
                  glass.paymentMethod == 'Cash' &&
                  glass.paymentStatus == 'Unpaid')
              .toList();
          if (glasses.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('No data available')),
                  )),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...glasses.map((glass) {
                  return CardAnsuranWidget(
                    onTap: () {
                      // Add navigation to detail screen here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailAngsuranSCreen(
                            idGlass: glass.id.toString(),
                            idCustomer: widget.idCustomer,
                            customerName: widget.customerName,
                          ),  
                        ),
                      );
                    },
                    label: glass.paymentMethod ??
                        'Metode pembayaran tidak tersedia',
                    address: customer.address ?? 'Alamat tidak tersedia',
                     sisaPembayaran:
                        'Sisa Pembayaran: ${glass.installments?.isNotEmpty == true ? formatRupiah(glass.installments?.last.remaining ?? 0) : '-'}',
                    frameName: glass.frame ?? 'Nama frame tidak tersedia',
                    glassesName: glass.lensType ?? 'Tipe lensa tidak tersedia',
                    decoration: BoxDecoration(
                      color: ColorStyle.secondaryColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        } else {
          return const SizedBox(
            child: Text("Tidak ada Data"),
          );
        }
      },
    );
  }
}
