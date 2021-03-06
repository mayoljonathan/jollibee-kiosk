import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/ui_helper.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/ui/widgets/item_grid.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/my_cart.dart';
import 'package:jollibee_kiosk/ui/widgets/menu_list.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  MenuModel _model;

  @override
  void dispose() {
    super.dispose();
    locator<MyCartModel>().clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this._onBackToHomeTap,
      child: BaseView<MenuModel>(
        onModelReady: (model) {
          _model = model;
          _model.setInitialSelectedMenu(context);
        },
        builder: (context, model, child) {
          print('home view build');
          return SafeArea(
            child: Scaffold(
              backgroundColor: kCanvasColor,
              body: _buildBody(),
              bottomNavigationBar: MyCart(),
            ),
          );
        }
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Hero(
        //   tag: 'header-title',
        //   child: Material(
        //     color: Colors.transparent,
        //     child: _buildHeader()
        //   )
        // ),
        _buildHeader(),
        Divider(height: 1.0),
        Expanded(
          child: Row(
            children: <Widget>[
              MenuList(),
              Expanded(child: ItemGrid())     
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            width: SizeConfig.blockSizeHorizontal * 20,
            child: Hero(
              tag: 'jollibee_logo',
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/jollibee_icon.png'),
              )
            ),
          ),
          Expanded(
            child: Text(_model?.selectedMenu?.name ?? '' , style: TextStyle(
              fontSize: kTitleTextSize,
              fontWeight: FontWeight.bold
            )),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            child: FittedBox(
              child: CustomBouncingContainer(
                onTap: this._onBackToHomeTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: kRed,
                  ),
                  padding: const EdgeInsets.all(18.0),
                  child: Text('Back to Home', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kActionButtonTextSize,
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ),
            ),
          )
        ],
      )
    );
  }

  Future<bool> _onBackToHomeTap() async {
    bool shouldPrompt = locator<MyCartModel>().items.length > 0;
    if (!shouldPrompt) {
      Navigator.of(context).pushNamedAndRemoveUntil('/entry', (Route<dynamic> route) => false);
      return false;
    }

    UIHelper().showConfirmDialog(
      context: context, 
      title: 'Discard your current order?',
      message: 'You have items in your current order, do you want to discard and go back to home screen?',
      cancelText: "CONTINUE ORDERING",
      cancelColor: kGreen,
      confirmText: 'DISCARD',
      confirmColor: kRed,
      onConfirm: () => Navigator.of(context).pushNamedAndRemoveUntil('/entry', (Route<dynamic> route) => false)
    );

    return false;
  }
  
}