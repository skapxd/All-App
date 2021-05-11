import 'package:allapp/src/data/shared/pref.dart';
import 'package:allapp/src/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'bloc/menu_bloc.dart';

class Menu extends StatelessWidget {
  final String nombre = Pref().nombe;

  @override
  Widget build(BuildContext context) {
    final List<String> phoneTemp = Pref().phone.substring(3, 13).split('');
    phoneTemp.insert(3, ' ');
    phoneTemp.insert(7, ' ');

    String phone = phoneTemp.join();

    // View Width
    final double vw = MediaQuery.of(context).size.width;
    // View Height
    final double vh = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        print('Tap in profile');
        showMaterialModalBottomSheet(
          context: context,
          backgroundColor: rgbColor(0, 0, 0, 0),
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: vw * 0.07),
                width: vw * 0.9,
                height: vh * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(vw * .05),
                  color: hexaColor('#303030'),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: vw * 0.2,
                    ),
                    Row(
                      children: [
                        Container(
                          height: vw * 0.17,
                          width: vw * 0.17,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(vw),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: vw * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<MenuBloc, MenuState>(
                                builder: (context, state) {
                                  return Container(
                                    child: Text(
                                      state.nombre,
                                      // this.nombre,
                                      style: TextStyle(
                                        color: hexaColor('#A3A3A3'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                child: Text(
                                  phone,
                                  style: TextStyle(
                                    color: hexaColor('#A3A3A3'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: hexaColor('#E6D29F'),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: rgbColor(0, 0, 0, 0),
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.only(
                                    top: vw * 0.07,
                                    left: vw * 0.07,
                                    right: vw * 0.07,
                                  ),
                                  height: vh * 0.3,
                                  decoration: BoxDecoration(
                                    color: hexaColor('#333333'),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(vw * 0.05),
                                      topRight: Radius.circular(vw * 0.05),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Escribe tu nombre',
                                          style: TextStyle(
                                            color: hexaColor('#FFFFFF'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: vw * 0.01,
                                      ),
                                      TextField(
                                        onChanged: (value) {
                                          BlocProvider.of<MenuBloc>(context)
                                              .add(AddMenuName(value));
                                          // Pref().nombe = value;
                                        },
                                        style: TextStyle(color: Colors.white),
                                        maxLength: 21,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: hexaColor('#E6D29F'),
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: hexaColor('#E6D29F'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: hexaColor('#E6E6E6'),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(
          Pref().phone.split('')[12],
          style: TextStyle(
            color: hexaColor('#383838'),
          ),
        ),
      ),
    );
  }
}
