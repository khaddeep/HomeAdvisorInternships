//
//  CommunicationVIewControllerViewController.swift
//  Exercise v3
//
//  Created by Deepson Khadka on 1/29/20.
//

import UIKit
import MessageUI
class CommunicationVIewControllerViewController: UIViewController, UITabBarControllerDelegate, MFMailComposeViewControllerDelegate {
    var phoneNumber: String = ""
    var emailAddress: String = ""
    var getproName: String = ""
    var getspeciality: String = ""
    var getratingInformation: String = ""
    var getlocation: String = ""
    var getservices: String = ""
    var getoverview: String = ""
    
    
    @IBOutlet weak var proName: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var ratingInformation: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var services: UILabel!
    
    @IBOutlet weak var overview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proName.text=getproName
        speciality.text=getspeciality
        ratingInformation.text=getratingInformation
        location.text=getlocation
        services.text=getservices
        overview.text=getoverview
    }
    
    @IBAction func callPhone_Button(_ sender: Any) {
        dialNumber(number: trimWithCharacters(givenStrings: phoneNumber))
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func email_Button(_ sender: Any) {
        sendEmail(emailAddress: emailAddress)
    }
    
    func dialNumber(number : String) {
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
            print("Please!!! Use your Phone to open Dialpad")
        }
        print("phone=\(number)")
    }
    
    func sendEmail(emailAddress: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailAddress])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
            
        } else {
            // show failure alert
            print("Please!!! Use your Phone to open Mail")
        }
        print("email=\(emailAddress)")
       
    }
    func trimWithCharacters(givenStrings:String) -> String {
        // trims characterSet: Character = [','=',"(",")","-"]
        return givenStrings.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
    }
}
