public struct TruckingOrder {
    public let typename: String
    public let id: String
    public let tripDistanceMiles: Double
    public let orderType: String
    public let locationFrom: Location?
    public let locationTo: Location?
    
    public init(typename: String,
                id: String,
                tripDistanceMiles: Double,
                orderType: String,
                locationFrom: Location?,
                locationTo: Location?) {
        self.typename = typename
        self.id = id
        self.tripDistanceMiles = tripDistanceMiles
        self.orderType = orderType
        self.locationFrom = locationFrom
        self.locationTo = locationTo
    }
}
