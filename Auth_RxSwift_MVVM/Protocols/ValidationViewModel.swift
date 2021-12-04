//
//  ValidationViewModel.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import Foundation
import RxSwift
import RxRelay

protocol ValidationViewModel {
     
    var errorMessage: String { get }
    
    // Observables
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get}
    
    // Validation
    func validateCredentials() -> Bool
} 
