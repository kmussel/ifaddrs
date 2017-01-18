import PackageDescription

let package = Package(
    name: "Ifaddrs",
    targets: [
        Target(name: "Ifaddrs"),
    ],
    dependencies: [
    	.Package(url: "https://github.com/kmussel/cifaddrs.git", "0.0.1"),
    ]    
)
