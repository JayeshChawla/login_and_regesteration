//
//  RegisterationScreen.swift
//  Login_And_Register
//
//  Created by MACPC on 07/03/24.
//

import SwiftUI

struct RegisterationScreen: View {
    
    @FocusState var field : FocusedField?
    
    @State var emailText = ""
    @State var passwordText = ""
    @State var ConfoirmPassword = ""
    
    @State var isValidEmail  = true
    @State var isValidPassword = true
    @State var isValidConfoirmPassword = true
   
    
    @State var ForgotPassword : Bool = false
    
    @State var HomeScreen = false
    
    @State var Google  : Bool = false
    @State var Facebook  : Bool = false
    @State var Apple : Bool = false
    
    @Environment(\.presentationMode) var presentation
    
    var canProceed : Bool{
        Validator.validateEmail(emailText) && Validator.validatePassword(passwordText)
    }
    var body: some View {
        NavigationView{
           ScrollView {
                VStack{
                    
                    
                    HStack {
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(Color("blueColor"))
                                .imageScale(.large)
                        }
                        .padding()
                        Spacer()
                    }
                 
                        
                   Text("Create Account")
                        .foregroundColor(Color("blueColor"))
                        .font(.system(size: 30, weight: .bold))
                        .padding(.bottom)
                     
                    Text("Create an account so you can explore all \n the existing jobs")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.bottom ,48)
                        
                   EmailTextView(emailText: $emailText, isValidEmail: $isValidEmail)
                    
                    PasswordTextView(passwordText: $passwordText, isValidPassword: $isValidPassword, errorText: "Password is not valid", placeholder: "Password", isValidatorPassword: Validator.validatePassword)
                    
                    PasswordTextView(passwordText: $ConfoirmPassword, isValidPassword: $isValidConfoirmPassword, errorText: "Password is not matching", placeholder: "Confoirm Password", isValidatorPassword : Confoirmpasswordd)
                    
                   
                    NavigationLink(destination: RegisterationScreen(), isActive: $HomeScreen, label: {
                        Text("Sign up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth : .infinity)
                            .frame(height : 61)
                            .background(Color("blueColor"))
                            .cornerRadius(10)
                    })
                        .padding(.vertical)
                        .padding(.horizontal)
                        .opacity(canProceed ? 1.0 : 0.5)
                        .disabled(!canProceed)
                    
                    NavigationLink(destination: RegisterationScreen(), isActive: $HomeScreen, label: {
                        Text("Already have an Account")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    })
                        .padding()
                        .padding(.bottom , 80)
                    
                    bottomView(Google: $Google, Facebook: $Facebook, Apple: $Apple)
                        
                }
               
//
               
               
                
           }
         
           .navigationBarHidden(true)
//
        
           
        }
        .navigationBarHidden(true)
    }
    func Confoirmpasswordd(_ password : String) -> Bool{
        passwordText == password
    }
    }


struct RegisterationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationScreen()
    }
}



//Confoirm Password
struct ConfoirmPasswordTextVieww : View{
    @Binding var ConfoirmPassword : String
    @Binding var isConfoirmPassword: Bool
    
    
    @FocusState var field : FocusedField?
    
    
    
    var body: some View{
        VStack{
            SecureField("Confoirm Password", text: $ConfoirmPassword)
                .focused($field , equals: .email)
                .padding()
                .background(Color("secondaryColor"))
                .cornerRadius(10)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(!isConfoirmPassword ? .red : field == .password ?  Color("blueColor") : .white , lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: ConfoirmPassword) { newValue in
                    isConfoirmPassword = Validator.validatePassword(newValue)
                }
                .padding(.bottom , isConfoirmPassword ? 16 : 0)
            if !isConfoirmPassword{
                HStack{
                    Text("Password must should be atleat one Large character , one special character and one number")
                        .foregroundColor(.red)
                        .padding(.leading)
                }
            }
        }
    }
}

