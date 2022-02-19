

import UIKit

class DetailsVC: UIViewController {

    
    
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var detailVoteRate: UILabel!
    @IBOutlet weak var detaillTextView: UITextView!
    @IBOutlet weak var detailTitleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    
    
    var detailMovieObj : MovieViewModel?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        // Image
        let defaultLink = "http://image.tmdb.org/t/p/w500"
        let completePath = defaultLink + self.detailMovieObj!.imgPath
        
        self.detailImgView.downloaded(from: completePath, contentMode : .scaleAspectFill)
        
        
        // title
        detailTitleLbl.text = detailMovieObj?.title
        
        
        // Text detail
        detaillTextView.text = detailMovieObj?.description
        
        
        // Relase date
        releaseDateLbl.text = detailMovieObj?.releaseDate
        
        // vote
        detailVoteRate.text = "\((detailMovieObj?.vote)!)"
        
     
        print(self.detailMovieObj!)
        
    }
    

   

}
