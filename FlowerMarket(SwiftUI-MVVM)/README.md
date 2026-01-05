//
//  README.ME
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 05/01/2026.
//



FlowerMarket - SwiftUI MVVM

A modern, high-performance e-commerce iOS application built with SwiftUI and Combine. This project serves as a showcase for Clean Architecture (MVVM), modular UI design, and reactive programming.

📱 Features

* Dynamic Catalog: Browse a wide variety of products with optimized image loading.

* Category Filtering: Easily navigate products by type or occasion.

* Shopping Cart: Real-time price calculation and item management.

* Responsive Design: Fully adaptive UI that supports multiple screen sizes.

🛠 Tech Stack & Architecture
                                                                                                                                
This project focuses on scalability and testability:

* Language: Swift 5.10+

* Framework: SwiftUI

* Design Pattern: MVVM (Model-View-ViewModel)

* Reactive Programming: Combine for data binding and state management.

* Local/Remote Data: Structured for easy integration with REST APIs or Firebase.

🏗 Project Structure


FlowerMarket/
├── Models/          # Data structures and business logic
├── ViewModels/      # Logic for handling UI state and data transformation
├── Views/           # SwiftUI Components and Screen layouts
│   ├── Components/  # Reusable UI elements (Buttons, Cards)
│   └── Screens/     # Main feature screens (Home, Detail, Cart)
├── Resources/       # Assets and Constants
└── Services/        # (Optional) Networking and Data Persistence


🚀 Key Highlights
* Unidirectional Data Flow: Ensures the UI remains a function of the state.
* Protocol-Oriented: Extensive use of protocols to decouple layers and facilitate Unit Testing.
* Performance: Utilizes LazyVGrid and efficient state updates to maintain 60 FPS scrolling.


🏁 How to Run
* Clone the repository:

git clone https://github.com/Rehamsa3d/FlowerMarket-SwiftUI-MVVM-.git
                                                                                                                                
* Open FlowerMarket.xcodeproj in Xcode 15 or later.

* Select an iPhone simulator (iOS 17+) and press Cmd + R.
                                                                                                                                    
Contact:

  Reham Saad
  linkedin.com/in/reham-saad
  rehamsd2@gmail.com
                                                                                                                                    
