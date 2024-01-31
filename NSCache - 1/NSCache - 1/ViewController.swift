//
//  ViewController.swift
//  NSCache - 1
//
//  Created by NTS on 31/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var downloadedImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var imageCache = NSCache<AnyObject,AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func downloadImageButtonPressed(_ sender: UIButton) {
        let urlImage = URL(string: urlTextField.text!)
        downloadedImageView.downloadImage(from: urlImage!) { image in
            if let image = image {
                self.downloadedImageView.image = image
            }
        }
    }
    
    @IBAction func storeImageInNSCachePressed(_ sender: UIButton) {
        let urlImage = URL(string: urlTextField.text!)
        imageCache.setObject(downloadedImageView.image!, forKey: urlImage?.absoluteString as AnyObject)
        statusLabel.text = "Image stored in NSCache."
    }
    
    @IBAction func clearImageButtonPressed(_ sender: UIButton) {
        downloadedImageView.image = nil
        statusLabel.text = "downloaded image have been cleared."
        
    }
    
    @IBAction func fetchImageButtonPressed(_ sender: UIButton) {
        let urlImage = URL(string: urlTextField.text!)
        if let imageFromCache = imageCache.object(forKey: urlImage?.absoluteString as AnyObject) as? UIImage
        {
            downloadedImageView.image = imageFromCache
            statusLabel.text = "fetch successfulluy."
            return
        }else {
            statusLabel.text = "No image available for fetch."
        }
    }
    
    @IBAction func clearNSCacheDatapressed(_ sender: UIButton) {
        imageCache.removeAllObjects()
        statusLabel.text = "NSCache has been cleared successfully."
    }
}

extension UIImageView
{
    func downloadImage(from url: URL, completion: @escaping(UIImage?) -> Void){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data,
                  error == nil,
                  let httpResponse = response as? HTTPURLResponse,
                  let mimeType = response?.mimeType,
                  httpResponse.statusCode == 200,
                  let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        dataTask.resume()
    }
}

