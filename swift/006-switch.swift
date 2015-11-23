var foo = 1
var bar = ""

switch foo {
    case 1:
        bar = "a"
        // no need "break"
    case 2:
        bar = "b"
    default:
        bar = "c"
}
