//
//  SignUpViewController.swift
//  shopApp
//
//  Created by Jahongir on 10/1/20.
//  Copyright © 2020 Jahongir. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

         setUpElements()
            }
            
            func setUpElements() {
            
                // Hide the error label
                errorLabel.alpha = 0
            
                // Style the elements
                Utilities.styleTextField(FirstNameTextField)
                Utilities.styleTextField(LastNameTextField)
                Utilities.styleTextField(EmailTextField)
                Utilities.styleTextField(PasswordTextField)
                Utilities.styleFilledButton(signUpButton)
            }
            
            // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
            func validateFields() -> String? {
                
                // Check that all fields are filled in
                if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    
                    return "Please fill in all fields."
                }
                
                // Check if the password is secure
                let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if Utilities.isPasswordValid(cleanedPassword) == false {
                    // Password isn't secure enough
                    return "Please make sure your password is at least 8 characters, contains a special character and a number."
                }
                
                return nil
            }
            
    
    @IBAction func signUpTapped(_ sender: Any) {
                
                // Validate the fields
                let error = validateFields()
                
                if error != nil {
                    
                    // There's something wrong with the fields, show error message
                    showError(error!)
                }
                else {
                    
                    // Create cleaned versions of the data
                    let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // Create the user
                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                        
                        // Check for errors
                        if err != nil {
                            
                            // There was an error creating the user
                            self.showError("Error creating user")
                        }
                        else {
                            
                            // User was created successfully, now store the first name and last name
                            let db = Firestore.firestore()
                            
                            db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName,"email": email, "password":password, "uid": result!.user.uid ]) { (error) in
                                
                                if error != nil {
                                    // Show error message
                                    self.showError("Error saving user data")
                                }
                            }
                            
                            // Transition to the home screen
                            self.transitionToHome()
                        }
                        
                    }
                    
                    
                    
                }
            }
            
            func showError(_ message:String) {
                
                errorLabel.text = message
                errorLabel.alpha = 1
            }
            
            func transitionToHome() {
                
                let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
                
                view.window?.rootViewController = loginViewController
                view.window?.makeKeyAndVisible()
                
            }
            
        }
