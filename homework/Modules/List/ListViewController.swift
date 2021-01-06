import Injector
import Domain
import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let getTripsListUseCase = Injector.provideGetTripsListUseCase()

        getTripsListUseCase.execute().done { trips in
            print(trips)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
