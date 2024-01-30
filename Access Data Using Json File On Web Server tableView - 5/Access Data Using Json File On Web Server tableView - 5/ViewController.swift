//
//  ViewController.swift
//  Access Data Using Json File On Web Server tableView - 5
//
//  Created by NTS on 30/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var jsonData = [JsonData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let liveData = data, error == nil else {
                return
            }
             
            do{
                jsonData = try JSONDecoder().decode([JsonData].self, from: liveData)
            }catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }.resume()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        cell.userIDLabel.text = String(jsonData[indexPath.row].userId)
        cell.idLabel.text = String(jsonData[indexPath.row].id)
        cell.titleLabel.text = jsonData[indexPath.row].title
        cell.bodyLabel.text = jsonData[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    
}

