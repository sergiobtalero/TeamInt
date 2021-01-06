import Domain

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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let deliveredAtDate = dateFormatter.date(from: deliveredAt)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let scheduledDeliveryOnDate = dateFormatter.date(from: scheduledDeliveryOn)
        
        return Trip(typename: typename,
                    id: id,
                    deliveryStatus: deliveryStatus,
                    progress: progress,
                    deliveredAt: deliveredAtDate,
                    scheduledDeliveryOn: scheduledDeliveryOnDate,
                    truckingOrder: try? truckingOrder.toDomain())
    }
}
