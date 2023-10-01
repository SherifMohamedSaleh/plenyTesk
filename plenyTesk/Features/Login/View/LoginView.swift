//
//  LoginView.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//

import Foundation
import SwiftUI


struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    @EnvironmentObject private var coordinator: Coordinator
    
    
    var placeHolderTextView: some View {
        PlaceholderTextField(title : "enter your user name",placeholder: Text("User Name"), keyboardType: .default, text: $viewModel.userName)
            .padding(.top)
    }
    
    var passwordTextView: some View {
        SecurePlaceholderTextField(title : "enter your password" ,placeholder: Text(" Password"), text: $viewModel.password)
            .padding(.top)
    }
    
    
    
    var SignInButton : some View {
        
        Button {
            if viewModel.ValidateData() {
                viewModel.loginUser()
                viewModel.loginSuccessPublisher
                    .sink {  success in
                        if success {
//                            self.coordinator.isLogin = true
                            self.coordinator.popToRoot()
                            self.coordinator.push(.postList)
                        }
                    }
                    .store(in: &viewModel.cancellables)
            }
        } label: {
            Text("sign in")
                .frame( height: 50)
                .padding([.leading , .trailing] ).foregroundColor(Color.white)
                .hCenter()
            
                .background(Color.indigo)
                .cornerRadius(25)
        }
        
    }
    
    
    
    
    
    var titleView: some View {
        VStack{
            Image("login").resizable().frame(width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height * 0.5
            ).vTop()
            
            Text("Welcom").foregroundColor(Color.indigo)
            
        }
    }
    
    var missingDataAlert: Alert {
        Alert(title: Text("Alert"), message: Text(viewModel.missingDataAlertMsg), dismissButton: .default(Text("OK")))
    }
    
    func loaingData(){
        self.viewModel.state = .idle
    }
    
    var body: some View {
        
        LoadingView(noDataAction: loaingData, state: $viewModel.state) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    
                    self.titleView
                    self.placeHolderTextView
                    self.passwordTextView
                    
                    
                    VStack(spacing : 5){
                        self.SignInButton
                            .frame( height: 60)
                            .padding([.leading , .trailing] ).hCenter()
                        
                            .hCenter()
                        
                    }.padding(20).vTop()
                        .alert(isPresented: $viewModel.showAlert, content: {
                            return  self.missingDataAlert
                            
                        })
                    
                }.padding(20)
            }
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    
    
    
    
    struct PlaceholderTextField: View {
        var title: String
        var placeholder: Text
        var keyboardType : UIKeyboardType
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading) {
                if text.isEmpty || !text.isEmpty { placeholder }
                TextField(title, text: $text)
                    .autocapitalization(.none)
                    .keyboardType(keyboardType)
            }
        }
    }
    
    struct SecurePlaceholderTextField: View {
        var title: String
        var placeholder: Text
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading) {
                if text.isEmpty || !text.isEmpty { placeholder }
                SecureField(title, text: $text)
                    .autocapitalization(.none)
            }
        }
    }
}
