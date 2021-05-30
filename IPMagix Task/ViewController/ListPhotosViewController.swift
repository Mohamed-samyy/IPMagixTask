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
    let adBannerURL = "https://cgtricks.com/wp-content/uploads/2017/04/LL-Ad-Banner.png"
    var pageNumber : Int = 1
    var isLoadMore : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie's photos"
        getPhotos(offset: pageNumber)

    }
    override func viewDidAppear(_ animated: Bool) {
        getLocalData()

    }

    func getPhotos(offset:Int){
        if CoreDataManager.sharedInstance.getPhotos().count == 0 {
            getFlickrApi(pageNumber: 1)
        }else{
            
//            let storedRepos = CoreDataManager.sharedInstance.getPhotos(offset: offset) as! [MoviePhotos]
            
            
            if CoreDataManager.sharedInstance.getPhotos(offset: offset).count >= 10 {
                isLoadMore = true
//                finalArray.append(contentsOf: storedRepos)
                self.photosTableView.finishInfiniteScroll()
                self.photosTableView.reloadData()
            }
            else {
                isLoadMore = false
                self.photosTableView.finishInfiniteScroll()
            }
        }
    }
    
    
    func getLocalData(){
        photosTableView.addInfiniteScroll { (table) in
            if self.isLoadMore {
                self.pageNumber += 1
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
            cell.photo.setKFImage(imageUrl: adBannerURL)
            return cell
        case .normalView(let photo):
            let cell = tableView.dequeueReusableCell(withIdentifier: PHOTO_CELL_IDENTIFIER) as! PhotosTableViewCell
            cell.testLabel.text = photo.title
            cell.photo.setKFImage(imageUrl: photo.imageURL)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullScreenPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenPhotoViewController") as! FullScreenPhotoViewController
        let photo = photoViewModel.viewTypes[indexPath.row]
        switch photo {
        case .ad:
            fullScreenPhotoVC.imageTitle = "Ad Banner"
            fullScreenPhotoVC.imageURL = adBannerURL
        case .normalView(let photo):
            fullScreenPhotoVC.imageTitle = photo.title
            fullScreenPhotoVC.imageURL = photo.imageURL
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
        if (response.photos?.photo?.count ?? 0) >= 10{
            isLoadMore =  true
        }
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
