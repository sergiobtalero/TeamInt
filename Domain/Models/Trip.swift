public struct Trip {
    public let typename: String
    public let id: String
    public let deliveryStatus: String
    public let progress: String
    public let deliveredAt: String
    public let scheduledDeliveryOn: String
    public let truckingOrder: TruckingOrder?
    
    public init(typename: String,
                id: String,
                deliveryStatus: String,
                progress: String,
                deliveredAt: String,
                scheduledDeliveryOn: String,
                truckingOrder: TruckingOrder?) {
        self.typename = typename
        self.id = id
        self.deliveryStatus = deliveryStatus
        self.progress = progress
        self.deliveredAt = deliveredAt
        self.scheduledDeliveryOn = scheduledDeliveryOn
        self.truckingOrder = truckingOrder
    }
}
