//  Unfortunately due to heavy course load, I couldn't use design principles and tests
//  ViewController.swift
//  Exercise v3
//  MainViewController responsible for entire app and displaying in table view
//  Created by Deepson Khadka on 1/28/20.
//

import UIKit

class ViewController: UITableViewController{
    
    @IBOutlet var myTableView: UITableView!
    //Creating Global Empty array for storing data after parsed
    var proNameArray = [String]()
    var compositeRatingsArray = [String]()
    var ratingsCountArray = [String]()
    var phoneNumberArray = [String]()
    var emailAddressArray = [String]()
    var specialityArray = [String]()
    var locationArray = [String]()
    var serviceArray = [String]()
    var overViewArray = [String]()
    var parsedData = [List]()    //Parsed data from json file
    var colorArray = [UIColor]() //Stores Color information
    
    //Keeps track of indexpath.row in TableView controller cell tag
    var indexPath = ""
    
    /// Function that returns count of cells in table view controller
    /// - Parameters:
    ///   - tableView: tableViewCell to populate the screen.
    ///   - section: number of rows on the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proNameArray.count //returns the number of company name cell to be created in the tableview controller
    }
    
    /// Function that displays UI view of the Comany and Ratings in a Table manner
    /// - Parameters:
    ///   - tableView: tableViewCell to populate the screen
    ///   - indexPath: index of the row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyListingsCell", for: indexPath) as! ControlsTableViewCell
        cell.listingLabel.text = proNameArray[indexPath.row]
        cell.ratingsLabel.textColor=colorArray[indexPath.row]
        if Int(ratingsCountArray[indexPath.row])!>0 {
            cell.ratingsLabel.text="Rating: "+compositeRatingsArray[indexPath.row]+" | "+ratingsCountArray[indexPath.row]+" rating(s)"
        }else{
            cell.ratingsLabel.text="Reference Available"
        }
        //Disclosure indicator
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.btnCell.tag=indexPath.item
        cell.btnCell.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return cell
    }
    
    /// Objective C function to make cell clickable
    /// Reference: https://stackoverflow.com/questions/30611922/how-to-make-cell-clickable-also-the-buttons-on-cell-will-be-clickable-in-swift
    /// - Parameter sender: holds button information
    @objc func clicked(sender:UIButton){
        indexPath=String(sender.tag)
        performSegue(withIdentifier: "detailsViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calling Parsed function
        parseJsonDataFrom(pathLocation: "pro_data")
    }
    
    /// Parses the json data
    /// https://benscheirman.com/2017/06/swift-json/
    /// - Parameter pathLocation: path of json file
    func parseJsonDataFrom(pathLocation: String){
        guard let path = Bundle.main.path(forResource: pathLocation, ofType: "json") else{
            print("File not found") //File Error handling
            return
        }
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            let jsonDecodedData = try JSONDecoder().decode([List].self, from: data)
            
            //Arranges JSON data alphabetically based on Company Alphabet
            //Online Source:https://stackoverflow.com/questions/36394813/sorting-of-an-array-alphabetically-in-swift/36394856
            let sortedJsonData = jsonDecodedData.sorted(by: { (obj1, Obj2) -> Bool in
                let obj1Name = obj1.companyName ?? ""
                let obj2Name = Obj2.companyName ?? ""
                return (obj1Name.localizedCaseInsensitiveCompare(obj2Name) == .orderedAscending)
            })
            
            parsedData=sortedJsonData //Storing parsed data to global array
            appendAllInformations()   //Calling the function we created
            
            //Essentially this just means that sync will block the main thread until the task has finished
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }catch{
            print("Got an error")
        }
    }
    
    /// Function for removing complexity in parseJsonData function
    func appendAllInformations()  {
        for information in parsedData{
            //Simple Error handling for service offered
            if information.servicesOffered == nil {
                serviceArray.append("Services Not Available")
            }else{
                serviceArray.append(information.servicesOffered!)
            }
            //Storing UIColor according to the requirements
            if (Double(information.compositeRating!)!)>=4 {
                colorArray.append(UIColor.green)
            }else if (Double(information.compositeRating!)!)<3 && (Double(information.compositeRating!)!)>0 {
                colorArray.append(UIColor.red)
            }else if (Double(information.compositeRating!)!)>=3 && (Double(information.compositeRating!)!)<4{
                colorArray.append(UIColor.orange)
            }else{
                colorArray.append(UIColor.black)
            }
            
            //Force Unwrapping: On real project I wouldn't do this
            proNameArray.append(information.companyName!)
            compositeRatingsArray.append(information.compositeRating!)
            ratingsCountArray.append(information.ratingCount!)
            emailAddressArray.append(information.email!)
            phoneNumberArray.append(information.phoneNumber!)
            specialityArray.append(information.specialty!)
            locationArray.append(information.primaryLocation!)
            overViewArray.append(information.companyOverview!)
            
        }
    }
    
    
    /// Preserving data  for passing data between the segues
    /// - Parameters:
    ///   - segue: scene
    ///   - sender: sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if(segue.identifier=="detailsViewController"){
            let communicationViewController = segue.destination as! CommunicationVIewControllerViewController
            // Pass the selected object to the new view controller.
            communicationViewController.emailAddress=sendInformation(informationArray: emailAddressArray)
            communicationViewController.phoneNumber=sendInformation(informationArray: phoneNumberArray)
            communicationViewController.getproName=sendInformation(informationArray: proNameArray)
            communicationViewController.getspeciality=sendInformation(informationArray: specialityArray)
            communicationViewController.getlocation=sendInformation(informationArray: locationArray)
            communicationViewController.getservices=sendInformation(informationArray: serviceArray)
            communicationViewController.getoverview=sendInformation(informationArray: overViewArray)
            if Int(ratingsCountArray[Int(indexPath)!])!>0 {
                communicationViewController.getratingInformation="Rating: "+compositeRatingsArray[Int(indexPath)!]+" | "+ratingsCountArray[Int(indexPath)!]+" rating(s)"
            }else{
                communicationViewController.getratingInformation="Reference Available"
            }
        }
    }
    
    /// Simple function to remove the complexity
    /// - Parameter informationArray: stores all the information parsed
    func sendInformation(informationArray:[String]) -> String {
        return informationArray[Int(indexPath)!]
    }
    
}
