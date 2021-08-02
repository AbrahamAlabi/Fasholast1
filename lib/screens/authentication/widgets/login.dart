import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasholast1/constants/controllers.dart';
import 'package:fasholast1/widgets/custom_btn.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
boxShadow: [
  BoxShadow(
    color: Colors.grey.withOpacity(.5),
    blurRadius: 10,

  )
],
borderRadius: BorderRadius.circular(20)
      ),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.withOpacity(.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: TextFormField(
                    controller: authController.email,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email_outlined),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: "Email"),
                      validator:(String value){

                      if(!value.contains('@')){
                        return 'Please enter a valid email';
                      }
                      return null;
                      },

                  ),

                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.withOpacity(.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: TextField(
                    controller: authController.password,
                    obscureText: true,
                    decoration: InputDecoration(

                        icon: Icon(Icons.lock),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: "Password"),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: CustomButton(
                text: "Login", onTap: (){
                  authController.signIn();
            }),
          )
        ],
      ),
    );
  }
}