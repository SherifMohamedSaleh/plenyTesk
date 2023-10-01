//
//  LoginViewModel.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//

import Alamofire
import Combine
import SwiftUI

@MainActor

class LoginViewModel : ObservableObject {
    
    private var service = LoginService()
    var cancellables = Set<AnyCancellable>()
    
    
    @Published var state : LoadingState = .idle
    @Published var logedIn = false
    
    @Published var showAlert = false
    @Published var isMissingDataAlert = false
    @Published var missingDataAlertMsg  = ""
    
    @Published var userName : String = ""
    @Published var password  : String = ""
    
    var logInResponseModel : LogInResponseModel?
    
    @Published var loginSuccessPublisher = PassthroughSubject<Bool, Never>()
    
    func  loginUser() {
        state = .loading
        self.service.loginUser(loginRequestModel : LoginRequestModel(self.userName, self.password) )
        
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.missingDataAlertMsg = error.localizedDescription
                    self.isMissingDataAlert = true
                    self.showAlert.toggle()
                    self.logedIn = false
                    self.state = .loaded
                    self.loginSuccessPublisher.send(false)
                    
                }
            }, receiveValue: { [weak self] response in
                
                
                self?.logInResponseModel = response
                if let id = response.id {
                    UserDefaults.standard.set(id , forKey: "id")
                    UserDefaults.standard.synchronize()
                    // add id to userDefault
                    print(id)
                    self?.logedIn = true
                    self?.state = .loaded
                    self?.loginSuccessPublisher.send(true)
                    
                }else{
                    self?.missingDataAlertMsg = "some thing went wront please try agian"
                    self?.isMissingDataAlert = true
                    self?.showAlert.toggle()
                    self?.logedIn = false
                    self?.state = .loaded
                    self?.loginSuccessPublisher.send(false)
                }
            }
            )
            .store(in: &self.cancellables)
        
    }
    
    // TODO: - add validation to user inputs
    func ValidateData() -> Bool {
        print(userName)
        print(password)
        
        if userName.isEmpty || userName.count < 3 {
            self.missingDataAlertMsg = "User name can't be blank."
            self.isMissingDataAlert = true
            self.showAlert.toggle()
            return false
            
        } else if password.isEmpty || password.count < 3 {
            self.missingDataAlertMsg = "Password can't be blank."
            self.isMissingDataAlert = true
            self.showAlert.toggle()
            return false
            
        }
        return true
    }
}
