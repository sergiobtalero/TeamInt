public struct Loads {
    public let typename: String
    public let trips: [Trip]?

    public init(typename: String,
                trips: [Trip]?) {
        self.typename = typename
        self.trips = trips
    }
}
