//
//  ViewController.swift
//  Exercise v3
//
//  Created by Deepson Khadka on 1/28/20.
//
/*
"entityId":"1222893113",
"companyName":"Summit Preservation, LLC",
"ratingCount":"7",
"compositeRating":"5.0",
"companyOverview":"Summit Preservation prides itself on creating beautiful surfaces for your home. You can always expect a great experience with us, a reasonable rate and a quality finish to the job. Call us today!",
"canadianSP":false,
"spanishSpeaking":false,
"phoneNumber":"(330) 555-3136",
"latitude":39.8873,
"longitude":-104.8805,
"servicesOffered":"Flooring & Carpet, Tile",
"specialty":"Additions & Remodeling",
"primaryLocation":"Henderson, CO",
"email":"contact@summitpresllc.biz"
*/
import UIKit


struct List:Decodable{
    let servicesOffered: String?

}

class ViewController: UIViewController {
var titlrArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        nestedJsonParser(pathLocation: "pro_data")
        for services in titlrArray{
            print(services)
        }
        
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
                //If I test null here, it crashes before it reaches this step
                //print(information.servicesOffered)
                if information.servicesOffered == nil {
                    titlrArray.append("Service UnAvailable")
                }else{
                    titlrArray.append(information.servicesOffered!)
                }
               
               }
           }catch{
               print("Got an error")
           }
       }
    
}
