//
//  ContentView.swift
//  Login_And_Register
//
//  Created by MACPC on 06/03/24.
//

import SwiftUI

enum Screen {
    case login
    case registeration
}
struct WelcomeScreen: View {
    
    @State var presentLoginView : Bool = false
    @State var presentRegisterationView : Bool = false
    @State var nextView : Screen?
    
    var body: some View {
        
            NavigationView{
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width : 385)
                        .padding(.top , 24)
                         Spacer()
                    
                    Text("Discover your Dream Job Here")
                        .font(.system(size: 35 , weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("blueColor"))
                        .padding(.bottom ,8)
                    
                    Text("Explore all the existing job roles based on your interest and study major")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                       Spacer()
                    
                    HStack(spacing : 12){
//
                        NavigationLink(destination: destinationForScreen(.login), isActive: $presentLoginView, label: {
                            
                             Text("Login")
                             .foregroundColor(.white)
                             .frame(width: 160, height: 60)
                             .background(Color("blueColor"))
                             .cornerRadius(10)
                        })
                        NavigationLink(destination: destinationForScreen(.registeration), isActive: $presentRegisterationView, label: {
                            
                             Text("Register")
                                 .foregroundColor(.black)
                                 .frame(width: 160, height: 60)
                                 .cornerRadius(10)
                        })
                    }
                    Spacer()
                }
                
                .padding()
                .navigationBarHidden(true)
            }
            
        }
            
           
    
    func destinationForScreen(_ screen: Screen) -> some View {
          switch screen {
          case .login:
              return AnyView(LoginScreen())
          case .registeration:
              return AnyView(RegisterationScreen())
          }
      }
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
