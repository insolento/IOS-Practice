import UIKit
import iOSIntPackage

class PostCellController: UITableViewCell {
    
    let postTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        return image
    }()
    
    let postDescription: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        return description
    }()
    
    let postLikes: UILabel = {
        let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let postViews: UILabel = {
        let views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        views.textAlignment = .right
        return views
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        addSubviews()
        layout()
    }
    
    public func filter(_ image: UIImage) -> UIImage {
        var actualPhoto = image
        let imageProcessor = ImageProcessor()
        let filters: [ColorFilter] = [.colorInvert, .fade, .chrome, .noir]
        let filter: ColorFilter = filters.randomElement() ?? .fade
        imageProcessor.processImage(sourceImage: actualPhoto , filter: filter) { filteredImage in actualPhoto = filteredImage ?? UIImage()}
        return actualPhoto
    }

    
    public func update(author: String, description: String, image: String, likes: Int, views: Int) {    
        postTitle.text = author
        postDescription.text = description
        postImage.image = filter(UIImage(named: image) ?? UIImage())
        postLikes.text = "Likes:" + String(likes)
        postViews.text = "Views:" + String(views)
    }
    
    func addSubviews() {
        contentView.addSubview(postTitle)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
        contentView.addSubview(postLikes)
        contentView.addSubview(postViews)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor),
            postImage.leadingAnchor.constraint(equalTo: postTitle.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: postTitle.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViews.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        contentView.heightAnchor.constraint(
            equalTo: postDescription.heightAnchor,
            constant: UIScreen.main.bounds.size.width + 100
        ).isActive = true
    }
}
