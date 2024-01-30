//
//  ViewController.swift
//  Access Data Using Web Api Image - 3
//
//  Created by NTS on 30/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlImageView: UIImageView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var dataFromJson = [JsonDataHelper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetchData()
    }

    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let liveData = data, error == nil else {
                return
            }
            
            do{
                self.dataFromJson = try JSONDecoder().decode([JsonDataHelper].self, from: liveData)
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async { [self] in
                self.nameLabel.text = String(self.dataFromJson[0].albumId)
                self.idLabel.text = String(self.dataFromJson[0].id)
                self.titleLabel.text = self.dataFromJson[0].title
                
                urlImageView.downloadImage(from: URL(string: self.dataFromJson[0].url)!) { [self] image in
                    if let image = image {
                        urlImageView.image = image
                    }else {
                        print(error as Any)
                    }
                }
                
                urlImageView.downloadImage(from: URL(string: self.dataFromJson[0].thumbnailUrl)!) { [self] image in
                    if let image = image {
                        thumbnailImageView.image = image
                    }else {
                        print(error as Any)
                    }
                }
            }
        }.resume()
    }

}

extension UIImageView
{
    func downloadImage(from url: URL, completion: @escaping(UIImage?) -> Void){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpUrlResponse = response as? HTTPURLResponse, 
                    httpUrlResponse.statusCode == 200,
                    let mimeType = response?.mimeType,
                    let liveData = data,
                    error == nil,
                    let image = UIImage(data: liveData) else {
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
