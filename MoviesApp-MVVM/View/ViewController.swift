

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
   
    var dummyDatas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionWidth = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top:10, left:10, bottom:10, right:10)
        design.minimumInteritemSpacing = 5
        design.minimumLineSpacing = 5
        
        design.itemSize = CGSize(width: (collectionWidth-30)/3,
                                 height: (collectionWidth-30)/3
        )
        
        
        collectionView!.collectionViewLayout = design
        
       
        dummyDatas = ["Cherry","Pear","Apple","Grape","Sour Cherry","Fig","Blueberries","Plum","Cherry"]
        
        //4
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}


// 1
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 3
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"movieCell", for: indexPath ) as! MovieCollectionViewCell
        
        cell.lblMovieimdb.text = "\(indexPath.row)"
        cell.lblMovieTitle.text = "\(dummyDatas[indexPath.row])"
        
        
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
