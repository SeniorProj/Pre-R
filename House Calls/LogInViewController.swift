//
//  LogInViewController.swift
//  HouseCalls
//
//  Created by Brian Carreon on 11/29/15.
//  Copyright © 2015 MarielSanchez. All rights reserved.
//

import UIKit
import Parse
import CoreData

class LogInViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var verificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        
  /*      let newDoc = NSEntityDescription.insertNewObjectForEntityForName("Doctor", inManagedObjectContext: context!)
        
        
        newDoc.setValue("Rob", forKey: "username")
        newDoc.setValue("123", forKey: "password")
        newDoc.setValue(false, forKey: "isLoggedIn")
        
        do {
            try context!.save()
        }
        catch {
            print("Could not save Doctor profile")
        }*/
        
        let request = NSFetchRequest(entityName: "Doctor")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context!.executeFetchRequest(request)
            print(results)
        }
        catch {
            print("Fetch failed")
        }


        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    @IBAction func logInButtonAction(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!, block: {
            (User : PFUser?, Error : NSError?) -> Void in
            
            if Error == nil {
                dispatch_async(dispatch_get_main_queue()) {
                    var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //var logInSuccessVC = Storyboard.instantiateViewControllerWithIdentifier("logInSuccessVC")
                    //self.presentViewController(logInSuccessVC, animated: true, completion: nil)
                    self.performSegueWithIdentifier("statusMenu", sender: self)
                }
            }
            else {
                self.verificationLabel.text = "Username/Password combination not valid"
            }
        })
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

}
