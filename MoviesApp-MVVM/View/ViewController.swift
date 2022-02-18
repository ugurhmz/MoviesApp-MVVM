

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
   
    var dummyDatas = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=6fe8370265c396656c58d7dd9ff3e712&language=en-US")!
        
        WebService().fetchDatas(url: url) { result in
                print("wqeqweqwe",result)
            
            DispatchQueue.main.async {
                self.dummyDatas = result!
                self.collectionView.reloadData()
            }
        }
        
        
        
        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionWidth = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top:10, left:10, bottom:10, right:10)
        design.minimumInteritemSpacing = 5
        design.minimumLineSpacing = 5
        
        design.itemSize = CGSize(width: (collectionWidth-30)/3,
                                 height: (collectionWidth-30)/3
        )
        
        
        collectionView!.collectionViewLayout = design
        
       
        
        
        //4
        collectionView.delegate = self
        collectionView.dataSource = self
        
      
  
        
        
        
    }

}


// 1
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    
    // 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"movieCell", for: indexPath ) as! MovieCollectionViewCell
        
        cell.lblMovieimdb.text = "\(indexPath.row)"
        cell.lblMovieTitle.text = "\(dummyDatas[indexPath.row].title!)"
        
        // if let -> Label direk silinir gözükmez  & guard let genelde kullanılır force unwrap yapma!
        
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyDatas.count
    }
    
}
