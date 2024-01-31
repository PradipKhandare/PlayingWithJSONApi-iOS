//
//  ViewController.swift
//  Access random images Data Using Json File On Web Server - 9
//
//  Created by NTS on 31/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var jsonImageView: UIImageView!
    
    var arrayOfJsonData = [JsonDataHelper]()
    var arrayOfImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let liveData = data, error == nil else {
                return
            }
            
            do{
                self.arrayOfJsonData = try JSONDecoder().decode([JsonDataHelper].self, from: liveData)
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async {
            
            }
        }.resume()
    }

    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        
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

