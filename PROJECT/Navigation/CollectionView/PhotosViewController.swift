import UIKit
import iOSIntPackage
import CoreFoundation

class ParkBenchTimer {
    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration: CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}

class PhotosViewController: UIViewController {
    
    //let imageFacade = ImagePublisherFacade()
    
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
    
    let photosCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    var imageList = (1...20).compactMap {UIImage(named: "photo\($0)")}
    var imagesProcessed = [UIImage]()
    
    let imageProcessor = ImageProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Photo Gallery"
        view.backgroundColor = .white
        view.addSubview(photosCollection)
        layout()
        photosCollection.dataSource = self
        photosCollection.delegate = self
        photosCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        filter()
        
        //imageFacade.subscribe(self)
        //imageFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: imageList)
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.imageFacade.removeSubscription(for: self)
//    }

    func filter() {
        let filters: [ColorFilter] = [.colorInvert, .fade, .chrome, .noir]
        let timer = ParkBenchTimer()
        imageProcessor.processImagesOnThread(sourceImages: imageList, filter: filters.randomElement() ?? .fade, qos: .userInteractive, completion: { cgImages in
            self.imagesProcessed = cgImages.map({UIImage(cgImage: $0!)})
            DispatchQueue.main.async {
                self.photosCollection.reloadData()
                print(self.imagesProcessed.count)
                print("\(timer.stop()) seconds.")
            }
        })
    }

    func layout() {
        NSLayoutConstraint.activate([
            photosCollection.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photosCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesProcessed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollection.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let data = imagesProcessed[indexPath.row]
        cell.setup(data)
        return cell
    }
    
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 32
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 32)/3
        return CGSize(width: width, height: width)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            let coordinator = PhotoCoordinator()
            coordinator.getCoordinator(navigation: navigationController, coordinator: coordinator, photoName: "photo" + String(indexPath.row+1))
        }
}

//extension PhotosViewController: ImageLibrarySubscriber {
//
//    func receive(images: [UIImage]) {
//        imageList.removeAll()
//        for i in images {
//            if !imageList.contains(i) {
//                imageList.append(i)
//            }
//        }
//        photosCollection.reloadData()
//    }
//}
