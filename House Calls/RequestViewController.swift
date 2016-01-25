//
//  RequestViewController.swift
//  HouseCalls
//
//  Created by Brian Carreon on 11/30/15.
//  Copyright © 2015 MarielSanchez. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI

class RequestViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitRequestAction(sender: AnyObject) {
        let twilioUsername = "AC674d685ee4f3246548bc79a539056aca"
        let twilioPassword = "a10c9b4790dba27fa905597d35b3d4c2"
        
        let data = [
            "To" : "+17076889656",
            "From" : "+17074160746",
            "Body" : "You have a client that submitted a request form"
        ]
        
        Alamofire.request(.POST, "https://\(twilioUsername):\(twilioPassword)@api.twilio.com/2010-04-01/Accounts/\(twilioUsername)/Messages", parameters: data)
            .responseData { response in
                print(response.request)
                print(response.response)
                print(response.result)
        }
        
            
            let mc = MFMailComposeViewController()
            let recipient = ["allielustig@gmail.com"]
        
            //uses Apple Mail app right now. Will be changing to mailGun for parseDB
            mc.mailComposeDelegate = self
            mc.setToRecipients(recipient)
            mc.setSubject("Pre-R Client Request")
            
            if MFMailComposeViewController.canSendMail() {
                
                presentViewController(mc, animated: true, completion: nil)
                print("Feedback email sent succesfully")
                
            }
            else {
                
                let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
                sendMailErrorAlert.show()
                print("Unable to send email.")
            }
            
        }
        
        func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
            
            dismissViewControllerAnimated(true, completion: nil)
            
            if (error != nil) {
                print("Error while sending feedback email \(error)")
            }
            
        
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
