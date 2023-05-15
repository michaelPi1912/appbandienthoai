import 'package:flutter/material.dart';


import '../model/productModel.dart';
import '../network/networkApi.dart';
import 'detaiProductPage.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, required this.query});

  String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String? query;

  late Future<List<Product>> _listSearch;

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    query =widget.query;
    setState(() {
      _listSearch = fetchSearchList(query!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Bạn muốn tìm kiếm sản phẩm nào ?",
                    fillColor: Colors.white70,
                  ),
                ),
              ),
              IconButton(onPressed: (){
                setState(() {
                  _listSearch = fetchSearchList(searchController.text);
                });
              }, icon: const Icon(Icons.search))
            ],
          ),
          SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  constraints: const BoxConstraints.expand(),
                  child: FutureBuilder(
                    future: _listSearch,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
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
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
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
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Khong tim thay ket qua"));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}