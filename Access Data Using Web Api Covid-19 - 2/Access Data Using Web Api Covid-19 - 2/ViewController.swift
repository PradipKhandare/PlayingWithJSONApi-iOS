//
//  ViewController.swift
//  Access Data Using Web Api Covid-19 - 2
//
//  Created by NTS on 30/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var dataObject : DataFromJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
        URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let liveData = data, error == nil else {
                print("Error Occured")
                return
            }
            
            do{
                try dataObject = try JSONDecoder().decode(DataFromJSON.self, from: liveData)
            }catch {
                print(error)
            }
            guard let jData = dataObject else {
                return
            }
            DispatchQueue.main.async {
                self.nameLabel.text = String(dataObject!.userId)
                self.idLabel.text = String(dataObject!.id)
                self.titleLabel.text = String(dataObject!.title)
                self.bodyLabel.text = String(dataObject!.body)
            }
        }.resume()
    }

}


