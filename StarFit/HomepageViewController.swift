//
//  HomepageViewController.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/29/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit
//Homepage View Controller file
class HomepageViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var CaloriesProgressLabel: UILabel!
    @IBOutlet var WaterProgressLabel: UILabel!
    @IBOutlet var SugarProgressLabel: UILabel!
    
    @IBOutlet var CaloriesLeftLabel: UILabel!
    @IBOutlet var WaterLeftLabel: UILabel!
    @IBOutlet var SugarLeftLabel: UILabel!
    
    var CG: String!
    var WG: String!
    var SG: String!
    var CLeft: String!
    var WLeft: String!
    var SLeft: String!
    
//Sets information retrieved from previous screen to display on this screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CaloriesProgressLabel.text = CG
        WaterProgressLabel.text = WG
        SugarProgressLabel.text = SG
        CaloriesLeftLabel.text = CLeft
        WaterLeftLabel.text = WLeft
        SugarLeftLabel.text = SLeft
        
        
        //IF ALL GOALS HAVE BEEN REACHED
            if CLeft == "0" && WLeft == "0" && SLeft == "0" {
                let alertController = UIAlertController(title: "CONGRATULATIONS", message:"You have successfully reached ALL of your goals for the day!.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "Yay!", style: UIAlertActionStyle.default, handler: nil)
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            }
        
            //IF 2 GOALS HAVE BEEN REACHED
            else  if ( CLeft == "0" && WLeft == "0" ) || ( CLeft == "0" && SLeft == "0" ) || ( WLeft == "0" && CLeft == "0" )
            {
                let alertController = UIAlertController(title: "Yes! Almost there!", message:"You have met two of your goals so far One more to go!", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil)
                   
                   alertController.addAction(OKAction)
                   self.present(alertController, animated: true, completion: nil)
            }
        
        //IF ONLY CALORIE GOAL HAS BEEN REACHED
           else  if CLeft == "0"  {
                  let alertController = UIAlertController(title: "Nice Job!", message:"You have met your calorie intake goal!.", preferredStyle: UIAlertControllerStyle.alert)
              let OKAction = UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil)
              
              alertController.addAction(OKAction)
              self.present(alertController, animated: true, completion: nil)
              }
                
        //IF ONLY WATER GOAL HAS BEEN REACHED
            else  if WLeft == "0"  {
                   let alertController = UIAlertController(title: "Nice Job!", message:"You have met your water intake goal!.", preferredStyle: UIAlertControllerStyle.alert)
               let OKAction = UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil)
               
               alertController.addAction(OKAction)
               self.present(alertController, animated: true, completion: nil)
               }
                
        //IF ONLY SUGAR GOAL HAS BEEN REACHED
               else  if SLeft == "0"  {
                      let alertController = UIAlertController(title: "Nice Job!", message:"You have met your sugar intake goal!.", preferredStyle: UIAlertControllerStyle.alert)
                  let OKAction = UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil)
                  
                  alertController.addAction(OKAction)
                  self.present(alertController, animated: true, completion: nil)
                  }
        
    }
    
    
}
