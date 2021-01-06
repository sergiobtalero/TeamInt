import Domain
import UIKit

struct TripTableViewModel {
    let trip: Trip
    
    func fill(on tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "TripTableViewCell") as? TripTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: self)
        return cell
    }
}

final class TripTableViewCell: UITableViewCell {
    @IBOutlet private weak var tripNameLabel: UILabel!
    
    func setup(with viewModel: TripTableViewModel) {
        tripNameLabel.text = viewModel.trip.typename
    }
}
