//
//  ViewController.swift
//  Access Data Using Json File On Web Server Array - 4
//
//  Created by NTS on 30/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    var dataHelperObject = [JsonDataHelper]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func clickHereButtonpressed(_ sender: UIButton) {
    fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let liveData = data, error == nil else {
                return
            }
            
            do {
                dataHelperObject = try JSONDecoder().decode([JsonDataHelper].self, from: liveData)
                print(dataHelperObject.count)
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async { [self] in
                dataHelperObject.forEach { jsonData in
                    print(jsonData.userId)
                    print(jsonData.id)
                    print(jsonData.title)
                    print(jsonData.body)
                    print("----------------------------------------------------------------------")
                }
                
            }
        }.resume()
    }
    
}

