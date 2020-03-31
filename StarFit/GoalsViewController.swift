//
//  GoalsViewController.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/29/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit


//Goals View Controller file
class GoalsViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var CaloriesTextField: UITextField!
    @IBOutlet var WaterTextField: UITextField!
    @IBOutlet var SugarTextField: UITextField!

    @IBAction func NextButton(_ sender: UIButton) {

    }
   
    //Sends information from this screen to the next: IntakeViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intakeVC = segue.destination as? IntakeViewController else {return}
        if CaloriesTextField.text == "" || WaterTextField.text == "" || SugarTextField.text == "" { let alertController = UIAlertController(title: "Missing Information", message:" Please make sure that all fields are filled.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else {
            intakeVC.caloriesG = CaloriesTextField.text
            intakeVC.waterG = WaterTextField.text
            intakeVC.sugarG = SugarTextField.text
            
            CaloriesTextField.text = ""
            WaterTextField.text = ""
            SugarTextField.text = ""
        }
    }
    
    
    
}
