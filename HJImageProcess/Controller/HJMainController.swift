//
//  HJMainController.swift
//  HJImageProcess
//
//  Created by JoeShao on 15/8/21.
//  Copyright (c) 2015年 JoeShao. All rights reserved.
//

import UIKit
import Cartography

class HJMainController: UIViewController {

    var image:UIImage!
    var imageView:UIImageView!
    var titleLbl:UILabel!
    var takeBtn:UIButton!
    var selectBtn:UIButton!
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.setNavigationBarHidden(true, animated: true)
        image = UIImage(named: "background")
        imageView = UIImageView(image: image)
        
        view.addSubview(imageView)
        
        titleLbl = UILabel()
        titleLbl.textColor = UIColor.whiteColor()
        titleLbl.font = UIFont(name: "Chalkduster", size: 44)
        titleLbl.text = "Joe's APP"
        titleLbl.textAlignment = NSTextAlignment.Center
        imageView.addSubview(titleLbl)
        
        
        imagePicker = UIImagePickerController();
        imagePicker!.delegate = self;
        
        var takeImage = UIImage(named: "takePhoto")
        var selectImage = UIImage(named: "selectPhoto")
        selectBtn = UIButton()
        selectBtn.setImage(selectImage, forState: UIControlState.Normal)
        takeBtn = UIButton()
        takeBtn.setImage(takeImage, forState: UIControlState.Normal)
        
        selectBtn.addTarget(self, action: "goSelectImage", forControlEvents: UIControlEvents.TouchUpInside)
        takeBtn.addTarget(self, action: "goTakeImage", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(selectBtn)
        view.addSubview(takeBtn)
        self.configLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    func configLayout(){

        layout(imageView,titleLbl,selectBtn){ imageView,titleLbl,selectBtn in
            imageView.edges == imageView.superview!.edges
            
            titleLbl.top == titleLbl.superview!.top + 100
            titleLbl.centerX == imageView.centerX
            titleLbl.width == imageView.width/3*2
            
        }
        
        layout(selectBtn,takeBtn){ selectBtn,takeBtn in
            selectBtn.centerX == selectBtn.superview!.centerX
            selectBtn.bottom == selectBtn.superview!.bottom - 100
            takeBtn.bottom == selectBtn.top - 50
            takeBtn.centerX == selectBtn.centerX
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HJMainController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func goSelectImage(){
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker!, animated: true, completion: {})
    }
    
    func goTakeImage(){
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            var alert = UIAlertView(title: nil, message: "模拟器上无法使用相机，请在真实设备上使用", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        else{
            presentViewController(imagePicker!, animated: true, completion: {})
            imagePicker!.takePicture()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as? UIImage
        navigationController?.setNavigationBarHidden(false, animated: true)
        var editViewCtr = HJEditViewController()
        editViewCtr.imageList.append(ImageProcess.fixOrientation(image!))
        navigationController!.pushViewController(editViewCtr, animated: true)
        dismissViewControllerAnimated(true, completion: {})
    }
}
