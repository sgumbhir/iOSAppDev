//
//  ImageModel.swift
//  GumbhirSamikshaHW7
//
//  Created by Samiksha Gumbhir on 11/6/22.
//

import Foundation

class ImageModel: NSObject {
    public static let sharedInstance: ImageModel = ImageModel()
    private let photoCount = 20
    private let accessKey = "Client-ID OkROdAh5MNxWHfKXXsFH_6xkMM5o8q_OlNaBJMt_EEY"
    private let baseURL = "https://api.unsplash.com/photos/random?count=20"
    public var images = Array<Image>()
    
    override init(){
        super.init()
        
    }
    
    func getImages(onSuccess: @escaping ([Image]) -> Void){
        let url = URL(string: baseURL)!
        var urlRequest = URLRequest(url: url);
        urlRequest.addValue("Client-ID OkROdAh5MNxWHfKXXsFH_6xkMM5o8q_OlNaBJMt_EEY", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do{
                let decoder = JSONDecoder()
                print(data!)
                print(response!)
                self.images = try decoder.decode([Image].self, from: data!)
                self.images = self.images.sorted(by: { $0.likes > $1.likes})
                onSuccess(self.images)
            }
            catch{
                print(error)
                exit(1)
            }
        }
        
        task.resume()

    }
}
