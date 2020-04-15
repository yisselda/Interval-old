import UIKit

class ComboDetailViewController: UIViewController, Storyboarded {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        name.resignFirstResponder()
        pickImage()
    }
}

//MARK: UIImagePickerControllerDelegate
extension ComboDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissPicker()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        
        dismissPicker()
    }
    
    func dismissPicker() {
        dismiss(animated: true, completion: nil)
    }
}
