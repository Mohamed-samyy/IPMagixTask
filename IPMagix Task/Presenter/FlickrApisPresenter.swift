//
//  FlickrApisPresenter.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//


import UIKit
import Alamofire

protocol FlickrApisProtocol {
    func APi_Success(response : FlickrResponseModel)
    func APi_Failed(errorMessage:String)
}

class FlickrApisPresenter: NSObject {
    static let sharedInstance = FlickrApisPresenter()
    var flickrApisDelegate : FlickrApisProtocol?
    var flickrApisData : FlickrResponseModel?
    var perPageNumber = 10

    func getBaseURL(currentPage: Int) -> String {
        let baseURLString = "Https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=50&text=New%20Movies%20posters&page=\(currentPage)&safe_search=1&per_page=10&api_key=d17378e37e555ebef55ab86c4180e8dc"
        return baseURLString
    }
    
    func getFlickrApis(pageNumber: Int) {
        Networking.RequestAPI(baseUrl: getBaseURL(currentPage: pageNumber), method: .get,model: flickrApisData) { (response, error) in
            if error == nil {
                if let responseObject = response as? FlickrResponseModel{
                    self.flickrApisDelegate?.APi_Success(response : responseObject)
                }
            }else{
                self.flickrApisDelegate?.APi_Failed(errorMessage:error!)
            }
        }
    }
}
