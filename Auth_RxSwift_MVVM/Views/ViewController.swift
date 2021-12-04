//
//  SignupController.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 03/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SignupController: UIViewController {
    
    // MARK: - IB-OUTLEETS
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    let viewModel = SignupViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewModelBinding()
        createCallbacks()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func createViewModelBinding(){
        
        nameTextfield.rx.text.orEmpty
            .bind(to: viewModel.nameViewModel.data)
            .disposed(by: disposeBag)
        
        emailTextfield.rx.text.orEmpty
            .bind(to: viewModel.emailViewModel.data)
            .disposed(by: disposeBag)
        
        phoneTextfield.rx.text.orEmpty
            .bind(to: viewModel.phoneViewModel.data)
            .disposed(by: disposeBag)
        
        signupButton.rx.tap.do(onNext:  { [unowned self] in
            self.view.endEditing(true)
        }).subscribe(onNext: { [unowned self] in
            let message = self.viewModel.validateInputFieldsWithMessage()
            if (message.count == 0) {
                self.viewModel.signupUser()
            }else{
                self.showAlert("Alert", message)
            }
        }).disposed(by: disposeBag)
            
        var areAllFieldsHaveData : Observable<Bool>{
                return Observable.combineLatest( viewModel.nameViewModel.data.asObservable(), viewModel.emailViewModel.data.asObservable(), viewModel.phoneViewModel.data.asObservable()){ (name, email, phone) in
                    return name.count > 0 && email.count > 0 && phone.count > 0
                }
            }
        
        areAllFieldsHaveData
            .bind(to: signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    func createCallbacks (){
        // success
        viewModel.isSuccess.asObservable()
            .bind{ value in
                self.signupSuccess()
        }.disposed(by: disposeBag)
        
        // errors
        viewModel.errorMsg.asObservable()
            .bind { errorMessage in
            self.showAlert("Failure", errorMessage)
        }.disposed(by: disposeBag)
    }
    
    func signupSuccess () {
        NSLog("Successfull %@",self.viewModel.nameViewModel.data.value)
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)

    }
}

