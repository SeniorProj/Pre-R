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
import JLToast
import SendGrid

class RequestViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var Zip: UITextField!
    @IBOutlet weak var State: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.layer.cornerRadius = 5.0
        
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
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func submitRequestAction(sender: AnyObject) {
        
        let sg = SendGrid(username: "pomtech16", password: "pomtechrulez16")
        let emailmessage = SendGrid.Email()
        
        try! emailmessage.addTo("pomtech16@gmail.com", name: "Dr. Slishman")
        emailmessage.setFrom(Email.text!, name: FirstName.text)
        emailmessage.setSubject(FirstName.text! + " " + LastName.text! + " Requests A Consult")
        emailmessage.setTextBody("First Name: " + FirstName.text! + "Last Name: " + LastName.text!)
        emailmessage.setHtmlBody("<p>First Name: " + FirstName.text! + "<br />" +
            "Last Name: " + LastName.text! + "<br />" +
            "Phone: " + Phone.text! + "<br />" +
            "Email: " + Email.text! + "<br />" +
            "City: " + City.text! + "<br />" +
            "State: " + State.text! + "<br />" +
            "Zip: " + Zip.text! + "</p>" )
        
        try! sg.send(emailmessage, completionHandler: { (response, data, error) -> Void in
            if let json = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                print(json)
            }
        })
        
        let twilioUsername = "AC674d685ee4f3246548bc79a539056aca"
        let twilioPassword = "a10c9b4790dba27fa905597d35b3d4c2"
        
        let data = [
            "To" : "+4256389697",
            "From" : "+17074160746",
            "Body" : "You have a client that requests a consult"
        ]
        
        Alamofire.request(.POST, "https://\(twilioUsername):\(twilioPassword)@api.twilio.com/2010-04-01/Accounts/\(twilioUsername)/Messages", parameters: data)
            .responseData { response in
                print(response.request)
                print(response.response)
                print(response.result)
                
                JLToast.makeText("Email Sent! Dr. Slishman will contact you shortly.", duration: JLToastDelay.LongDelay).show()
        }
        
        
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
