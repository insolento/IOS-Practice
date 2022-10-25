import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let imageFacade = ImagePublisherFacade()
    
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
    
    let photosCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    var imageList: [UIImage] = [
        UIImage(named: "photo1") ?? UIImage(),
        UIImage(named: "photo2") ?? UIImage(),
        UIImage(named: "photo3") ?? UIImage(),
        UIImage(named: "photo4") ?? UIImage(),
        UIImage(named: "photo5") ?? UIImage(),
        UIImage(named: "photo6") ?? UIImage(),
        UIImage(named: "photo7") ?? UIImage(),
        UIImage(named: "photo8") ?? UIImage(),
        UIImage(named: "photo9") ?? UIImage(),
        UIImage(named: "photo10") ?? UIImage(),
        UIImage(named: "photo11") ?? UIImage(),
        UIImage(named: "photo12") ?? UIImage(),
        UIImage(named: "photo13") ?? UIImage(),
        UIImage(named: "photo14") ?? UIImage(),
        UIImage(named: "photo15") ?? UIImage(),
        UIImage(named: "photo16") ?? UIImage(),
        UIImage(named: "photo17") ?? UIImage(),
        UIImage(named: "photo18") ?? UIImage(),
        UIImage(named: "photo19") ?? UIImage(),
        UIImage(named: "photo20") ?? UIImage()
    ]
    
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
        
        imageFacade.subscribe(self)
        imageFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: imageList)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.imageFacade.removeSubscription(for: self)
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
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollection.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let data = imageList[indexPath.row]
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
            print("Did select cell at \(indexPath.row)")
            let newViewController = PhotosOpenViewController()
            let photoName = "photo" + String(indexPath.row+1)
            newViewController.setup(photoName)
            navigationController?.pushViewController(newViewController, animated: true)
        }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        imageList.removeAll()
        for i in images {
            if !imageList.contains(i) {
                imageList.append(i)
            }
        }
        photosCollection.reloadData()
    }
}
