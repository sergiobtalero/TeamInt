import Domain

enum DateFormat: String {
    case withTime = "yyyy-MM-dd'T'HH:mm:ssZ"
    case withoutTime = "yyyy-MM-dd"
}

extension String {
    func toDate(format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}

struct TripEntity: DataEntity {
    let typename: String
    let id: String
    let deliveryStatus: String
    let progress: String
    let deliveredAt: String
    let scheduledDeliveryOn: String
    let truckingOrder: TruckingOrderEntity

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, deliveryStatus, progress, deliveredAt, scheduledDeliveryOn, truckingOrder
    }
    
    func toDomain() throws -> Trip {        
        return Trip(typename: typename,
                    id: id,
                    deliveryStatus: deliveryStatus,
                    progress: progress,
                    deliveredAt: deliveredAt.toDate(format: .withTime),
                    scheduledDeliveryOn: scheduledDeliveryOn.toDate(format: .withoutTime),
                    truckingOrder: try? truckingOrder.toDomain())
    }
}
