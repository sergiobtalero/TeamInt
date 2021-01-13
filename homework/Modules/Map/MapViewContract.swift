protocol MapContract {
    typealias View = MapViewContract
    typealias Presenter = MapPresenterContract
}

protocol MapPresenterContract {}
protocol MapViewContract: AnyObject {}
