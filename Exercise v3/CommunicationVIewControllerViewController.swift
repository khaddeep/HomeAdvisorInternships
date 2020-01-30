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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func callPhone(_ sender: Any) {
        dialNumber(number: trimWithCharacters(givenStrings: phoneNumber))
        print(trimWithCharacters(givenStrings: phoneNumber))
    }
    @IBOutlet weak var emailBarItem: UITabBarItem!
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
       }
    }

    func trimWithCharacters(givenStrings:String) -> String {
        //var characterSet: Character = [','=',"(",")","-"]
        
        return givenStrings.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
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
            
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func email_Button(_ sender: Any) {
        sendEmail(emailAddress: emailAddress)
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    

}
