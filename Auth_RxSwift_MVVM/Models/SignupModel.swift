//
//  SignupModel.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import Foundation

class SignupModel {
    
    var name = ""
    var email = ""
    var phone = ""
    
    convenience init(name : String, email : String, phone : String) {
        self.init()
        self.name = name
        self.email = email
        self.phone = phone
    }
}
