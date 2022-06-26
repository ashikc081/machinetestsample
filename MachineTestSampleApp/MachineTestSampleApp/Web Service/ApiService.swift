//
//  ApiService.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 24/06/22.
//

import Foundation

class ApiService: NSObject {
    
    private let homeDataUrl = URL(string: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0")!
    
    func getHomeDataApi(completion: @escaping (HomeDataModel) -> ()) {
        URLSession.shared.dataTask(with: homeDataUrl) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let homeData = try! jsonDecoder.decode(HomeDataModel.self, from: data)
                completion(homeData)
            }
        }.resume()
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
