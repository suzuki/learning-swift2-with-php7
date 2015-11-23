protocol ExampleProtocol {
    func foo() -> String
}

class Base {
    internal let bar = "bar"
}

class Example: Base, ExampleProtocol {
    override init() {
        print("initialize")
    }

    func foo() -> String {
        return self.bar
    }
}

let example = Example() // no need 'new'
print(example.foo())
