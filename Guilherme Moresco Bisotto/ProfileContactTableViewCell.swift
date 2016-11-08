//
//  ProfileContactTableViewCell.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/20/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class ProfileContactTableViewCell: UITableViewCell {
    
    enum CONTACT {
        case NOCONTACT
        case EMAIL
        case LINKEDIN
        case GITHUB
        case FACEBOOK
        case CELLPHONE
    }
    
    var contactId: CONTACT = .NOCONTACT
    var url: String!
    
    @IBOutlet weak var buttonContact: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func openURL(sender: AnyObject) {
        
        switch contactId {
            case .EMAIL:
                if let urlToOpen = NSURL(string: "mailto:\(url)") {
                    let application:UIApplication = UIApplication.sharedApplication()
                    if (application.canOpenURL(urlToOpen)) {
                        application.openURL(urlToOpen)
                    }
                }
                print("EMAIL: \(self.url)")
            
            case .LINKEDIN:
                if let urlToOpen = NSURL(string: url) {
                    let application:UIApplication = UIApplication.sharedApplication()
                    if (application.canOpenURL(urlToOpen)) {
                        application.openURL(urlToOpen)
                    }
                }
                print("LINKEDIN: \(self.url)")
            
            case .GITHUB:
                if let urlToOpen = NSURL(string: url) {
                    let application:UIApplication = UIApplication.sharedApplication()
                    if (application.canOpenURL(urlToOpen)) {
                        application.openURL(urlToOpen)
                    }
                }
                print("GITHUB: \(self.url)")
            
            case .FACEBOOK:
                if let urlToOpen = NSURL(string: url) {
                    let application:UIApplication = UIApplication.sharedApplication()
                    if (application.canOpenURL(urlToOpen)) {
                        application.openURL(urlToOpen)
                    }
                }
                print("FACEBOOK: \(self.url)")
            
            case .CELLPHONE:
                if let urlToOpen = NSURL(string: "tel://\(url)") {
                    let application:UIApplication = UIApplication.sharedApplication()
                    if (application.canOpenURL(urlToOpen)) {
                        application.openURL(urlToOpen)
                    }
                }
                print("CELLPHONE: \(self.url)")
        
            default:
                print("nada")
        }
    }
}
