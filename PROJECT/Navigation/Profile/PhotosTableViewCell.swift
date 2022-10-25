import UIKit
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    
    let photoTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.textColor = .black
        title.text = "Photos"
        return title
    }()
    
    let arrowView: UILabel = {
        let arrowView = UILabel()
        arrowView.text = "→"
        arrowView.font = UIFont.boldSystemFont(ofSize: 24)
        arrowView.textColor = .black
        arrowView.textAlignment = .right
        return arrowView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 8.0
        return stackView
    }()
    
    let firstPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        photo.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.image = UIImage(named: "photo1")
        return photo
    }()
    
    let secondPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        photo.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.image = UIImage(named: "photo2")
        return photo
    }()
    
    let thirdPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        photo.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.image = UIImage(named: "photo3")
        return photo
    }()
    
    let forthPhoto: UIImageView = {
        let photo = UIImageView()
        //photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        photo.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
        photo.image = UIImage(named: "photo4")
        return photo
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews()
        autoresizingMask()
        layout()
        //filtering()
    }
    
    func addSubviews() {
        contentView.addSubview(stackView)
        contentView.addSubview(photoTitle)
        contentView.addSubview(arrowView)
        stackView.addArrangedSubview(firstPhoto)
        stackView.addArrangedSubview(secondPhoto)
        stackView.addArrangedSubview(thirdPhoto)
        stackView.addArrangedSubview(forthPhoto)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            photoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoTitle.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            arrowView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            arrowView.centerYAnchor.constraint(equalTo: photoTitle.centerYAnchor),
            stackView.topAnchor.constraint(equalTo: photoTitle.bottomAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func autoresizingMask() {
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        photoTitle.translatesAutoresizingMaskIntoConstraints = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    func filtering() {
//        firstPhoto.image = filter(firstPhoto.image ?? UIImage())
//        secondPhoto.image = filter(secondPhoto.image ?? UIImage())
//        thirdPhoto.image = filter(thirdPhoto.image ?? UIImage())
//        forthPhoto.image = filter(forthPhoto.image ?? UIImage())
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ data: String) {
        print(data)
    }
    
//    func filter(_ image: UIImage) -> UIImage {
//        var actualPhoto = image
//        let imageProcessor = ImageProcessor()
//        let filters: [ColorFilter] = [.colorInvert, .fade, .chrome, .noir]
//        let filter: ColorFilter = filters.randomElement() ?? .fade
//        imageProcessor.processImage(sourceImage: actualPhoto , filter: filter) { filteredImage in actualPhoto = filteredImage ?? UIImage()}
//        return actualPhoto
//    }
    
}
