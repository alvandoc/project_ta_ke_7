import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/viewmodels/category/category_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/no_data.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Kategori",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, RouterGenerator.routeCreateCategory),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: CategoryBody()
      ),
    );
  }
}

class CategoryBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _categoryList(),
        ],
      ),
    );
  }

  Widget _categoryList() {
    return Builder(
      builder: (context) {
        return Consumer<CategoryProvider>(
          builder: (context, categoryProv, _) {

            if (categoryProv.categoryList == null) {
              categoryProv.getAll();
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (categoryProv.categoryList.length == 0) {
              return NoData(
                text: "Belum ada kategori",
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryProv.categoryList.length,
              itemBuilder: (context, index) {

                var category = categoryProv.categoryList[index];
                return _categoryItem(category);
              },
            );
          },
        );
      },
    );
  }

  Widget _categoryItem(CategoryModel category) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: deviceWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  offset: Offset(0, 3),
                  blurRadius: 8,
                  spreadRadius: 1
                )
              ]
            ),
            child: Material(
              type: MaterialType.transparency,
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(30),
                                child: Icon(IconData(category.icon, fontFamily: "MaterialIcons"), color: Colors.white, size: 20)
                              )
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            category.name,
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 17)
                          )
                        ],
                      ),

                      Consumer<CategoryProvider>(
                        builder: (context, categoryProv, _) {
                          return Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => categoryProv.delete(category.id.toString(), context),
                                borderRadius: BorderRadius.circular(30),
                                child: Icon(Icons.delete, color: Colors.red)
                              )
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}