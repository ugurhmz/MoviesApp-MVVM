


import Foundation


final class WebService {
    

    
    func fetchDatas(url: URL, completion: @escaping([Result]?) -> ()) {



        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                completion(nil)
            } else if let data = data {

                

                do {

                  let   movieList = try JSONDecoder().decode(Welcome.self, from: data)

                    print(movieList)


                    completion(movieList.results)


                } catch {
                    print("ERR")
                }
            }



        }.resume()
    }
//
//    func getDatas(){
//         let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=6fe8370265c396656c58d7dd9ff3e712&language=en-US&page=1"
//
//        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
//            data, response, error in
//
//            guard let data = data, error == nil else {
//                return
//            }
//
//
//            var json : Welcome?
//
//            do {
//                json = try JSONDecoder().decode(Welcome.self, from:data)
//
//            } catch(let error) {
//                print("err", error)
//            }
//
//
//        }).resume()
//    }
//
    
    
    
}
