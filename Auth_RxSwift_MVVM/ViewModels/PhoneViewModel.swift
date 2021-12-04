//
//  PhoneViewModel.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import Foundation
import RxSwift
import RxRelay

class PhoneViewModel : ValidationViewModel{
     
    var errorMessage: String = "Please enter a valid Phone number"
    
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
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: text)
    }
}
