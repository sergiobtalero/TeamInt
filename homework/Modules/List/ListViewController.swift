import Injector
import Domain
import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let getTripsListUseCase = Injector.provideGetTripsListUseCase()
        getTripsListUseCase.execute { trips in
            print(trips)
        }
    }
}
