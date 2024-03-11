//
//  LoginScreen.swift
//  Login_And_Register
//
//  Created by MACPC on 07/03/24.
//

import SwiftUI

enum FocusedField {
    case email
    case password
}
struct LoginScreen: View {
    
    @FocusState var field : FocusedField?
    
    @State var emailText = ""
    @State var passwordText = ""
    
    @State var isValidEmail  = true
    @State var isValidPassword = true
    
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
            VStack{
               Text("Login here")
                    .foregroundColor(Color("blueColor"))
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom)
                Text("Welcome back you’ve \nbeen missed!")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    
               EmailTextView(emailText: $emailText, isValidEmail: $isValidEmail)
                
                PasswordTextView(passwordText: $passwordText, isValidPassword: $isValidPassword, errorText: "your password is not valid", placeholder: "Password", isValidatorPassword: Validator.validatePassword)
                HStack{
                    Spacer()
                    NavigationLink(destination: LoginScreen(), isActive: $ForgotPassword, label: {
                        Text("Forgot your Password?")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("blueColor"))
                    })
                        .padding(.trailing)
                     
                        
                }
                NavigationLink(destination: LoginScreen(), isActive: $HomeScreen, label: {
                    Text("Sign in")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth : .infinity)
                        .frame(height : 60)
                        .background(Color("blueColor"))
                        .cornerRadius(10)
                })
                    .padding(.vertical)
                    .padding(.horizontal)
                    .opacity(canProceed ? 1.0 : 0.5)
                    .disabled(!canProceed)
                
                NavigationLink(destination: LoginScreen(), isActive: $HomeScreen, label: {
                    Text("Create new account")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                })
                    .padding()
                    .padding(.bottom , 40)
                
                bottomView(Google: $Google, Facebook: $Facebook, Apple: $Apple)
                  
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                         presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color("blueColor"))
                            .imageScale(.large)
                            
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)  // Hide the default back button
        
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginScreen()
    }
}

struct bottomView : View{
    
    @Binding var Google  : Bool
    @Binding var Facebook  : Bool
    @Binding var Apple : Bool
    
    var body: some View{
        VStack{
            
            Text("or Contionue with")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color("blueColor"))
                .padding(.bottom)
            HStack{
                NavigationLink(destination: LoginScreen(), isActive: $Google, label: {
                    Image("google")
                    
                })
                    .iconButtonStyle
                   
                NavigationLink(destination: LoginScreen(), isActive: $Google, label: {
                    Image("fb")
                })
                    .iconButtonStyle
                NavigationLink(destination: LoginScreen(), isActive: $Google, label: {
                    Image("apple")
                })
                    .iconButtonStyle
            }.padding(.bottom)
        }.padding()
        
    }
}
//Email
struct EmailTextView : View{
    @Binding var emailText : String
    @Binding var isValidEmail : Bool
    
    @FocusState var field : FocusedField?
    
    
    
    var body: some View{
        VStack{
            TextField("Email", text: $emailText)
                .focused($field , equals: .email)
                .padding()
                .background(Color("secondaryColor"))
                .cornerRadius(10)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(!isValidEmail ? .red : field == .email ? Color("blueColor") : .white , lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: emailText) { newValue in
                    isValidEmail = Validator.validateEmail(newValue)
                }
                .padding(.bottom , isValidEmail ? 12 : 0)
            if !isValidEmail{
                HStack{
                    Text("Your email is not valid!")
                        .foregroundColor(.red)
                        .padding(.leading)
                    Spacer()
                }
            }
        }
        
    }
}
//Password
struct PasswordTextView : View{
    @Binding var passwordText : String
    @Binding var isValidPassword : Bool
    @State var errorText : String
    @State var placeholder : String
    let isValidatorPassword : (String) -> Bool
    
    @FocusState var field : FocusedField?
    
    
    
    var body: some View{
        VStack{
            SecureField(placeholder, text: $passwordText)
                .focused($field , equals: .email)
                .padding()
                .background(Color("secondaryColor"))
                .cornerRadius(10)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(!isValidPassword ? .red : field == .password ?  Color("blueColor") : .white , lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: passwordText) { newValue in
                    isValidPassword = isValidatorPassword(newValue)
                }
                .padding(.bottom , isValidPassword ? 16 : 0)
            if !isValidPassword{
                HStack{
                    Text(errorText)
                        .foregroundColor(.red)
                        .padding(.leading)
                }
            }
        }
    }
}

extension View{
    var iconButtonStyle :  some View{
        self
            .padding()
            .background(Color("gray"))
            .cornerRadius(8)
    }
}

