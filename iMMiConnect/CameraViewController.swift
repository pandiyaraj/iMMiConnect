//
//  CameraViewController.swift
//  CameraFrameWorkSwift
//
//  Created by Pandiyaraj on 11/07/16.
//  Copyright © 2016 Pandiyaraj. All rights reserved.
//

import UIKit

typealias imageSelection = ((AnyObject?) -> Void)

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var completionHandler: ((_ obj: Any?)->Void)!
    
    
    func initWithController () -> (AnyObject)
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cameraViewController = mainStoryboard.instantiateViewController(withIdentifier: "CameraVc") as! CameraViewController
        return cameraViewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func croppedImage(image : UIImage , cropRect : CGRect) -> UIImage{
        UIGraphicsBeginImageContext(cropRect.size)
        image.draw(at: CGPoint(x: -cropRect.origin.x, y: -cropRect.origin.y))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return croppedImage!
    }
    
    func openCamera(_ sourceType : Int)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if sourceType == 1
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;

        }else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front;

        }
        imagePicker.allowsEditing = true
         DispatchQueue.main.async(execute: {
            self.present(imagePicker, animated: true, completion: nil)
        });
    }
    
    // MARK :: UIImagePickerController Delegate
    func imagePickerController(_ picker:UIImagePickerController!,didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        var image : UIImage!
        if (editingInfo[UIImagePickerControllerEditedImage] != nil){
            image = editingInfo[UIImagePickerControllerEditedImage] as! UIImage
        }else {
            image = editingInfo[UIImagePickerControllerOriginalImage]as! UIImage
        }
        if editingInfo[UIImagePickerControllerCropRect] != nil{
            image = self.croppedImage(image: image, cropRect: editingInfo[UIImagePickerControllerCropRect] as! CGRect)
            
        }
        completionHandler(image)
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: true, completion: nil)
        });
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completionHandler(nil)
        DispatchQueue.main.async(execute: {
        self.dismiss(animated: true, completion: nil)
        });
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
