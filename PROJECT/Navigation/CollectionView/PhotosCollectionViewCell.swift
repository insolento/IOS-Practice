import UIKit
import iOSIntPackage

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ photosName: UIImage) {
        let actualPhoto = photosName
        photo.image = actualPhoto
//        actualPhoto = UIImage(data: (actualPhoto ?? UIImage()).jpegData(compressionQuality: 0.1) ?? Data())
//        let imageProcessor = ImageProcessor()
//        let filters: [ColorFilter] = [.colorInvert, .fade, .chrome, .noir]
//        let filter: ColorFilter = filters.randomElement() ?? .fade
//        imageProcessor.processImage(sourceImage: actualPhoto ?? UIImage(), filter: filter) { filteredImage in photo.image = filteredImage}
    }
    private func photoSetup(image: UIImage?) {
        photo.image = image ?? UIImage()
        if image != nil {
            print("photo")
        }
    }
}

extension PhotosCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}


