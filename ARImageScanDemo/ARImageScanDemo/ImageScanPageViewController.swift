//
//  ImageScanPageViewController.swift
//  ARImageScanDemo
//
//  Created by zhangbotian on 2024/3/16.
//

import UIKit
import SceneKit
import ARKit

class ImageScanPageViewController: UIViewController {
    
    var arscnView: ARSCNView {
        let view = ARSCNView.init()
        
        return view
    }
    var arWordTrackingConfiguration: ARWorldTrackingConfiguration!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}

// 参考：https://www.jianshu.com/p/1f3adf9b3d96
