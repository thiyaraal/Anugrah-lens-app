import 'package:anugrah_lens/models/customers_model.dart';
import 'package:anugrah_lens/screen/angsuran/menu_angsuran.dart';
import 'package:anugrah_lens/screen/form-screen/create_new_angsuran.dart';
import 'package:anugrah_lens/screen/home/bottom_screen.dart';
import 'package:anugrah_lens/screen/login/login_screen.dart';
import 'package:anugrah_lens/services/customer_services.dart';

import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:anugrah_lens/widget/card.dart';
import 'package:anugrah_lens/widget/floating_action_button_widget.dart';
import 'package:anugrah_lens/widget/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BerandaPageScreen extends StatefulWidget {
  final Function(bool)? onDrawerChanged; // Tambahkan callback
  BerandaPageScreen({Key? key, this.onDrawerChanged}) : super(key: key);

  @override
  State<BerandaPageScreen> createState() => _BerandaPageScreenState();
}

class _BerandaPageScreenState extends State<BerandaPageScreen> {
  final CostumersService _costumersService = CostumersService();
  // panggil delete customer service
  final TextEditingController name = TextEditingController();

  String? _photoUrl;
  String? _firstName;
  String? _email;
  String? _name;

  CustomersModel? _customersData; // Menyimpan data pelanggan
  bool _isLoading = true; // Menyimpan state loading

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "";
      _firstName = _name?.split(' ')[0]; // Ambil bagian pertama (nama depan)
      _photoUrl = prefs.getString('photoUrl') ?? "";
      _email = prefs.getString('email') ?? "";
    });
  }

  Future<void> _fetchCustomers() async {
    try {
      final customersData = await _costumersService.fetchCustomers();
      setState(() {
        _customersData = customersData;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _customersData = null;
        _isLoading = false;
      });
      showTopSnackBar(
        context,
        'Gagal memuat data pelanggan',
        backgroundColor: ColorStyle.errorColor,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _fetchCustomers();
  }

  // preferensi pengguna

  Future<void> _showSignOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Dialog tidak dapat ditutup dengan tap di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi',
              style: FontFamily.title.copyWith(color: ColorStyle.primaryColor)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin keluar dari aplikasi ini?',
                    style: FontFamily.caption),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal',
                  style: FontFamily.caption
                      .copyWith(color: ColorStyle.primaryColor)),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog tanpa logout
              },
            ),
            TextButton(
              child: Text('Keluar',
                  style: FontFamily.caption
                      .copyWith(color: ColorStyle.errorColor)),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                _handleSignOut(); // Panggil fungsi logout
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignOut() async {
    try {
      // Logout dari Firebase
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      // Hapus data dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Redirect ke layar login
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Sign out failed: $error');
      showTopSnackBar(
        context,
        'Gagal keluar, silakan coba lagi',
        backgroundColor: ColorStyle.errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.whiteColors,
      appBar: AppBar(
        backgroundColor: ColorStyle.whiteColors,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 20, // You can adjust the height as needed
                child: Image.asset(
                  'assets/images/AnugrahLensLogo.png',
                  fit: BoxFit.contain, // Ensures the image scales properly
                ),
              ),
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: FontFamily.titleForm
                        .copyWith(color: ColorStyle.primaryColor),
                  ),
                  TextSpan(
                    text: _firstName ?? '',
                    style: FontFamily.titleForm
                        .copyWith(color: ColorStyle.secondaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorStyle.primaryColor, // Adjust the color as needed
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    // get from shared preferences
                    backgroundImage: NetworkImage(_photoUrl ??
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                  ),
                  const SizedBox(
                      width: 16), // Space between the picture and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _firstName.toString(),
                        style: FontFamily.titleForm.copyWith(
                          color: ColorStyle.whiteColors,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8), // Space between name and email
                      Flexible(
                        child: Text(
                          _email.toString(),
                          style: FontFamily.caption
                              .copyWith(color: ColorStyle.whiteColors),
                          softWrap: true, // Allow text to wrap to the next line
                          overflow: TextOverflow
                              .visible, // Ensure text visibility without clipping
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: ColorStyle.primaryColor),
              title: Text('Beranda',
                  style: FontFamily.caption
                      .copyWith(color: ColorStyle.primaryColor)),
              onTap: () {
                // Redirect to the Beranda screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.history, color: ColorStyle.primaryColor),
              title: Text('Riwayat',
                  style: FontFamily.caption
                      .copyWith(color: ColorStyle.primaryColor)),
              onTap: () {
                // Navigate to the Riwayat screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirstScreen(
                            activeScreen: 1,
                          )),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            const SizedBox(
              height: 200.0,
            ),
            ListTile(
              leading:
                  const Icon(Icons.exit_to_app, color: ColorStyle.primaryColor),
              title: Text('Keluar',
                  style: FontFamily.caption
                      .copyWith(color: ColorStyle.primaryColor)),
              onTap: () {
                // Tampilkan dialog konfirmasi sebelum logout
                _showSignOutDialog();
              },
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: true,
      onDrawerChanged: (isOpen) {
        setState(() {
          if (widget.onDrawerChanged != null) {
            widget.onDrawerChanged!(
                isOpen); // Panggil callback untuk kirim status drawer
          }
        });
      },
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true; // Show loading indicator while refreshing
          });
          await _fetchCustomers(); // Attempt to fetch new data
          setState(() {
            _isLoading = false; // Hide loading indicator after fetching
          });
        },
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<CustomersModel>(
                future: _costumersService.fetchCustomers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Gagal memuat data pelanggan',
                              style: FontFamily.caption),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading =
                                    true; // Show loading indicator when retrying
                              });
                              await _fetchCustomers(); // Retry fetching data
                              setState(() {
                                _isLoading =
                                    false; // Hide loading indicator after retry
                              });
                            },
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Ensure data is loaded
                  if (!snapshot.hasData || snapshot.data!.customer == null) {
                    return const Center(
                      child: Text(
                        'Tidak ada data pelanggan tersedia',
                        style: FontFamily.caption,
                      ),
                    );
                  }

                  // Mengambil daftar pelanggan

                  List<Customer> customers = snapshot.data!.customer!;

                  // Filter pelanggan dengan paymentStatus 'Unpaid'

                  List<Customer> unpaidCustomers = customers
                      .where((element) => element.glasses!
                          .any((glass) => glass.paymentStatus == 'Unpaid'))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        SearchDropdownFieldHome(
                          onSelected: (String selectedName) {
                            // Memastikan navigasi hanya terjadi jika nama dipilih dari dropdown
                            Customer? selectedCustomer = customers.firstWhere(
                                (element) => element.name == selectedName);

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
                              color: ColorStyle.primaryColor),
                          suffixIcons: null,
                          controller: name,
                          hintText: 'cari nama pelanggan',
                          items: customers.map((e) => e.name ?? '').toList(),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Text('Pelanggan yang belum membayar',
                              style: FontFamily.title.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              )),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: unpaidCustomers.length,
                            itemBuilder: (context, index) {
                              final customer = unpaidCustomers[index];

                              // Select the first glass if it exists
                              Glass? selectedGlass =
                                  customer.glasses?.isNotEmpty == true
                                      ? customer.glasses!.first
                                      : null;

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Dismissible(
                                  key: ValueKey(customer.id ??
                                      index), // Ensure unique key
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  onDismissed: (direction) async {
                                    final response = await _costumersService
                                        .deleteCustomer(customer.id ?? '');

                                    // Menentukan warna berdasarkan status respon
                                    Color snackBarColor;
                                    String message;

                                    if (response['error'] == true) {
                                      // Jika error
                                      snackBarColor = ColorStyle
                                          .errorColor; // Merah untuk error
                                      message = response['message'] ??
                                          'Customer not found or failed to delete.';

                                      // Kembalikan item yang dihapus ke dalam list
                                      setState(() {
                                        unpaidCustomers.insert(index, customer);
                                      });
                                    } else {
                                      snackBarColor = Colors
                                          .green; // Hijau untuk keberhasilan
                                      message =
                                          'Customer ${customer.name} has been successfully deleted.';
                                    }

                                    // Tampilkan SnackBar dengan warna yang sesuai menggunakan showTopSnackBar
                                    showTopSnackBar(
                                      context,
                                      message,
                                      backgroundColor: snackBarColor,
                                      duration: const Duration(seconds: 3),
                                    );
                                  },
                                  confirmDismiss: (direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Konfirmasi"),
                                          content: const Text(
                                              "Apakah Anda yakin ingin menghapus pelanggan ini?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("Batal"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text("Hapus"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: CardNameWidget(
                                    onPressed: () {
                                      if (selectedGlass != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MenuAngsuranScreen(
                                              idCustomer: customer.id ?? '',
                                              customerName: customer.name ?? '',
                                            ),
                                          ),
                                        );
                                      } else {
                                        showTopSnackBar(
                                          context,
                                          'Pelanggan belum memiliki kacamata',
                                          backgroundColor:
                                              ColorStyle.errorColor,
                                        );
                                      }
                                    },
                                    name:
                                        customer.name ?? 'Nama tidak tersedia',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: SizedBox(
        height: 72,
        width: 72,
        child: CustomFloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateNewAngsuranScreen(),
                ));
          },
          icon: Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            bottom: MediaQuery.of(context).size.height - 120,
            left: 10,
            right: 10,
            top: 10
            ),
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
