//
//  GaleryViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/22/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class GaleryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIDocumentInteractionControllerDelegate {
    
    var content: String!
    var tableviewImages: [String]!
    var documentInteractionController: UIDocumentInteractionController!

    @IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.alpha = 0.0
        
        self.tableviewImages = []
        
        if self.content == "SanFrancisco" {
            for i in 0 ... 39 {
                self.tableviewImages.append("sf-\(i)")
            }
        } else if self.content == "LasVegas" {
            for i in 0 ... 23 {
                self.tableviewImages.append("lv-\(i)")
            }
        } else if self.content == "BeverlyHills" {
            for i in 0 ... 7 {
                self.tableviewImages.append("bh-\(i)")
            }
        } else if self.content == "Cupertino" {
            for i in 0 ... 2 {
                self.tableviewImages.append("cup-\(i)")
            }
        } else if self.content == "SantaMonica" {
            for i in 0 ... 13 {
                self.tableviewImages.append("sm-\(i)")
            }
        } else {
            for i in 0 ... 7 {
                self.tableviewImages.append("hw-\(i)")
            }
        }
        print(self.tableviewImages.count)
        print(self.tableviewImages)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let value = UIInterfaceOrientation.Unknown.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        self.scrollViewDidScroll(self.tableview)
        
        UIView.animateWithDuration(0.1) {
            self.tableview.alpha = 1.0
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }

    //MARK: - UITableView Delegate and DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableviewImages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GaleryCell", forIndexPath: indexPath) as! GaleryTableViewCell

        cell.imageGalery.image = UIImage(named: "\(self.tableviewImages[indexPath.row]).JPG")
        cell.imgName = self.tableviewImages[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableview.cellForRowAtIndexPath(indexPath) as! GaleryTableViewCell

        if let resourcePath = NSBundle.mainBundle().pathForResource(cell.imgName, ofType: "JPG") {
            previewDocumentAtPath(resourcePath)
        }
    }
    
    //MARK: - UIScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let visibleCells = self.tableview.visibleCells as! [GaleryTableViewCell]
        
        for cell: GaleryTableViewCell in visibleCells {
            cell.didScroll(self.tableview)
        }
    }
    
    //MARK: - UIDocumentInteractionController Delegate
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        if let navigationController = self.navigationController {
            return navigationController
        } else {
            return self
        }
    }
   
    func documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }

    func documentInteractionControllerRectForPreview(controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }

    func previewDocumentAtPath(filePath: String) {
        
        let fileUrl: NSURL = NSURL(fileURLWithPath: filePath)
        let interactionController: UIDocumentInteractionController = UIDocumentInteractionController(URL: fileUrl)
        interactionController.name = ""
        interactionController.delegate = self
    
        if interactionController.presentPreviewAnimated(true) {
            UIView.animateWithDuration(0.3) {
                self.tableview.alpha = 0.0
            }
        }

    }
}
