import Foundation
import UIKit

struct NetworkService {
    
    func request(configuraion: AppConfiguration) {
        switch configuraion {
        case .people:
            getInfo(url: AppConfiguration.people.rawValue)
        case .planets:
            getInfo(url: AppConfiguration.planets.rawValue)
        case .starships:
            getInfo(url: AppConfiguration.starships.rawValue)
        }
    }
    
    private func getInfo(url: String) {
        if let url = URL(string: url) {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               if error == nil {
                   // Печатаем ответ
                   print("========================================")
                   print("Servers data is: " + String(data: data!, encoding: .utf8)!)
                   print("========================================")
                   if let response = response as? HTTPURLResponse {
                           print("Response HTTP Status code: \(response.statusCode)")
                   }
                   if let response = response as? HTTPURLResponse {
                       print("Response HTTP header fields: \(response.allHeaderFields)")
                   }
                   print("========================================")
                   
               } else {
                   print("========================================")
                   print("Debug description: \(error.debugDescription)")
                   print("========================================")
                   print("Localized description: \(String(describing: error?.localizedDescription))")
                   print("========================================")
               }
               
           }
           task.resume()
       } else {
           print("Couldn't find url")
       }
    }
}
