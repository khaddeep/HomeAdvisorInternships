//
//  ViewController.swift
//  Exercise v3
//
//  Created by Deepson Khadka on 1/28/20.
//

import UIKit



class ViewController: UITableViewController{
    
    @IBOutlet var myTableView: UITableView!
    var proNameArray = [String]()
    var compositeRatingsArray = [String]()
    var ratingsCountArray = [String]()
    var phoneNumberArray = [String]()
    var emailAddressArray = [String]()
    var specialityArray = [String]()
    var locationArray = [String]()
    var serviceArray = [String]()
    var overViewArray = [String]()
    
    var indexPath = ""
    
 //https://learnappmaking.com/table-view-controller-uitableviewcontroller-how-to/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return proNameArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyListingsCell", for: indexPath) as! ControlsTableViewCell
        var sortedArray = proNameArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        cell.listingLabel.text = sortedArray[indexPath.row]
        cell.ratingsLabel.text="Rating: "+compositeRatingsArray[indexPath.row]+" | "+ratingsCountArray[indexPath.row]+" rating(s)"
        cell.btnCell.tag=indexPath.item
        cell.btnCell.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return cell
    }
    
    @objc func clicked(sender:UIButton){
        indexPath=String(sender.tag)
        performSegue(withIdentifier: "detailsViewController", sender: nil)
        print(sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nestedJsonParser(pathLocation: "pro_data")
    }
    
    func nestedJsonParser(pathLocation: String){
        guard let path = Bundle.main.path(forResource: pathLocation, ofType: "json") else{
            print("File not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            let lists = try JSONDecoder().decode([List].self, from: data)
            
            for information in lists{
                if information.servicesOffered == nil {
                        serviceArray.append("NA")
                }else{
                    serviceArray.append(information.servicesOffered!)
                }
             
                proNameArray.append(information.companyName!)
                compositeRatingsArray.append(information.compositeRating!)
                ratingsCountArray.append(information.ratingCount!)
                emailAddressArray.append(information.email!)
                phoneNumberArray.append(information.phoneNumber!)
                specialityArray.append(information.specialty!)
                locationArray.append(information.primaryLocation!)
                
                overViewArray.append(information.companyOverview!)
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }catch{
            print("Got an error")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if(segue.identifier=="detailsViewController"){
        let communicationViewController = segue.destination as! CommunicationVIewControllerViewController
            communicationViewController.emailAddress=emailAddressArray[Int(indexPath)!]
            communicationViewController.phoneNumber=phoneNumberArray[Int(indexPath)!]
            var sortedArray = proNameArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            communicationViewController.getproName=sortedArray[Int(indexPath)!]
            communicationViewController.getspeciality=specialityArray[Int(indexPath)!]
            communicationViewController.getratingInformation="Rating: "+compositeRatingsArray[Int(indexPath)!]+" | "+ratingsCountArray[Int(indexPath)!]+" rating(s)"
            communicationViewController.getlocation=locationArray[Int(indexPath)!]
            communicationViewController.getservices=serviceArray[Int(indexPath)!]
            communicationViewController.getoverview=overViewArray[Int(indexPath)!]
        }
        // Pass the selected object to the new view controller.
    }
    
}
