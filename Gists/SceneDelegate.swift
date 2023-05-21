//
//  SceneDelegate.swift
//  Gists
//
//  Created by Дмитрий Подольский on 24.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                window = UIWindow(windowScene: windowScene)
                let viewController = GistsCleanSwiftViewController()
                let interactor = GistsCleanSwiftInteractor()
                let presenter = GistsCleanSwiftPresenter() 
                let router = GistsCleanSwiftRouter()

                viewController.interactor = interactor
                viewController.router = router
                interactor.presenter = presenter
                presenter.viewController = viewController
                router.viewController = viewController
        window?.rootViewController = UINavigationController(rootViewController: viewController)
           window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

