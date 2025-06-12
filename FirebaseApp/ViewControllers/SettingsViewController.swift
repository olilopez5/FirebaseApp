//
//  SettingsViewController.swift
//  FirebaseApp
//
//  Created by Mañanas on 10/6/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signOut(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            print("Signed out")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        self.dismiss(animated: true , completion: nil)
        self.navigationController?.popToRootViewController(animated: true)

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
