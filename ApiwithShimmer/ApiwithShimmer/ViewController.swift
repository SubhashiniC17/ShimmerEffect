//
//  ViewController.swift
//  ApiwithShimmer
//
//  Created by Subhashini Chandranathan on 16/05/24.
//

import UIKit
import SkeletonView

class ViewController: UIViewController{
    
    @IBOutlet var headerLabel : UILabel!
    @IBOutlet weak var mainTableView : UITableView!
    var allData = [sampleData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainTableView.rowHeight = 70
        mainTableView.estimatedRowHeight = 70
        
        let url = "https://jsonplaceholder.typicode.com/photos"
        getDataFromUrl(url: url)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainTableView.isSkeletonable = true
        mainTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .link),animation: nil,transition: .crossDissolve(0.25))
    }
    
    
    func getDataFromUrl(url : String){
        let url = URL(string: url)
        let task = URLSession.shared.dataTask(with: url!){ [self](data,response,error) in
            do {
                print("Data == >", data as Any )
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([sampleData].self, from: data!)
                print("Response ==>",response)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3,execute: {
                    //                    for _ in 0..<30{
                    self.allData = response
                    //                    }
                    self.mainTableView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self.mainTableView.reloadData()
                })
                
            }catch{
                print("error",error.localizedDescription)
                print("error==>",error)
            }
        }
        task.resume()
        
    }
    
}
extension UIImageView{
    func loadImage(from url : URL){
        let urlImage = URLSession.shared.dataTask(with: url,completionHandler: {(data, response, error) in
            guard let urlHttp = response as? HTTPURLResponse, urlHttp.statusCode == 200,
                  let urlType = response?.mimeType, urlType.hasPrefix("image"),
                  let data = data , error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
       })
        urlImage.resume()
    }
    
}
extension ViewController : UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("allData==>", allData.count )
        return allData.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "ImageTableViewCell"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath)as! ImageTableViewCell
        if !allData.isEmpty{
            let urlImage = URL(string: allData[indexPath.row].thumbnailUrl ?? "")
            cell.sampleImage.loadImage(from: urlImage!)
            cell.sampleTitle.text = allData[indexPath.row].title
            cell.selectionStyle = .none
            
        }
        return cell
    }
}
