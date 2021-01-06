public struct Location {
    public let typename: String
    public let id: String
    public let phone: String
    public let address: Address?
    public let name: String
    public let coordinates: TripCoordinates?
    
    public init(typename: String,
                id: String,
                phone: String,
                address: Address?,
                name: String,
                coordinates: TripCoordinates?) {
        self.typename = typename
        self.id = id
        self.phone = phone
        self.address = address
        self.name = name
        self.coordinates = coordinates
    }
}
