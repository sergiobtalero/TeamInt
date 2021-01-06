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
        Trip(typename: typename,
             id: id,
             deliveryStatus: deliveryStatus,
             progress: progress,
             deliveredAt: deliveredAt,
             scheduledDeliveryOn: scheduledDeliveryOn,
             truckingOrder: try? truckingOrder.toDomain())
    }
}
