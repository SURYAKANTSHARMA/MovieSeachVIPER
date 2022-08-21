//
//  SceneDelegate.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var repository: OfflineFavouriteRepositoryInterface = OfflineFavouriteRepository()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let widow = UIWindow(windowScene: scene)
        
        widow.rootViewController =
        UINavigationController(rootViewController: MovieSearchBuilder().view())
        widow.makeKeyAndVisible()
        
        self.window = widow
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {


        if let movieSearchVC = (window?
            .rootViewController as? UINavigationController)?.viewControllers.first as? MovieSearchViewController {
            let favourites = movieSearchVC.movies.filter(\.isFavourite)
            do {
                try repository.save(favourites)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

