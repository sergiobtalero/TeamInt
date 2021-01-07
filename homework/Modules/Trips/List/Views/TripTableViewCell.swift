import Domain
import UIKit

struct TripTableViewModel {
    let tripName: String
    let id: String
    let deliveryStatus: String
    let scheduledDelivery: String
    let deliveredOnDate: String
    
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
    @IBOutlet private weak var deliveredStatusLabel: UILabel!
    @IBOutlet private weak var scheduledDeliveryLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    
    func setup(with viewModel: TripTableViewModel) {
        idLabel.text = viewModel.id
        tripNameLabel.text = viewModel.tripName
        deliveredStatusLabel.text = viewModel.deliveryStatus
        scheduledDeliveryLabel.text = viewModel.scheduledDelivery
    }
}
