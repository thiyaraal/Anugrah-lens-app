import 'package:anugrah_lens/models/customer_data_model.dart';
import 'package:anugrah_lens/screen/angsuran/edit_data_customers.dart';
import 'package:anugrah_lens/screen/angsuran/table_angsuran.dart';
import 'package:anugrah_lens/services/customer_services.dart';
import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:anugrah_lens/widget/Button_widget.dart';
import 'package:anugrah_lens/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailAngsuranSCreen extends StatefulWidget {
  final String idCustomer;
  final String idGlass;
  final String customerName;

  DetailAngsuranSCreen({
    Key? key,
    required this.idCustomer,
    required this.idGlass,
    required this.customerName,
  }) : super(key: key);

  @override
  State<DetailAngsuranSCreen> createState() => _DetailAngsuranSCreenState();
}

class _DetailAngsuranSCreenState extends State<DetailAngsuranSCreen> {
  late Future<CustomerData> customersData;
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    customersData = CostumersService().fetchCustomerById(widget.idCustomer);
  }

  @override
  Widget build(BuildContext context) {
    String formatRupiah(int amount) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(amount);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.customerName,
          style: FontFamily.subtitle.copyWith(color: ColorStyle.secondaryColor),
        ),
      ),
      body: FutureBuilder<CustomerData>(
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
            // ambil data glasses dari customer.Glasses semuanya
            final glasses = customer.glasses ?? [];

            /// seletedGlass dibambi dari customer.glasses yang sama dengan idGlass bukan yang pertam
            final selectedGlass = glasses.firstWhere(
                (glass) => glass.id == widget.idGlass,
                orElse: () => Glass());
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
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleTextWIdget(name: 'Nama Pelanggan'),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorStyle.secondaryColor,
                                ),
                                onPressed: () {
                                  /// buat fungsi untuk edit data customer disini dan bawa data customer
                                  /// ke form edit customer
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditDataCustomersScreen(
                                        glassId: selectedGlass.id.toString(),
                                        deliveryDate: selectedGlass.deliveryDate
                                            .toString(),
                                        orderDate:
                                            selectedGlass.orderDate.toString(),
                                        price: selectedGlass.price.toString(),
                                        deposit:
                                            selectedGlass.deposit.toString(),
                                        paymentMethod: selectedGlass
                                            .paymentMethod
                                            .toString(),
                                        paymentStatus: selectedGlass
                                            .paymentStatus
                                            .toString(),
                                        frame: selectedGlass.frame.toString(),
                                        lensType:
                                            selectedGlass.lensType.toString(),
                                        leftEye: selectedGlass.left.toString(),
                                        rightEye:
                                            selectedGlass.right.toString(),
                                        name: customer.name.toString(),
                                        address: customer.address.toString(),
                                        phone: customer.phone.toString(),
                                        idCustomer: widget.idCustomer,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              customer.name.toString(),
                              style: FontFamily.caption,
                            ),
                          ),
                          const TitleTextWIdget(name: 'Alamat'),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              customer.address.toString(),
                              style: FontFamily.caption,
                            ),
                          ),
                          const TitleTextWIdget(name: 'No Telepon'),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              customer.phone?.isNotEmpty == true
                                  ? customer.phone!
                                  : "-", // Jika phone ada, tampilkan, jika tidak, tampilkan "-"
                              style: FontFamily.caption,
                            ),
                          ),
                          if (_isExpanded &&
                              customer.glasses?.isNotEmpty == true) ...[
                            const SizedBox(height: 20.0),
                            const TitleTextWIdget(name: 'Nama Gagang(Frame)'),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                selectedGlass?.frame ?? 'Tidak tersedia',
                                style: FontFamily.caption,
                              ),
                            ),
                            const TitleTextWIdget(name: 'Jenis Kaca'),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                selectedGlass!.lensType ?? 'Tidak tersedia',
                                style: FontFamily.caption,
                              ),
                            ),
                            const TitleTextWIdget(name: 'Ukuran'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Left : ${selectedGlass.left ?? 'Tidak tersedia'}',
                                  style: FontFamily.caption,
                                ),
                                Text(
                                  'Right : ${selectedGlass.right ?? 'Tidak tersedia'}',
                                  style: FontFamily.caption,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            const TitleTextWIdget(name: 'Tanggal Pemesanan'),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                /// selected order date ubah ke format "dd MMMM yyyy"
                                selectedGlass.orderDate != null
                                    ? DateFormat('dd MMMM yyyy').format(
                                        DateTime.parse(
                                            selectedGlass.orderDate!))
                                    : 'Tidak tersedia',
                                style: FontFamily.caption,
                              ),
                            ),
                            const TitleTextWIdget(name: 'Tanggal Pengantaran'),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                /// selected order date ubah ke format "dd MMMM yyyy"
                                selectedGlass.deliveryDate != null
                                    ? DateFormat('dd MMMM yyyy').format(
                                        DateTime.parse(
                                            selectedGlass.deliveryDate!))
                                    : 'Tidak tersedia',
                                style: FontFamily.caption,
                              ),
                            ),
                            const TitleTextWIdget(name: 'Harga'),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                formatRupiah(selectedGlass.price ?? 0),
                                style: FontFamily.caption,
                              ),
                            ),
                            const TitleTextWIdget(name: 'Deposit(DP)'),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                formatRupiah(selectedGlass.deposit ?? 0),
                                style: FontFamily.caption,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: _toggleExpansion,
                          child: Text(
                            _isExpanded
                                ? 'Lihat lebih sedikit'
                                : 'Lihat selengkapnya',
                            style: FontFamily.titleForm
                                .copyWith(color: ColorStyle.secondaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Metode Pembayaran',
                          style: FontFamily.title.copyWith(
                              fontSize: 16, color: ColorStyle.primaryColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // buat apabila paymentMethodnya = Installment maka namanya "Angsuran" jika tidak "Cash" tetap "Cash"
                              selectedGlass.paymentMethod == 'Installments'
                                  ? 'Angsuran'
                                  : 'Cash',

                              style: FontFamily.titleForm.copyWith(
                                color: ColorStyle.textColors,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              selectedGlass.paymentStatus == 'Paid'
                                  ? 'Lunas'
                                  : 'Belum Lunas',
                              style: FontFamily.titleForm.copyWith(
                                color: selectedGlass.paymentStatus == 'Paid'
                                    ? ColorStyle.successColor
                                    : ColorStyle.errorColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          // ambil remaining dari installment terakhir yang ada di selectedGlass
                          //  'Sisa Pembayaran : {${ formatRupiah(selectedGlass.installments?.isNotEmpty ==
                          //           true
                          //       ? selectedGlass.installments?.last.remaining ?? 0
                          'Sisa Pembayaran : ${formatRupiah(selectedGlass.installments?.isNotEmpty == true ? selectedGlass.installments?.last.remaining ?? 0 : 0)}',

                          style: FontFamily.caption
                              .copyWith(color: ColorStyle.errorColor),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButtonWidget(
                        color: ColorStyle.primaryColor,
                        text: 'Lihat Pembayaran',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateTableAngsuran(
                                customerName: customer.name.toString(),
                                idCustomer: widget.idCustomer,
                                glassId: widget.idGlass,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
