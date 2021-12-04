//
//  APIService.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import UIKit
import Foundation
import RxSwift

protocol APIServiceeProtocol {
    func signup(request: SignupModel) -> Observable<User>
}

class APIService : APIServiceeProtocol {
    
    func signup(request: SignupModel) -> Observable<User> {
        return Observable.create { observer in
            /*
             Networking code will be here.
            */
            observer.onNext(User()) // Simulation of successful user authentication.
            return Disposables.create()
        }
    }
}
