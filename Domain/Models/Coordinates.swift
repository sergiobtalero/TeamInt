public struct TripCoordinates {
    public let typename: String
    public let latitude: Double
    public let longitude: Double
    
    public init(typename: String,
                latitude: Double,
                longitude: Double) {
        self.typename = typename
        self.latitude = latitude
        self.longitude = longitude
    }
}
