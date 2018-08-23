//
//  OnboardingViewController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/21/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // gbAuthClient.resetAuthorization()
    }

    
    @IBAction func logIn(_ sender: Any) {
    }
    
    @IBAction func getStartedButton(_ sender: Any) {
        gbAuthClient.authorizeIfNeeded(presenter: self) { (error) in
            if let error = error {
                NSLog("Error implementing Google Books Authorization on Onboarding Screen: \(error)")
            }
            self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
        }
    }
    
    // MARK: - Properties
    
    var gbAuthClient = GoogleBooksAuthorizationClient()
    
}
