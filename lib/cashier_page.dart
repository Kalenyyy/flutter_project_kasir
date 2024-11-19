import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/1.jpg",
      "name": "Nasi Goreng",
      "price": 30000,
      "stock": 20,
      "quantity": 0
    },
    {
      "image": "assets/images/2.jpg",
      "name": "Nasi Bakar",
      "price": 10000,
      "stock": 5,
      "quantity": 0
    },
    {
      "image": "assets/images/3.jpg",
      "name": "Nasi Rebus",
      "price": 50000,
      "stock": 13,
      "quantity": 0
    },
    {
      "image": "assets/images/4.jpg",
      "name": "Nasi Basi",
      "price": 20000,
      "stock": 0,
      "quantity": 0
    }
  ];

  int _totalItem = 0;
  int _totalHarga = 0;

  Future<void> _TambahItemBeli(int index) async {
    setState(() {
      if (products[index]["stock"] > 0) {
        products[index]["stock"]--;
        products[index]["quantity"] = (products[index]["quantity"] ?? 0) + 1;
        _totalItem++;
        _totalHarga += products[index]["price"] as int;
      }
    });
  }

  Future<void> _KurangiItemBeli(int index) async {
    setState(() {
      if (products[index]["quantity"] > 0) {
        products[index]["stock"]++;
        products[index]["quantity"] = (products[index]["quantity"] ?? 0) - 1;
        _totalItem--;
        _totalHarga -= products[index]["price"] as int;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Stock Maksimal"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cashier App",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Text(
                    "Semoga Harimu Menyenangkan :)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: 'Cari produk....',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "${products[index]['image']}",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                        ),
                                        color: const Color.fromRGBO(
                                            189, 189, 189, 1),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${products[index]['name']}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "Stock: ${products[index]['stock']} pcs",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                            ],
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                              locale:
                                                  'id', // untuk lokal Indonesia
                                              symbol: 'Rp', // simbol Rupiah
                                              decimalDigits:
                                                  0, // jumlah angka desimal
                                            ).format(products[index]['price']),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible:
                                            products[index]['quantity'] > 0,
                                        child: GestureDetector(
                                            onTap: () {
                                              if (products[index]['quantity'] >
                                                  0) {
                                                _KurangiItemBeli(index);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                    "Stock Sudah Mencapai Maksimal",
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ));
                                              }
                                            },
                                            child: const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Icon(
                                                Icons
                                                    .remove_circle_outline_rounded,
                                                color: Color.fromRGBO(
                                                    239, 83, 80, 1),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Center(
                                          child: Visibility(
                                            visible:
                                                products[index]['quantity'] > 0,
                                            child: Text(
                                              "${products[index]['quantity']}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Tombol hanya muncul jika stok > 0
                                        GestureDetector(
                                          onTap: () {
                                            if (products[index]['stock'] > 0) {
                                              _TambahItemBeli(index);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text("Stock Kosong"),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: const SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Icon(
                                              Icons.add_circle_outline_rounded,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                    
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total ($_totalItem Item) = ${NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(_totalHarga)}",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
