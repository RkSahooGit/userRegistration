//
//  resultVC.swift
//  UserRegistrationProject
//
//  Created by Rakesh Kumar Sahoo on 23/05/24.
//

import UIKit

class resultVC: UIViewController {
    
    var percentage = ""
    var result = ""
    
    @IBOutlet weak var firstTxtFld: UITextField!
    @IBOutlet weak var secondTxtFld: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print(percentage)
        print(result)
        self.firstTxtFld.text = String(percentage)
        self.secondTxtFld.text = result
                
    }
    


}
