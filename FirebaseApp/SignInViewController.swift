//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Mañanas on 29/5/25.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var usernametf: UITextField!
    
    @IBOutlet weak var passwordtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
        
        let username = usernametf.text ?? ""
        let password = passwordtf.text ?? ""
        
        Auth.auth().createUser(withEmail: username, password: password) { [unowned self] authResult, error in
            if let error = error {
                // Hubo un error
                print(error)
                let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            } else {
                // Todo correcto
                print("User signs up successfully")
                let alertController = UIAlertController(title: "Create user", message: "User signs up successfully", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        let username = usernametf.text ?? ""
        let password = passwordtf.text ?? ""
        
        Auth.auth().signIn(withEmail: username, password: password) { [unowned self] authResult, error in
            if let error = error {
                // Hubo un error
                print(error)
                let alertController = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            } else {
                // Todo correcto
                print("User signs in successfully")
                goToHome()
            }
        }
    }
    
    func goToHome () {
        self.performSegue(withIdentifier:"goToHome", sender: nil)
    }
}

