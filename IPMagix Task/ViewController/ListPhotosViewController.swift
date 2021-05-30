//
//  ViewController.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/28/21.
//

import UIKit
import CoreData


class ListPhotosViewController: UIViewController {


    @IBOutlet weak var photosTableView: UITableView!
    
    var photoViewModel: PhotosViewModel = PhotosViewModel()
    let PHOTO_CELL_IDENTIFIER = "PhotosTableViewCell"
    var pageNumber : Int = 0
    var PageSize = 10
    var isLoadMore : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "movie's photos"
        getLocalData()
        getFlickrApi(pageNumber: 1)

    }
    func getLocalData(){
        photosTableView.addInfiniteScroll { (table) in
            if self.isLoadMore {
                self.pageNumber += 10
                self.getFlickrApi(pageNumber: self.pageNumber)
            }else{
                table.finishInfiniteScroll()
            }
        }
    }
    
    func getFlickrApi(pageNumber: Int)  {
        self.showLoader()
        let flickrApiObject = FlickrApisPresenter()
        flickrApiObject.getFlickrApis(pageNumber: pageNumber)
        flickrApiObject.flickrApisDelegate = self
    }

    func createImageURL(farm: Int,server: String,id: String,secret: String) -> String {
        return ("https://farm\(String(describing: farm)).staticflickr.com/\(String(describing: server))/\(String(describing: id))_\(String(describing: secret)).jpg")
    }
}

extension ListPhotosViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewType = photoViewModel.viewTypes[indexPath.row]
        switch viewType {
        case .ad:
            let cell = tableView.dequeueReusableCell(withIdentifier: PHOTO_CELL_IDENTIFIER) as! PhotosTableViewCell
            cell.testLabel.text = "Ad Banner"
            cell.photo.setKFImage(imageUrl:  "")
            return cell
        case .normalView(let photo):
            let cell = tableView.dequeueReusableCell(withIdentifier: PHOTO_CELL_IDENTIFIER) as! PhotosTableViewCell
            cell.testLabel.text = photo.title
            let imageurl = createImageURL(farm: photo.farm, server: photo.server, id: photo.id, secret: photo.secret)
            cell.photo.setKFImage(imageUrl: imageurl)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullScreenPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenPhotoViewController") as! FullScreenPhotoViewController
        let photo = photoViewModel.viewTypes[indexPath.row]
        switch photo {
        case .ad:
            fullScreenPhotoVC.imageTitle = "Ad Banner"
        case .normalView(let photo):
            fullScreenPhotoVC.imageTitle = photo.title
            let imageurl = createImageURL(farm: photo.farm, server: photo.server, id: photo.id, secret: photo.secret)
            fullScreenPhotoVC.imageURL = imageurl
        }
        self.navigationController?.pushViewController(fullScreenPhotoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

extension ListPhotosViewController: FlickrApisProtocol{
    func APi_Success(response: FlickrResponseModel) {
        self.hideLoader()
        photoViewModel.photos = response.photos?.photo
        photoViewModel.getApi {
            photosTableView.reloadData()
        }
    }
    
    func APi_Failed(errorMessage: String) {
        self.hideLoader()
        let alert = UIAlertController(title: "", message: "Something went wrong".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
