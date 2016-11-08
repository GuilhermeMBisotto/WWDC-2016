//
//  NavigationController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/19/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var backBtn: UIImage = UIImage(named: "backBtn")!
        backBtn = backBtn.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.backBarButtonItem?.title = ""
        
        self.navigationBar.backIndicatorImage = backBtn
        self.navigationBar.backIndicatorTransitionMaskImage = backBtn

    }
    
    override func shouldAutorotate() -> Bool {
        return (visibleViewController?.shouldAutorotate())!
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return (visibleViewController?.supportedInterfaceOrientations())!
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return (visibleViewController?.preferredInterfaceOrientationForPresentation())!
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.LightContent
        
        //Default
        //return UIStatusBarStyle.Default
    }
}
