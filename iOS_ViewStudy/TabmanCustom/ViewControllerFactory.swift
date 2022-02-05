//
//  ViewControllerFactory.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/02/05.
//

import UIKit

struct StoryboardRepresentation {
    let bundle: Bundle?
    let storyboardName: String
    let storyboardId: String
}


class ViewControllerFactory: NSObject {
    static func viewController(for typeOfVC: TypeOfViewController) -> UIViewController {
        let metaData = typeOfVC.storyboardRepresentation()
        let sb = UIStoryboard(name: metaData.storyboardName, bundle: metaData.bundle)
        let vc = sb.instantiateViewController(withIdentifier: metaData.storyboardId)
        return vc
    }
}

enum TypeOfViewController {
    case communityCategory
    
    static var communityCases: [TypeOfViewController] {
        [
            .communityCategory,
            .communityCategory,
            .communityCategory,
            .communityCategory,
            .communityCategory
        ]
    }
}

extension TypeOfViewController {
    func storyboardRepresentation() -> StoryboardRepresentation {
        switch self {
        case .communityCategory:
            return StoryboardRepresentation(bundle: nil, storyboardName: "PostFeed", storyboardId: "PostFeedVC")
        }
    }
}
