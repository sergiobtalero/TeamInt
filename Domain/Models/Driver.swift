public struct Driver {
    public let typename: String
    public let loads: Loads?

    public init(typename: String,
                loads: Loads?) {
        self.typename = typename
        self.loads = loads
    }
}
