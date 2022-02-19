

import UIKit


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class ViewController: UIViewController {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
   
    private var movieListViewModel : MovieListViewModel!
    var selectedMvTitle : MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDatas()
        
        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionWidth = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top:10, left:10, bottom:10, right:10)
        design.minimumInteritemSpacing = 13
        design.minimumLineSpacing = 25
        
        design.itemSize = CGSize(width: (collectionWidth-58)/2,
                                 height: (collectionWidth-58)/2
        )
        
        
        collectionView!.collectionViewLayout = design
        
        //4
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    
   
    
    
    

}


// 1
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func getDatas(){
        // URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=6fe8370265c396656c58d7dd9ff3e712&language=en-US")!
        
        WebService().fetchDatas(url: url) { result in
                
            if let result = result {
                
                self.movieListViewModel = MovieListViewModel(movieList: result)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"movieCell", for: indexPath ) as! MovieCollectionViewCell
        
        
        let movieViewModel = self.movieListViewModel.movieAtIndex(indexPath.row)
        
        
        
        
        cell.lblMovieimdb.text = "\(movieViewModel.vote)"
        cell.lblMovieTitle.text = "\(movieViewModel.title)"
        
        cell.imgView.contentMode = .scaleAspectFill
        
        //  /5hNcsnMkwU2LknLoru73c76el3z.jpg
        let defaultLink = "http://image.tmdb.org/t/p/w500"
        
        
        
        let completePath = defaultLink + movieViewModel.imgPath
        
        cell.imgView.downloaded(from: completePath, contentMode : .scaleAspectFill)
        
        
        
        // if let -> Label direk silinir gözükmez  & guard let genelde kullanılır force unwrap yapma!
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        
        
        
        return cell
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieListViewModel == nil ? 0 : self.movieListViewModel.numberOfRowsInSection()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedMvTitle = self.movieListViewModel.movieAtIndex(indexPath.row)
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
       // print(self.movieListViewModel.movieAtIndex(indexPath.row).title)
    }
    
}


extension ViewController{
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            
            destinationVC.mvtitle = self.selectedMvTitle ?? nil
        }
    }
}
