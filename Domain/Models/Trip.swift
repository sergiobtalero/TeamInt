public struct Trip {
    public let typename: String
    public let id: String
    public let deliveryStatus: String
    public let progress: String
    public let deliveredAt: Date?
    public let scheduledDeliveryOn: Date?
    public let truckingOrder: TruckingOrder?
    
    public init(typename: String,
                id: String,
                deliveryStatus: String,
                progress: String,
                deliveredAt: Date?,
                scheduledDeliveryOn: Date?,
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
