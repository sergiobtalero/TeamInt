import UIKit

final class TripsListViewController: UIViewController {
    private enum ViewConstants {
        static let screenTitle = "Trips"
    }
    
    // MARK: - IBOutlets and properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    private var refreshControl = UIRefreshControl()
    
    private var orderedTripsByDistanceViewModels: [TripTableViewModel] = []
    private var orderedTripsByIDViewModels: [TripTableViewModel] = []

    var presenter: TripsListPresenterContract?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        presenter?.fetchData()
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
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh(_ sender: AnyObject) {
        presenter?.fetchData()
    }
    
    func getViewModelsToRender() -> [TripTableViewModel] {
        return segmentedControl.selectedSegmentIndex == 0 ? orderedTripsByDistanceViewModels : orderedTripsByIDViewModels
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

// MARK: - UITableViewDelegate
extension TripsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(indexPath.row)
    }
}

// MARK: - TripsListViewContract
extension TripsListViewController: TripsListViewContract {
    func renderTrips(orderedByDistance: [TripTableViewModel], orderedByID: [TripTableViewModel]) {
        refreshControl.endRefreshing()
        orderedTripsByIDViewModels = orderedByID
        orderedTripsByDistanceViewModels = orderedByDistance
        tableView.reloadData()
    }
    
    // TODO: - Define Error behavior
    func showError() {
    }
}
