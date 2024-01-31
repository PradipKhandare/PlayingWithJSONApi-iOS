//
//  ViewController.swift
//  Access Data Using Json File On Web Server tableView - 6
//
//  Created by NTS on 31/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfJsonData = [JsonHelper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let allData = data, error == nil else{
                return
            }
            
            do{
                self.arrayOfJsonData = try JSONDecoder().decode([JsonHelper].self, from: allData)
            }catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfJsonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        cell.idLabel.text = String(arrayOfJsonData[indexPath.row].id)
        cell.titleLabel.text = arrayOfJsonData[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
}

