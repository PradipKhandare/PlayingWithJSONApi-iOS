//
//  ViewController.swift
//  LazyLoading WebApi tableView
//
//  Created by NTS on 01/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonData = [JsonDataHandler]()
    var jsonLinks = [String]()
    var imageChacheData = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let liveData = data, error == nil else{
                return
            }
            
            do{
                jsonData = try JSONDecoder().decode([JsonDataHandler].self, from: liveData)
                for i in 0..<jsonData.count{
                    jsonLinks.append(jsonData[i].url)
                }
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.resume()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        self.tableView.reloadData()
    }
}

extension UIImageView
{
    func downloadImage(from url: URL, imageCache: NSCache<NSString, UIImage>, counter: String, completion: @escaping(UIImage?) -> Void) {
        image = UIImage(named: "1")
        if let savedImage = imageCache.object(forKey: NSString(string: counter)) {
            DispatchQueue.main.async {
                self.image = savedImage
                print("Fetching image from image cache. image no. \(counter)")
            }
        }else {
            contentMode = .scaleToFill
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data,
                      error == nil,
                      let httpUrlResponse = response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200,
                      let mimeType = response?.mimeType,
                      let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                    imageCache.setObject(image, forKey: NSString(string: counter))
                }
                completion(image)
            }
            dataTask.resume()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        let url = URL(string: jsonLinks[indexPath.row])
        cell.jsonImageView.downloadImage(from: url!, imageCache: imageChacheData, counter: String(indexPath.row)) { image in
            DispatchQueue.main.async {
                cell.jsonImageView.image = image
                cell.jsonImageView.layer.cornerRadius = 50
            }
        }
        return cell
    }
}

