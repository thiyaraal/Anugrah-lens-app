import 'package:anugrah_lens/models/customers_model.dart';
import 'package:anugrah_lens/screen/home/bottom_screen.dart';
import 'package:anugrah_lens/services/customer_services.dart';
import 'package:anugrah_lens/services/edit_custumers.dart';
import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:anugrah_lens/widget/Button_widget.dart';
import 'package:anugrah_lens/widget/radio_button_widget.dart';
import 'package:anugrah_lens/widget/text_widget.dart';
import 'package:anugrah_lens/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDataCustomersScreen extends StatefulWidget {
  final String glassId;
  final String idCustomer;
  final String name;
  final String phone;
  final String address;
  final String frame;
  final String lensType;
  final String leftEye;
  final String rightEye;
  final String price;
  final String deposit;
  final String orderDate;
  final String deliveryDate;
  final String paymentStatus;
  final String paymentMethod;

  EditDataCustomersScreen({
    Key? key,
    required this.glassId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryDate,
    required this.orderDate,
    required this.deposit,
    required this.price,
    required this.rightEye,
    required this.leftEye,
    required this.lensType,
    required this.frame,
    required this.phone,
    required this.address,
    required this.idCustomer,
    required this.name,
  }) : super(key: key);

  @override
  State<EditDataCustomersScreen> createState() =>
      _EditDataCustomersScreenState();
}

class _EditDataCustomersScreenState extends State<EditDataCustomersScreen> {
  final _formKey = GlobalKey<FormState>();

  ///////////////////////////////////////////////////////////////////////////
  late TextEditingController name = TextEditingController();
  // Controllers untuk mengelola input dari form
  late TextEditingController nameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController frameController = TextEditingController();
  late TextEditingController lensTypeController = TextEditingController();
  late TextEditingController leftEyeController = TextEditingController();
  late TextEditingController rightEyeController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController depositController = TextEditingController();
  late TextEditingController orderDateController = TextEditingController();
  late TextEditingController deliveryDateController = TextEditingController();
  late TextEditingController paymentMethodController = TextEditingController();

  // Untuk menampilkan dialog date picker
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  final CostumersService _costumersService =
      CostumersService(); // Instance of your service
  List<Customer> customers = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers(); // Fetch data saat inisialisasi
    // Format tanggal sebelum ditampilkan di UI
    if (widget.orderDate.isNotEmpty) {
      DateTime parsedOrderDate = DateTime.parse(widget.orderDate);
      orderDateController.text =
          DateFormat('dd MMMM yyyy').format(parsedOrderDate);
    }
    if (widget.deliveryDate.isNotEmpty) {
      DateTime parsedDeliveryDate = DateTime.parse(widget.deliveryDate);
      deliveryDateController.text =
          DateFormat('dd MMMM yyyy').format(parsedDeliveryDate);
    }

    nameController.text = widget.name;
    phoneController.text = widget.phone;
    addressController.text = widget.address;
    frameController.text = widget.frame;
    lensTypeController.text = widget.lensType;
    leftEyeController.text = widget.leftEye;
    rightEyeController.text = widget.rightEye;
    priceController.text = widget.price;
    depositController.text = widget.deposit;
    // orderDateController.text = widget.orderDate;
    // deliveryDateController.text = widget.deliveryDate;
    paymentMethodController.text =
        widget.paymentMethod; // Pastikan terisi di sini
    // Debugging untuk melihat nilai yang diambil
    print('Payment Method dari initState: ${widget.paymentMethod}');
    print('Payment Method Controller Text: ${paymentMethodController.text}');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    frameController.dispose();
    lensTypeController.dispose();
    leftEyeController.dispose();
    rightEyeController.dispose();
    priceController.dispose();
    depositController.dispose();
    orderDateController.dispose();
    deliveryDateController.dispose();
    super.dispose();
  }

/////
  // Fetch data customers
  Future<void> _fetchCustomers() async {
    try {
      final fetchedCustomers = await _costumersService.fetchCustomers();
      setState(() {
        customers =
            fetchedCustomers.customer ?? []; // Simpan daftar pelanggan di state
      });
    } catch (error) {
      showTopSnackBar(
        context,
        'Gagal mengambil data pelanggan: $error',
        backgroundColor: ColorStyle.errorColor,
      );
    }
  }

  // Log data yang akan dikirim untuk membantu debugging
  void _logData() {
    print({
      'idCustomer': widget.idCustomer,
      'glassId': widget.glassId,
      'name': nameController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'frame': frameController.text,
      'lensType': lensTypeController.text,
      'left': leftEyeController.text,
      'right': rightEyeController.text,
      'price': priceController.text,
      'deposit': depositController.text,
      'orderDate': orderDateController.text,
      'deliveryDate': deliveryDateController.text,
      'paymentMethod': paymentMethodController.text,
    });
  }

  Future<void> _updateCustomer() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        _logData();

        final BigInt price =
            BigInt.parse(priceController.text.replaceAll('.', ''));
        final BigInt deposit =
            BigInt.parse(depositController.text.replaceAll('.', ''));
        DateTime selectedOrderDate =
            DateFormat('dd MMMM yyyy').parse(orderDateController.text).toUtc();
        String formattedOrderDate = selectedOrderDate.toIso8601String();

        DateTime selectedDeliveryDate = DateFormat('dd MMMM yyyy')
            .parse(deliveryDateController.text)
            .toUtc();
        String formattedDeliveryDate = selectedDeliveryDate.toIso8601String();

        print('Sending update request...');

        await CustomersService().updateCustomer(
          idCustomer: widget.idCustomer,
          glassId: widget.glassId,
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          frame: frameController.text,
          lensType: lensTypeController.text,
          left: leftEyeController.text,
          right: rightEyeController.text,
          price: price.toInt(),
          deposit: deposit.toInt(),
          orderDate: formattedOrderDate,
          deliveryDate: formattedDeliveryDate,
          paymentMethod: paymentMethodController.text,
          paymentStatus: widget.paymentStatus,
        );

        print('Update successful!');

        // // Tampilkan SnackBar sebelum navigasi
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Data pelanggan berhasil diperbarui'),
        //     backgroundColor: ColorStyle.primaryColor,
        //   ),
        // );

        // Tambahkan delay sebelum navigasi
        await Future.delayed(Duration(seconds: 2));

        // Lakukan navigasi setelah SnackBar ditampilkan
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const FirstScreen(
              activeScreen: 0,
            ),
          ),
          (route) => false,
        );
      } catch (error) {
        print('Error updating customer: $error');

        // Tampilkan SnackBar jika ada error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memperbarui data pelanggan: $error'),
            backgroundColor: ColorStyle.errorColor,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('Form validation failed');
    }
  }

  String? selectedName;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pelanggan Baru',
            style: TextStyle(color: ColorStyle.secondaryColor)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextWIdget(
                    name: 'Nama',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),

                  const TitleTextWIdget(
                    name: 'Alamat',
                  ),
                  const SizedBox(height: 4.0),

                  TextFormFieldWidget(
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const TitleTextWIdget(
                    name: 'No Telepon',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No Telepon tidak boleh kosong';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Harap masukkan nomor yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  const TitleTextWIdget(
                    name: 'Frame',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    controller: frameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Frame tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const TitleTextWIdget(
                    name: 'Jenis Lensa',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    controller: lensTypeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jenis Lensa tidak boleh kosong';
                      }
                      return null;
                    },
                  ),

                  const TitleTextWIdget(
                    name: 'Ukuran',
                  ),
                  const SizedBox(height: 4.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Right',
                            style: FontFamily.caption
                                .copyWith(color: ColorStyle.secondaryColor),
                          ),
                          TextFormFieldWidget(
                            width: 100,
                            controller: rightEyeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Harus diisi';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Left',
                            style: FontFamily.caption
                                .copyWith(color: ColorStyle.secondaryColor),
                          ),
                          const SizedBox(height: 4.0),
                          TextFormFieldWidget(
                            width: 100,
                            controller: leftEyeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Harus diisi';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  const TitleTextWIdget(
                    name: 'Harga',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    inputFormatters: [CurrencyInputFormatter()],
                    controller: priceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga tidak ';
                      }
                      return null;
                    },
                  ),

                  const TitleTextWIdget(
                    name: 'Deposit(DP)',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    inputFormatters: [CurrencyInputFormatter()],
                    controller: depositController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Uang Muka tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  const TitleTextWIdget(
                    name: 'Tanggal Pemesanan',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    controller: orderDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, orderDateController),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal Order tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const TitleTextWIdget(
                    name: 'Tanggal Pengiriman',
                  ),
                  const SizedBox(height: 4.0),
                  TextFormFieldWidget(
                    controller: deliveryDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, deliveryDateController),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal Pengiriman tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const TitleTextWIdget(
                    name: 'Metode Pembayaran',
                  ),
                  const SizedBox(height: 4.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RadioButtonWidget(
                          value: 'Cash',
                          groupValue: paymentMethodController
                              .text, // Ini harus cocok dengan value dari widget
                          text: 'Tunai',
                          onChanged: (String? value) {
                            setState(() {
                              paymentMethodController.text = value!;
                            });
                          },
                        ),
                        RadioButtonWidget(
                          value: 'Installments',
                          groupValue: paymentMethodController
                              .text, // Pastikan ini bekerja
                          text: 'Angsuran',
                          onChanged: (String? value) {
                            setState(() {
                              paymentMethodController.text = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  // Add more fields as necessary for other attributes (deliveryDate, price, etc.)
                  ElevatedButtonWidget(
                      isLoading: isLoading,
                      text: 'Simpan',
                      onPressed: _updateCustomer),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
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
