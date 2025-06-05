//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Mañanas on 29/5/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore



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
                createUser()
                
            }
        }
    }
    
    func createUser() {
        let userID = Auth.auth().currentUser?.uid
        let username = usernametf.text!
        let password = passwordtf.text!
        let firstName
        let lastName
        let gender
        let birthday
        
        
        
        User(id: <#T##String#>, username: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, gender: <#T##Gender#>, birthday: <#T##Date#>, provider: <#T##LoginProvider#>)
        
        do {
            let db = Firestore.firestore()
            try db.collection("Users").document(userID).setData(from: user)
            let alertController = UIAlertController(title: "Create user", message: "User signs up successfully", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } catch let error {
          print("Error writing city to Firestore: \(error)")
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
    
    @IBAction func signWithGoogle(_ sender: Any) {
        // Configure Google SignIn with Firebase
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                print("Cannot get user token from Google")
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [unowned self] result, error in
                if let error = error {
                    // Hubo un error
                    print(error)
                    
                    let alertController = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Todo correcto
                    print("User signs in successfully")
                    
                    //user signed in - Task
                    
                    goToHome()
                }
            }
        }
    }
    
    @IBAction func githubLogin(_ sender: Any) {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                print("Error obteniendo credenciales de GitHub: \(error.localizedDescription)")
                return
            }
            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("Error al iniciar sesión con GitHub: \(error.localizedDescription)")
                    } else {
                        print("Sesión iniciada con éxito: \(authResult?.user.uid ?? "")")
                    }
                }
            }
        }
    }
        
        func goToHome () {
            self.performSegue(withIdentifier:"goToHome", sender: nil)
        }
    }

