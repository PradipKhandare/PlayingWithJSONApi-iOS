//
//  ViewController.swift
//  Access images Data Using Json File On Web Server tableView - 7
//
//  Created by NTS on 31/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayData = [JsonDataHelper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getData()
    }
    
    func getData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let allData = data,
                  error == nil else {
                return
            }
            
            do{
                self.arrayData = try JSONDecoder().decode([JsonDataHelper].self, from: allData)
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                  
        }.resume()
    }

}

extension UIImageView
{
    func getImage(from url: URL, completion:@escaping(UIImage?) -> Void) {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  error == nil,
                  let image = UIImage(data: imageData),
                  let mimeType = response?.mimeType else {
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

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        cell.idLabel.text = String(arrayData[indexPath.row].id)
        cell.urlLabel.text = arrayData[indexPath.row].url
        
        let urlImage = URL(string: arrayData[indexPath.row].url)
        cell.jsonImageView.getImage(from: urlImage!) { image in
            if let image = image {
                cell.jsonImageView.image = image
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
}


