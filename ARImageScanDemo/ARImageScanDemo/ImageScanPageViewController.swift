//
//  ImageScanPageViewController.swift
//  ARImageScanDemo
//
//  Created by zhangbotian on 2024/3/16.
//

import UIKit
import SceneKit
import ARKit

class ImageScanPageViewController: UIViewController, ARSessionDelegate {
    
    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height - 200))
        sceneView.session = self.arSession
        sceneView.delegate = self
        sceneView.isPlaying = false
        return sceneView
    }()
    
    lazy var arSession: ARSession = {
        let session = ARSession()
        session.delegate = self
        return session
    }()
    
    lazy var arWordTrackingConfiguration: ARWorldTrackingConfiguration = {
        let refImage = ARReferenceImage.init((UIImage.init(named: "bg1")?.cgImage)!, orientation: .up, physicalWidth: 0.3)
        refImage.name = "bg1"
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = [refImage]
        return configuration
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    private func setUpSceneView() {
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(arWordTrackingConfiguration, options: options)
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
}

extension ImageScanPageViewController: ARSCNViewDelegate {
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let imageAnchor = anchor as? ARImageAnchor, let imageName = imageAnchor.referenceImage.name
        else { return }
        
        if imageName == "bg1" {
            print("识别出来了 bg1")
            
            let width = CGFloat(imageAnchor.referenceImage.physicalSize.height)
            let height = CGFloat(imageAnchor.referenceImage.physicalSize.height)
            let plane = SCNPlane(width: width, height: height)
            
            let label = UILabel()
            label.text = "bg1"
            label.sizeToFit()
//            plane.materials.first?.diffuse.contents = UIColor.white
            plane.materials.first?.diffuse.contents = label
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.position = SCNVector3(0,0,0)
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
        }
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
        let planeNode = node.childNodes.first,
        let plane = planeNode.geometry as? SCNPlane
        else { return }

        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height

        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}

// 参考：https://www.jianshu.com/p/1f3adf9b3d96
