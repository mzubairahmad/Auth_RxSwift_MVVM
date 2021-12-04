//
//  SignupViewModel.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import Foundation
import RxSwift
import RxRelay

class SignupViewModel {
    
    let model : SignupModel = SignupModel()
    let disposebag = DisposeBag()
    
    // Initialise ViewModel's
    let nameViewModel = NameViewModel()
    let emailViewModel = EmailViewModel()
    let phoneViewModel = PhoneViewModel()
    
    // Fields that bind to our view's
    let isSuccess : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let errorMsg : BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func validateInputFieldsWithMessage() -> String{
        let flag = validateInputFields()
        if (flag){
            return ""
        }
        var message = nameViewModel.errorValue.value ?? ""
        if (message.count > 0){
            return message
        }
        message = emailViewModel.errorValue.value ?? ""
        if (message.count > 0){
            return message
        }
        message = phoneViewModel.errorValue.value ?? ""
        if (message.count > 0){
            return message
        }
        return ""
    }
    
    func validateInputFields() -> Bool{
        return nameViewModel.validateCredentials() && emailViewModel.validateCredentials() && phoneViewModel.validateCredentials()
    }
    
    func signupUser(){
        
        // Initialise model with filed values
        model.name = nameViewModel.data.value
        model.email = emailViewModel.data.value
        model.phone = phoneViewModel.data.value
                
        let result = SignupModel(name: model.name, email: model.email, phone: model.phone)
        let apiService = APIService()
        apiService.signup(request: result)
            .subscribe(onNext : {response in
                self.isSuccess.accept(true)
            }, onError : { error in
                self.errorMsg.accept(error.localizedDescription)
            }).disposed(by : disposebag)
    }
}
