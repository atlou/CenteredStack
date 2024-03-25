# CenteredStack

![banner](https://github.com/atlou/CenteredStack/assets/30378214/87bded54-3772-4102-a353-6e9bd3655e9c)

SwiftUI does not allow for a child of an `HStack` or a `VStack` to be centered. This package aims to provide a solution to this problem.

## Get Started
1. Add the `CenteredStack` package to your Xcode project.
2. Import `CenteredStack` to your file.
```swift
import SwiftUI
import CenteredStack // Here

struct ContentView: View {
    ...
}
```
4. Use it like a regular `HStack` or `VStack`.
```swift
struct ContentView: View {
    var body: some View {
        CenteredVStack {
            // Add content here
        }
    }
}
```
5. Add the `centered()` modifier to the child you want to center.
```swift
struct ContentView: View {
    var body: some View {
        CenteredVStack {
            Text("Not centered")
            Text("Centered")
                .centered() // Here
        }
    }
}
```

## Use with Spacer
You cannot use a `Spacer` and the `.centered()` modifier in the same stack. 
If you need to use a `Spacer`, use a `ZStack`. 

Here is an example:

<img align="right" width="200" height="400" src="https://github.com/atlou/CenteredStack/assets/30378214/685b576f-2e81-4e4e-a99a-5ff14ee65825">


```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            HStack { // Separate HStack that contains the Spacer
                Button("Back") {}
                Spacer()
                Button("Add") {}
            }
            CenteredHStack {
                Image(systemName: "person.fill")
                Text("John Smith")
                    .centered()
            }
        }
        .padding(20)
        .background(.blue.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8))
    }
}
```
