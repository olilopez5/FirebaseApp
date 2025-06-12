//
//  WelcomeViewController.swift
//  FirebaseApp
//
//  Created by Mañanas on 12/6/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    @IBAction func anonButton(_ sender: Any) {
            Auth.auth().signInAnonymously { authResult, error in
                if let error = error {
                    print("Error al iniciar sesión anónima: \(error.localizedDescription)")
                    return
                }
                
                guard let user = authResult?.user else { return }
                let uid = user.uid
                let db = Firestore.firestore()
                let docRef = db.collection("Users").document(uid)
                
                // Comprobar si ya existe el documento
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        print("El usuario anónimo ya tiene un documento.")
                    } else {
                        // Crear un documento básico
                        let data: [String: Any] = [
                            "id": uid,
                            "username": "",
                            "firstName": "",
                            "lastName": "",
                            "gender": "unspecified",
                            "birthday": NSNull(), // si no tienes fecha, puedes poner null
                            "provider": "basic",
                            "profileImageUrl": NSNull()
                        ]
                        
                        docRef.setData(data) { error in
                            if let error = error {
                                print("Error al guardar usuario anónimo: \(error.localizedDescription)")
                            } else {
                                print("Usuario anónimo guardado en Firestore con UID: \(uid)")
                            }
                        }
                    }
                    
                    /* Transición a la pantalla principal (haz esto una sola vez)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goToMain", sender: self)
                    } */
                }
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
