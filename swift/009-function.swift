func foo(str: String) -> Array<String> {
    var result:[String] = []
    for i in 0..<10 {
        result.append(str + String(i))
    }

    return result
}

let list = foo("x")

for l in list {
    print(l)
}
