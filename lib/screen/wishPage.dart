import 'package:flutter/material.dart';


import '../network/networkApi.dart';
import '../variable.dart';
import 'detaiProductPage.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Container(
            child: FutureBuilder(
                    future: fetchWishList(token!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => detailProduct(
                                              product: snapshot.data![index],
                                            )));
                              },
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.network(
                                                snapshot.data![index].image.toString(),
                                                width: double.infinity,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "${snapshot.data![index].discount}% OFF",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data![index].name.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 10,),
                                          Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                  text: snapshot.data![index].description.toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "\$${snapshot.data![index].price.toString()}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ),
        ),
      ]),
    );
  }
}