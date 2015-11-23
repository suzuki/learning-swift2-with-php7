let GLOBAL_CONST = "global const"
var global = "global var"

public class ExampleClass {
    // Behavior is different from PHP
    private  var privateVar  = "private var"
    internal var internalVar = "internal var"
    public   var publicVar   = "public var"

    private  let privateConst  = "private const"
    internal let internalConst = "inetrnal const"
    public   let publicConst   = "public const"
}

private  class PrivateClass {}
internal class InternalClass {}
public   class PublicClass {}
