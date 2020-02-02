//
//  List.swift
//  Exercise v3
//  Struct to hold json like variable names ;Unfortunately due to busy class schedule I couldn't create getter and setter for  this
//  Created by Deepson Khadka on 1/29/20.
//

import UIKit

///Reference: https://benscheirman.com/2017/06/swift-json/
///Unfortunately due to busy class schedule I couldn't create getter and setter for  this
///I wanted to do by OOP
struct List:Decodable{
    let entityId:String?
    let companyName:String?
    let ratingCount:String?
    let compositeRating:String?
    let companyOverview:String?
    let canadianSP:Bool?
    let spanishSpeaking:Bool?
    let phoneNumber:String?
    let latitude:Double?
    let longitude:Double?
    let servicesOffered:String?
    let specialty:String?
    let primaryLocation:String?
    let email:String?
    
    
}
