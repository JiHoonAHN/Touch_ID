//
//  ViewController.swift
//  Touch_ID
//
//  Created by Ji-hoon Ahn on 2021/03/23.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    let authContext = LAContext()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
    }
    @objc func didTabButton(){
        let context = LAContext()
        var error : NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self]success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else{
                        //failed
                        return
                    }
                    // show other screen
                    let vc = UIViewController()
                    vc.title = "welcome"
                    vc.view.backgroundColor = .systemBlue
                    self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
                
            }
        }
        else{
            // Can not use
            let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
