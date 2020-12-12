//
//  CameraViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 12/10/20.
//

import UIKit
import Parse


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!

  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  //Open camera if one exists
  @IBAction func opemCameraButton(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
      self.present(imagePicker, animated: true, completion: nil)
        }
  }
  
  //Open photo library
  @IBAction func openPhotoLibraryButton(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
      self.present(imagePicker, animated: true, completion: nil)
        }
  }
  
  //get chosen image and add to imageview
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
    imageView.image = image
      dismiss(animated:true, completion: nil)
  }
  
  @IBAction func onSubmitButton(_ sender: Any) {
    let image = PFObject(className: "User")
    
    image["username"] = PFUser.current()!
    
    let imageData = imageView.image!.pngData()
    let file = PFFileObject(name: "image.png", data:imageData!)
    
    image["image"] = file
  
    image.saveInBackground { (success, error) in
      if success {
        self.dismiss(animated: true, completion: nil)
        print("saved!")
      } else {
        print("error!")
      }
    }
  }
  
  
  @IBAction func onCancel(_ sender: UIButton) {
      self.dismiss(animated: true, completion: nil)
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
