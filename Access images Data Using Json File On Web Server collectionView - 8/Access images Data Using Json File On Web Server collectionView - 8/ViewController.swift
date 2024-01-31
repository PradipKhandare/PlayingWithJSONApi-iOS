//
//  ViewController.swift
//  Access images Data Using Json File On Web Server collectionView - 8
//
//  Created by NTS on 31/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayOfJsonData = [JsonHelperFile]()
    
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
                self.arrayOfJsonData = try JSONDecoder().decode([JsonHelperFile].self, from: liveData)
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.resume()
    }
}


extension UIImageView
{
    func downloadImage(from url: URL, completion: @escaping(UIImage?) -> Void){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  error == nil,
                  let mimeType = response?.mimeType,
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfJsonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        let url = URL(string: arrayOfJsonData[indexPath.row].url)
        cell.imageView.downloadImage(from: url!) { image in
            if let image = image {
                cell.imageView.image = image
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
                return CGSize(width: size, height: size)
    }
    
}

