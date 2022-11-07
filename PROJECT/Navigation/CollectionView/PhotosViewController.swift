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
        
    }

    func filter() {
        let timer = ParkBenchTimer()
        imageProcessor.processImagesOnThread(sourceImages: imageList, filter: .fade, qos: .default, completion: { cgImages in
            self.imagesProcessed = cgImages.map({UIImage(cgImage: $0!)})
            DispatchQueue.main.async {
                self.photosCollection.reloadData()
                print(self.imagesProcessed.count)
                //тут видно что на этом моменте список фото уже подгружен в 20 к-во, то есть время загрузки точное
                print("\(timer.stop()) seconds.")
            }
        })
    }
    /*
     Получилось так, что время обработки и отображения фото на симуляторе сильно отличается
     Я так понимаю именно загрузка готовых фото занимаает долгое время, поэтому я с помощью секундомера буду замерять и это
     Тестовый симулятор IPhone 14 Pro, IOS 15.0
     .userInteractive - обработка фото = 6.13 sec; появление фото = 47.43 sec
     .userInitiated - обработка фото = 6.28 sec; появление фото = 47.42 sec
     .default - обработка фото = 6.03 sec; появление фото = 47.08 sec
     .background - обработка фото = 9.89 sec; появление фото = 49.98 sec
     .utility - обработка фото = 6.66 sec; появление фото = 47.25 sec
     */
    /*
     Получается что .default обработал быстрее всех, поэтому проведём тест на реальном устройстве именно с .default!
     Тестировать буду на IPhone 13 Pro IOS 16.0
     Обработка фото = 0.74 sec; появление фото = 23.14 sec
     Почему так долго появляются фото я честно говоря не понимаю
     И тут вопрос, если я в теории поставлю анимацию загрузки, до появления фото, это разве можно как то оттрекать?
     Нету ж команды, которая скажет мне когда отобразиться фото, ну или ошибаюсь?
     */
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
