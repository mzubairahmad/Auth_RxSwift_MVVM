//
//  NameViewModel.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import Foundation
import RxSwift
import RxRelay

class NameViewModel : ValidationViewModel{
     
    var errorMessage: String = "Please enter your Full name"
    
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    func validateCredentials() -> Bool {
        
        guard validatePattern(text: data.value) else {
            errorValue.accept(errorMessage)
            return false
        }
        
        errorValue.accept("")
        return true
    }
    
    func validatePattern(text : String) -> Bool{
        return text.count > 0
    }
}
