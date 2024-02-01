//
//  ViewController.swift
//  LazyLoading WebApi collectionView
//
//  Created by NTS on 01/02/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var jsonData = [JsonDataHelper]()
    var allimageLinks = [String]()
    var imageChacheData = NSCache<NSString, UIImage>()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let allData = data, error == nil else {
                return
            }
            do{
                self.jsonData = try JSONDecoder().decode([JsonDataHelper].self, from: allData)
                for i in 0..<self.jsonData.count{
                    self.allimageLinks.append(jsonData[i].url)
                }
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
    func downloadImage(from url: URL, counter: String, imageCache: NSCache<NSString, UIImage>,  completion: @escaping(UIImage?) -> Void)
    {
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allimageLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        let url = URL(string: allimageLinks[indexPath.row])
        cell.jsonImageView.downloadImage(from: url!, counter: String(indexPath.row), imageCache: imageChacheData) { image in
            DispatchQueue.main.async {
                cell.jsonImageView.image = image
                cell.jsonImageView.layer.cornerRadius = 50
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

