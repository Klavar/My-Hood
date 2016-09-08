//
//  AddPostVC.swift
//  My-Hood
//
//  Created by Tony Merritt on 07/09/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        postImage.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
    }

    @IBAction func makePostButtonPressed(sender: AnyObject) {
        if let title = titleField.text, let desc = descriptionField.text, let image = postImage.image{
            
          let imagePath = DataService.instance.saveImageAndCreatePath(image)
            
        
            let post = Post(imagePath: imagePath, title: title, description: desc)
            DataService.instance.addPost(post)
        dismissViewControllerAnimated(true, completion: nil)
        
        }
        
    }
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addPicButtonPressed(sender: UIButton) {
        
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
    }
    
}
