import 'package:distributer_application/auth/showErrDialog.dart';
import 'package:distributer_application/screens/products/all_products_page.dart';
import 'package:flutter/material.dart';

class DynamicExpansionTileList extends StatelessWidget {
  final List<dynamic> categoryList;
  final String userStatus;
  final Function refresh;
  final int cartItemCount;

  DynamicExpansionTileList(this.categoryList, this.userStatus, this.refresh, this.cartItemCount);

  List<Widget> getTiles() {
    print(categoryList);
    List<Widget> children = [];
    categoryList.forEach((element) {
      if (element['subcategories'] == null) {
        children.add(
          DynamicExpansionTile(element['id'], element['name'], userStatus, refresh, cartItemCount),
        );
      } else {
        children.add(
          DynamicExpansionTileWithSubcategories(element['id'], element['name'],
              element['subcategories'], userStatus, refresh, cartItemCount),
        );
      }
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getTiles(),
    );
  }
}

//without subcategories
class DynamicExpansionTile extends StatefulWidget {
  final String id, category, userStatus;
  final Function refresh;
  final int cartItemCount;

  DynamicExpansionTile(this.id, this.category, this.userStatus, this.refresh, this.cartItemCount);

  @override
  State createState() => DynamicExpansionTileState();
}

class DynamicExpansionTileState extends State<DynamicExpansionTile> {

  @override
  void initState() {
    super.initState();
  }

  void navigate(pageRoute) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => pageRoute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(Icons.dashboard_customize),
      title: Text(widget.category),
      trailing: Icon(Icons.chevron_right_rounded),
      onTap: () {
        widget.userStatus == '0'
            ? showInfoDialog(context, 'You are not verified by admin.')
            : navigate(
                AllProductsPage(
                  categoryId: widget.id,
                  categoryName: widget.category,
                  refresh:  widget.refresh,
                    cartItemCount: widget.cartItemCount,
                ),
              );
      },
    );
  }
}

//with subcategories
class DynamicExpansionTileWithSubcategories extends StatefulWidget {
  final String category;
  final List<dynamic> subcategories;
  final String id;

  final String userStatus;
  final Function refresh;
  final int cartItemCount;

  DynamicExpansionTileWithSubcategories(
      this.id, this.category, this.subcategories, this.userStatus, this.refresh, this.cartItemCount);

  @override
  State createState() => DynamicExpansionTileWithSubcategoriesState();
}

class DynamicExpansionTileWithSubcategoriesState
    extends State<DynamicExpansionTileWithSubcategories> {

  @override
  void initState() {
    super.initState();
  }

  void navigate(pageRoute) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => pageRoute,
      ),
    );
  }

  List<Widget> getSubcategoriesTile() {
    List<Widget> children = [];
    widget.subcategories.forEach((element) {
      print(element);
      children.add(
        ListTile(
          // leading: Icon(Icons.dashboard_customize),
          title: Text(element['name']),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () {
            widget.userStatus == '0'
                ? showInfoDialog(context, 'You are not verified by admin.')
                : navigate(
                    AllProductsPage(
                      categoryId: element['sub_id'],
                      categoryName: element['name'],
                      refresh:  widget.refresh,
                        cartItemCount: widget.cartItemCount,
                    ),
                  );
          },
        ),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // leading: Icon(Icons.category_outlined),
      title: Text(widget.category),
      children: getSubcategoriesTile(),
    );
  }
}
