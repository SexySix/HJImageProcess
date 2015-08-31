//
//  HJEditViewController.swift
//  HJImageProcess
//
//  Created by JoeShao on 15/8/24.
//  Copyright (c) 2015年 JoeShao. All rights reserved.
//

import UIKit
import Cartography

class HJEditViewController: UIViewController {

    var imageList: [UIImage] = []
    var imageView:UIImageView!
    var toolBar:UIToolbar!
    var btnForHSV:UIBarButtonItem!
    var btnForAdjust:UIBarButtonItem!
    lazy var process:ImageProcess = {
        let p = ImageProcess()
        p.filter = CIFilter(name:"CIColorControls")
        p.orginalImage = CIImage(image: self.imageList[0])
        p.filter!.setValue(p.orginalImage!, forKey: kCIInputImageKey)
        return p
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.translucent = false
        
        imageView = UIImageView(image: imageList[0])
        
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
        
        toolBar = UIToolbar()
        btnForHSV = UIBarButtonItem(title: "HSV", style: UIBarButtonItemStyle.Plain, target: self, action: "showsliderView")
        
        btnForAdjust = UIBarButtonItem(title: "ADJUST", style: UIBarButtonItemStyle.Plain, target: self, action: "adjustImage")
        
        view.addSubview(toolBar)
        
        toolBar.items = [btnForHSV,btnForAdjust]
        
        self.configLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func configLayout (){
        layout(imageView,toolBar){
            imageView,toolBar in
            
            toolBar.height == 50
            toolBar.bottom == toolBar.superview!.bottom
            toolBar.width == toolBar.superview!.width
            
            imageView.edges == inset(imageView.superview!.edges, 0, 0, 50, 0)
        }
    }
    
    private lazy var sliderView:UIView = {
        let sView = UIView()
        sView.hidden = true
        self.view.addSubview(sView)
        let sLbl = UILabel()
        sLbl.text = "饱和度"
        let bLbl = UILabel()
        bLbl.text = "亮度"
        let cLbl = UILabel()
        cLbl.text = "对比度"
        
        sView.addSubview(sLbl)
        sView.addSubview(bLbl)
        sView.addSubview(cLbl)
        
        var sSlider = UISlider()
        sSlider.tag = 90001
        sSlider.minimumValue = 0
        sSlider.maximumValue = 2
        sSlider.value = 1
        sView.addSubview(sSlider)
        
        var bSlider = UISlider()
        bSlider.tag = 90002
        bSlider.minimumValue = -1
        bSlider.maximumValue = 1
        bSlider.value = 0
        sView.addSubview(bSlider)
        
        var cSlider = UISlider()
        cSlider.tag = 90003
        cSlider.minimumValue = 0
        cSlider.maximumValue = 2
        cSlider.value = 1
        sView.addSubview(cSlider)
        
        sSlider.addTarget(self, action: "sliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        bSlider.addTarget(self, action: "sliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        cSlider.addTarget(self, action: "sliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        
        layout(sView,self.toolBar){ sView,toolBar in
            sView.width == sView.superview!.width
            sView.centerX == sView.superview!.centerX
            sView.bottom == toolBar.top
            sView.height == 140
        }
        
        layout(sSlider,sLbl){ sSlider,sLbl in
            sSlider.top == sSlider.superview!.top
            sLbl.width == 60
            sLbl.left == sLbl.superview!.left+10
            sSlider.left == sLbl.right+10
            sSlider.height == 30
            sLbl.height == sSlider.height
            sSlider.right == sSlider.superview!.right - 10
            sLbl.centerY == sSlider.centerY
            
        }
        
        layout(sSlider,bSlider,cSlider){ sSlider,bSlider,cSlider in
            distribute(by: 10, vertically: sSlider,bSlider,cSlider)
            align(left: sSlider,bSlider,cSlider)
            align(right: sSlider,bSlider,cSlider)
            bSlider.height == sSlider.height
            cSlider.height == sSlider.height
        }
        layout(sLbl,bLbl,cLbl){ sLbl,bLbl,cLbl in
            align(left: sLbl,bLbl,cLbl)
            align(right: sLbl,bLbl,cLbl)
            bLbl.height == sLbl.height
            cLbl.height == sLbl.height
            distribute(by: 10, vertically: sLbl,bLbl,cLbl)
        }
        
        return sView
    }()
}

extension HJEditViewController{
    
    func showsliderView() {
        sliderView.hidden = !sliderView.hidden
    }
    
    func sliderValueChange(slider:UISlider){
        
        var key:String?
        switch slider.tag {
        case 90001:
            key = kCIInputSaturationKey
        case 90002:
            key = kCIInputBrightnessKey
        case 90003:
            key = kCIInputContrastKey
        default:
            break
        }
        if (key != nil){
            imageView.image = process.changeImage(key!, value: slider.value)
        }
        
    }
    
    func adjustImage(){
        imageView.image = process.adjustImage(imageList[0])
    }
}
