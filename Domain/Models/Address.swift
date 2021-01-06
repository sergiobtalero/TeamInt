public struct Address {
    public let typename: String
    public let street: String
    public let street2: String?
    public let city: String
    public let postalCode: String
    public let state: String
    public let country: String
    
    public init(typename: String,
                street: String,
                street2: String?,
                city: String,
                postalCode: String,
                state: String,
                country: String) {
        self.typename = typename
        self.street = street
        self.street2 = street2
        self.city = city
        self.postalCode = postalCode
        self.state = state
        self.country = country
    }
}
