import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/Contacts.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;

    void showContactListBottomSheet(BuildContext context) {
      showModalBottomSheet(
        backgroundColor: Color(0xFF232323),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ContactListBottomSheet();
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //top nav bar with back button and title
          SizedBox(height: height*0.05,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //back button
                IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,),
                ),
                //title
                const Text("Send Money",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),),
                //empty icon button
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30,),
                ),
              ],
            ),
          ),
          SizedBox(height: height*0.03,),
          //add label for Send to
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text("Send to",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
          ),
          SizedBox(height: height*0.02,),
          //button to select the contact from the contact list
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: (){
                //call function which calls my contactmodalsheet from contact.dart
                showContactListBottomSheet(context);
              },
              child: Container(
                height: height*0.06,
                width: width*0.8,
                padding: EdgeInsets.symmetric(horizontal: width*0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //add icon for contact avatar
                    Icon(Icons.account_circle,
                      color: Colors.black,
                      size: 30,),

                    Text("Contact Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),),
                    //add icon for arrow
                    Icon(Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 30,),
                  ],
                ),
              ),
            ),
          ),



          SizedBox(height: height*0.05,),
          //add section From account containing the account name and account number , also the balance in the account of user
          //add label for From account
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text("From Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
          ),
          SizedBox(height: height*0.02,),
          //Rectangle containing the account name and account number , also the balance in the account of user
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Container(
              height: height*0.2,
              width: width*0.8,
              padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //add account name
                  Text("Account Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  //add account number
                  Text("Account Number",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  //add balance
                  Text("₹7899",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                ],
              ),
            ),
          ),
          SizedBox(height: height*0.05,),

          //add label for amount
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text("Amount",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
          ),
          // textfield with only number input for amount
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Allow only digits
              keyboardType: TextInputType.number, // Set the keyboard type to numeric
              decoration: InputDecoration(
                hintText: "Enter Amount",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height*0.05,),
          //add message text field
          //add label for Add message
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text("Add Message",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.1),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Add Message",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height*0.05,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.2, vertical: height*0.05),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width*0.7, height*0.06),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                ),
                onPressed:() => Navigator.pushReplacementNamed(context, '/progress') ,
                child: const Text("Send",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),)),
          ),
        ],
      ),
    );
  }

}
