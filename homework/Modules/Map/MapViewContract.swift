import Domain
import MapKit

protocol MapContract {
    typealias View = MapViewContract
    typealias Presenter = MapPresenterContract
}

protocol MapPresenterContract {
    func viewDidLoad()
}

protocol MapViewContract: AnyObject {
    func renderRoute(_ route: MKRoute)
}
