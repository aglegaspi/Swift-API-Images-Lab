import Foundation

struct Comic: Codable {
    let img: String
    let num: Int
    
    static func getComic(comicNum: Int?, completionHandler: @escaping (Result<Comic, AppError>) -> ()){
        
        var url = "https://xkcd.com/info.0.json"
        
        if let comicNum = comicNum {
            url = "https://xkcd.com/\(comicNum)/info.0.json"
        }
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.badUrl))
            case .success(let data):
                do  {
                    let comic = try JSONDecoder().decode(Comic.self, from: data)
                    completionHandler(.success(comic))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
