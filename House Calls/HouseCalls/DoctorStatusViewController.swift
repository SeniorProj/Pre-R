//
//  DoctorStatusViewController.swift
//  HouseCalls
//
//  Created by Allie Lustig on 1/24/16.
//  Copyright © 2016 MarielSanchez. All rights reserved.
//

import UIKit
import Firebase

class DoctorStatusViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var doctorStatus: UILabel!
     let pickerData = ["Available","Temporarily Unavailable", "Telemedicine", "Unavailable"]
    
    var ref = FIRDatabase.database().reference()

    @IBAction func updateStatusButton(sender: AnyObject) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("availability").child(userID!).setValue(["availability" : doctorStatus.text!])
        /*
        var currentUser = PFUser.currentUser()
        if currentUser != nil{
            print(currentUser!.username)
            currentUser!.setObject(doctorStatus.text!, forKey: "availability")
            currentUser!.saveInBackground()
        } else{
            print("error")
        }
 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateButton.layer.cornerRadius = 5.0
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        myPicker.dataSource = self
        myPicker.delegate = self
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        doctorStatus.text = pickerData[row]
    }

    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }

}
