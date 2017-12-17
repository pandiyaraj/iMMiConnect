//
//  ViewController.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 09/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailCTF: IMTextField!
    @IBOutlet weak var passwordCTF: IMTextField!
    @IBOutlet weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        emailCTF.text = "aa@aa.com"
        passwordCTF.text = "1233"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
        if validate(){
            UserDefaults.standard.set(true, forKey: Constants.defaults.isLoggedIn)
            let dashboardVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerNames.DashboardVc) as! DashboardViewController
            self.navigationController?.pushViewController(dashboardVc, animated: true)
        }
    }

    func validate() -> Bool {
        // check for valid email address
        if (self.emailCTF.trimmedText?.isEmpty)!{
            self.showAlert(title: "Error", contentText: "Please enter the Email address", actions: nil)
            return false
        }else{
            if (self.emailCTF.trimmedText?.isEmail)!{
                if (self.passwordCTF.trimmedText?.isEmpty)!{
                    self.showAlert(title: "Error", contentText: "Password Empty", actions: nil)
                    return false
                    
                }else{
                    return true
                }
            }else{
                self.showAlert(title: "Error", contentText: "Invalid Email address", actions: nil)
                return false
            }
        }
    }
    
    //MARK:- TextView Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case emailCTF:
            if ((textField.text?.characters.count)! + (string.characters.count - range.length)) > 30 {
                return false
            }
            
        case passwordCTF:
            if ((textField.text?.characters.count)! + (string.characters.count - range.length)) > 30 {
                return false
            }
        default: break
        }
        return true
    }

    
}

