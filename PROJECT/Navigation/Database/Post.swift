import Foundation
import iOSIntPackage
import UIKit

struct Post {
    var id: UUID
    var author: String
    var description: String?
    var image: String
    var likes: Int
    var views: Int
}

final class Posts {
    
    var postsArray =
    [
        Post(id: UUID(),
             author: "holliwood_news",
             description: PostDescriptions.holliwoodNewsHamilton,
             image: "holliwoodNewsHamiltonPhoto",
             likes: 2446,
             views: 5400),
        Post(id: UUID(),
             author: "ottofab",
             description: PostDescriptions.ottofabDog,
             image: "ottofabDogPhoto",
             likes: 17428,
             views: 25345),
        Post(id: UUID(),
             author: "sphynxcatlovers",
             description: PostDescriptions.sphynxcatloversCat,
             image: "sphynxcatloversCatPhoto",
             likes: 3034,
             views: 12550),
        Post(id: UUID(),
             author: "infocar.ua",
             description: PostDescriptions.infocarSilverado,
             image: "infocarSilveradoPhoto",
             likes: 445,
             views: 1200),
        Post(id: UUID(),
             author: "marvel",
             description: PostDescriptions.marvelEternals,
             image: "marvelEternalsPhoto",
             likes: 1266291,
             views: 13544234)
    ]
}
