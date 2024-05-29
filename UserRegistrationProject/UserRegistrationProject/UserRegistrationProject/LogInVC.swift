//
//  LogInVC.swift
//  UserRegistrationProject
//
//  Created by Rakesh Kumar Sahoo on 22/05/24.
//

import UIKit
import Firebase

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var eyeImg: UIImageView!
    @IBOutlet weak var eyeButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func eyeButtonAction(_ sender: Any) {
    }
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        guard let email = emailTxtFld.text else{return}
        guard let password = passwordTxtFld.text else{return}
        Auth.auth().signIn(withEmail: email, password: password){ firebaseResult, error in
            if let e = error{
                print("error")
            }else{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainPageVCStoryboardID") as? MainPageVC
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVCStoryBoardID") as? SignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
}
