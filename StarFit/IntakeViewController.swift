//
//  IntakeViewController.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/30/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit


//Intake View Controller file
class IntakeViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var CalorieIntakeTextField: UITextField!
    @IBOutlet var WaterIntakeTextField: UITextField!
    @IBOutlet var SugarIntakeTextField: UITextField!

    @IBAction func NextButton(_ sender: UIButton) {
    }
    
    var caloriesG: String!
    var waterG: String!
    var sugarG: String!
  
    //Sends information from this page to the next: HomepageViewController
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let HomeVC = segue.destination as? HomepageViewController else { return }
            
            if CalorieIntakeTextField.text == "" || WaterIntakeTextField.text == "" || SugarIntakeTextField.text == "" {
                let alertController = UIAlertController(title: "Missing Information", message:" Please make sure that all fields are filled.", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
                
            else {
            
                let calInt: Int! = Int(caloriesG)
                let waterInt: Int! = Int(waterG)
                let sugarInt: Int! = Int(sugarG)

        //Calculates the remaining calories, ounces, and grams
                let cResult = calInt! - Int(CalorieIntakeTextField.text!)!
                let wResult = waterInt! - Int(WaterIntakeTextField.text!)!
                let sResult = sugarInt! - Int(SugarIntakeTextField.text!)!

                
                let calorieIntake = " \(String(describing: CalorieIntakeTextField.text!)) "
                let calorieInt = Int(CalorieIntakeTextField.text!)!
                let calorieProgress = calorieIntake + " /" + caloriesG
                CalorieIntakeTextField.text = ""

                let waterIntake = " \(String(describing: WaterIntakeTextField.text!)) "
                let watInt = Int(WaterIntakeTextField.text!)!
                let waterProgress = waterIntake + " /" + waterG
                WaterIntakeTextField.text = ""

                let sugarIntake = " \(String(describing: SugarIntakeTextField.text!)) "
                let sugInt = Int(SugarIntakeTextField.text!)!
                let sugarProgress = sugarIntake + " /" + sugarG
                SugarIntakeTextField.text = ""
                
                if calInt < calorieInt || waterInt < watInt || sugarInt < sugInt {
                    let alertController = UIAlertController(title: "Incompatible information", message:"Intake cannot be larger than goal, please re-enter a value less than or equal to goal!", preferredStyle: UIAlertControllerStyle.alert)
                    let OKAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
                    
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                    
                else {
                    //Sends information to homepage
                    HomeVC.CG = calorieProgress
                    HomeVC.WG = waterProgress
                    HomeVC.SG = sugarProgress
                    HomeVC.CLeft = String(cResult)
                    HomeVC.WLeft = String(wResult)
                    HomeVC.SLeft = String(sResult)
                }
            }
        }
    }
