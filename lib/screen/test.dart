// import 'package:anugrah_lens/models/customers_model.dart';
// import 'package:anugrah_lens/services/customers_services.dart';
// import 'package:flutter/material.dart';


// class CustomersScreen extends StatefulWidget {
//   @override
//   _CustomersScreenState createState() => _CustomersScreenState();
// }

// class _CustomersScreenState extends State<CustomersScreen> {
//   late Future<CustomersModel> _customersFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Memanggil fetchFilteredMentors saat screen diinisialisasi
//     _customersFuture = CustomersServices().fetchFilteredCustomers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Daftar Pelanggan')),
//       body: FutureBuilder<CustomersModel>(
//         future: _customersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data?.customer == null) {
//             return Center(child: Text('Tidak ada pelanggan'));
//           }

//           // Mengambil daftar pelanggan
//           List<Customer> customers = snapshot.data!.customer!;

//           return ListView.builder(
//             itemCount: customers.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(customers[index].name ?? 'Nama tidak tersedia'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
