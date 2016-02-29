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
//import mandrill

class RequestViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var Zip: UITextField!
    @IBOutlet weak var State: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func submitRequestAction(sender: AnyObject) {
        let twilioUsername = "AC674d685ee4f3246548bc79a539056aca"
        let twilioPassword = "a10c9b4790dba27fa905597d35b3d4c2"
        
        let data = [
            "To" : "+18585312501",
            "From" : "+17074160746",
            "Body" : "You have a client that submitted a request form"
        ]
        
        Alamofire.request(.POST, "https://\(twilioUsername):\(twilioPassword)@api.twilio.com/2010-04-01/Accounts/\(twilioUsername)/Messages", parameters: data)
            .responseData { response in
                print(response.request)
                print(response.response)
                print(response.result)
        }
        
            
        let formData = PFObject(className:"Form")
        formData["First"] = FirstName.text
        formData["Last"] = LastName.text
        formData["Phone"] = Phone.text
        formData["Email"] = Email.text
        formData["City"] = City.text
        formData["State"] = State.text
        formData["Zip"] = Zip.text
        formData.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Success")
                } else {
                    // There was a problem, check error.description
                    print("ERROR")
                }
        }
        
        /*let mandrill = require("mandrill");
        mandrill.initialize("mandrillAPIKey");
        
        Parse.Cloud.define("myMandrillFunction", function(request, response) {
            mandrill.sendEmail({
                message: {
                    text: "Hello World!",
                    subject: "Using Cloud Code and Mandrill is great!",
                    from_email: "parse@cloudcode.com",
                    from_name: "Cloud Code",
                    to: [
                    {
                    email: "you@parse.com",
                    name: "Your Name"
                    }
                    ]
                },
                async: true
                }, {
                    success: function(httpResponse) { response.success("Email sent!"); },
                    error: function(httpResponse) { response.error("Uh oh, something went wrong"); }
            });*/
        }//submitrequestactionsender
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}//class
