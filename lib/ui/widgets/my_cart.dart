import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';

import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/order_total.dart';
import 'package:provider/provider.dart';

import 'my_order_list.dart';

class MyCart extends StatelessWidget {
  MyCart({Key key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 32,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(40.0, 20.0),
            topRight: Radius.elliptical(40.0, 20.0),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5.0),
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1, 
              blurRadius: 12.0,
            )
          ],
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListenableProvider(
            builder: (BuildContext context) => locator<MyCartModel>(),
            child: Consumer<MyCartModel>(
              builder: (context, model, child) {
                return Hero(
                  tag: 'order-title',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(model.getMyOrderTitle(), style: TextStyle(
                      fontSize: kSubheadTextSize,
                      fontWeight: FontWeight.w500
                    )),
                  ),
                );
              }
            )
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: MyOrderList(animatedListKeyIndex: 0)
                ),
                Expanded(
                  flex: 2,
                  child: _buildRightLayout()
                )    
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildRightLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(child: OrderTotal()),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
        ListenableProvider(
          builder: (BuildContext context) => locator<MyCartModel>(),
          child: Consumer<MyCartModel>(
            builder: (context, model, child) => CustomBouncingContainer(
              onTap: () => this._onReviewOrderTap(context),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Provider.of<MyCartModel>(context).items.length == 0 ? kGrey : kGreen,
                ),
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text('Review Order', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: kActionButtonTextSize,
                    fontWeight: FontWeight.bold
                  )
                )
              )
            )
          )
        )
      ],
    );    
  }

  void _onReviewOrderTap(context) {
    if (Provider.of<MyCartModel>(context).items.length == 0) return;

    Navigator.pushNamed(context, '/review-order');
  }
}