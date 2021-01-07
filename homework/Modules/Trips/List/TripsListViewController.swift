import Injector
import Domain
import UIKit

final class TripsListViewController: UIViewController {
    private enum ViewConstants {
        static let screenTitle = "Trips"
    }
    
    // MARK: - IBOutlets and properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    private var refreshControl = UIRefreshControl()
    
    private var orderedTripsByNameViewModels: [TripTableViewModel] = []
    private var orderedTripsByIDViewModels: [TripTableViewModel] = []
    
    // MARK: - Presenter
    private lazy var presenter: TripsListPresenterContract = {
        let getTripsUseCase = Injector.provideGetTripsListUseCase()
        let getTripsListMockedUseCase = Injector.provideGetTripsListMockedUseCase()
        
        return TripsListPresenter(view: self,
                                  getTripsListUseCase: getTripsUseCase,
                                  getTripsListMockedUseCase: getTripsListMockedUseCase)
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        presenter.fetchData()
    }
    
    @IBAction private func didTapSegmentedControlTab(_ sender: Any) {
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension TripsListViewController {
    func setupView() {
        title = ViewConstants.screenTitle
        navigationController?.navigationBar.barTintColor = .signatureBlue
    }
    
    func setupTableView() {
        let nib = UINib(nibName: "TripTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TripTableViewCell")
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh(_ sender: AnyObject) {
        presenter.fetchData()
    }
    
    func getViewModelsToRender() -> [TripTableViewModel] {
        return segmentedControl.selectedSegmentIndex == 0 ? orderedTripsByNameViewModels : orderedTripsByIDViewModels
    }
}

// MARK: - UITableViewDataSource
extension TripsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getViewModelsToRender().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = getViewModelsToRender()[indexPath.row]
        return viewModel.fill(on: tableView)
    }
}

// MARK: - TripsListViewContract
extension TripsListViewController: TripsListViewContract {
    func renderTrips(orderedByName: [TripTableViewModel], orderedByID: [TripTableViewModel]) {
        refreshControl.endRefreshing()
        orderedTripsByIDViewModels = orderedByID
        orderedTripsByNameViewModels = orderedByName
        tableView.reloadData()
    }
    
    // TODO: - Define Error behavior
    func showError() {
    }
}
