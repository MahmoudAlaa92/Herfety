// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum Auth {
    /// Apply
    public static let apply = L10n.tr("Localizable", "auth.apply", fallback: "Apply")
    /// Confirm
    public static let confirm = L10n.tr("Localizable", "auth.confirm", fallback: "Confirm")
    /// Continue
    public static let `continue` = L10n.tr("Localizable", "auth.continue", fallback: "Continue")
    /// HerfetyAnimation
    public static let herfetyAnimation = L10n.tr("Localizable", "auth.HerfetyAnimation", fallback: "HerfetyAnimation")
    /// Localizable.strings (English)
    ///   Herfety
    /// 
    ///   Created by Mahmoud Alaa on 25/08/2025.
    public static let login = L10n.tr("Localizable", "auth.login", fallback: "Login")
    /// Reset
    public static let reset = L10n.tr("Localizable", "auth.reset", fallback: "Reset")
    /// Sign Up
    public static let signup = L10n.tr("Localizable", "auth.signup", fallback: "Sign Up")
    /// Welcome!
    public static let welcome = L10n.tr("Localizable", "auth.welcome", fallback: "Welcome!")
    /// Welcome Back!
    public static let welcomeBack = L10n.tr("Localizable", "auth.welcomeBack", fallback: "Welcome Back!")
    public enum ForgotPassword {
      /// Reset Password
      public static let resetButton = L10n.tr("Localizable", "auth.forgotPassword.resetButton", fallback: "Reset Password")
      /// Change Password
      public static let subtitle = L10n.tr("Localizable", "auth.forgotPassword.subtitle", fallback: "Change Password")
      /// Forget the password
      public static let title = L10n.tr("Localizable", "auth.forgotPassword.title", fallback: "Forget the password")
      public enum ConfirmPassword {
        /// *******
        public static let placeholder = L10n.tr("Localizable", "auth.forgotPassword.confirmPassword.placeholder", fallback: "*******")
        /// Confirm Password
        public static let title = L10n.tr("Localizable", "auth.forgotPassword.confirmPassword.title", fallback: "Confirm Password")
      }
      public enum CurrentPassword {
        /// *******
        public static let placeholder = L10n.tr("Localizable", "auth.forgotPassword.currentPassword.placeholder", fallback: "*******")
        /// Current Password
        public static let title = L10n.tr("Localizable", "auth.forgotPassword.currentPassword.title", fallback: "Current Password")
      }
      public enum Error {
        /// Please fill in all fields
        public static let emptyFields = L10n.tr("Localizable", "auth.forgotPassword.error.emptyFields", fallback: "Please fill in all fields")
        /// There exists invalid input
        public static let invalidInput = L10n.tr("Localizable", "auth.forgotPassword.error.invalidInput", fallback: "There exists invalid input")
      }
      public enum NewPassword {
        /// *******
        public static let placeholder = L10n.tr("Localizable", "auth.forgotPassword.newPassword.placeholder", fallback: "*******")
        /// New Password
        public static let title = L10n.tr("Localizable", "auth.forgotPassword.newPassword.title", fallback: "New Password")
      }
      public enum Username {
        /// Enter your name here
        public static let placeholder = L10n.tr("Localizable", "auth.forgotPassword.username.placeholder", fallback: "Enter your name here")
        /// User Name
        public static let title = L10n.tr("Localizable", "auth.forgotPassword.username.title", fallback: "User Name")
      }
    }
    public enum Login {
      /// Continue with Apple
      public static let apple = L10n.tr("Localizable", "auth.login.apple", fallback: "Continue with Apple")
      /// Continue with Facebook
      public static let facebook = L10n.tr("Localizable", "auth.login.facebook", fallback: "Continue with Facebook")
      /// Login Failed
      public static let failed = L10n.tr("Localizable", "auth.login.failed", fallback: "Login Failed")
      /// Continue with Google
      public static let google = L10n.tr("Localizable", "auth.login.google", fallback: "Continue with Google")
      /// please login or sign up to continue our app
      public static let subtitle = L10n.tr("Localizable", "auth.login.subtitle", fallback: "please login or sign up to continue our app")
      public enum Forgot {
        /// Forget the password
        public static let password = L10n.tr("Localizable", "auth.login.forgot.password", fallback: "Forget the password")
      }
      public enum Password {
        /// ***********
        public static let placeholder = L10n.tr("Localizable", "auth.login.password.placeholder", fallback: "***********")
        /// Password
        public static let title = L10n.tr("Localizable", "auth.login.password.title", fallback: "Password")
      }
      public enum Username {
        /// Enter your user name
        public static let placeholder = L10n.tr("Localizable", "auth.login.username.placeholder", fallback: "Enter your user name")
        /// User Name
        public static let title = L10n.tr("Localizable", "auth.login.username.title", fallback: "User Name")
      }
    }
    public enum Signup {
      /// Create an new account
      public static let subtitle = L10n.tr("Localizable", "auth.signup.subtitle", fallback: "Create an new account")
      /// Sign Up
      public static let title = L10n.tr("Localizable", "auth.signup.title", fallback: "Sign Up")
      public enum ConfirmPassword {
        /// *******
        public static let placeholder = L10n.tr("Localizable", "auth.signup.confirmPassword.placeholder", fallback: "*******")
        /// Confirm Password
        public static let title = L10n.tr("Localizable", "auth.signup.confirmPassword.title", fallback: "Confirm Password")
      }
      public enum Email {
        /// Enter your email here
        public static let placeholder = L10n.tr("Localizable", "auth.signup.email.placeholder", fallback: "Enter your email here")
        /// Email
        public static let title = L10n.tr("Localizable", "auth.signup.email.title", fallback: "Email")
      }
      public enum FirstName {
        /// Enter your First name
        public static let placeholder = L10n.tr("Localizable", "auth.signup.firstName.placeholder", fallback: "Enter your First name")
        /// First name
        public static let title = L10n.tr("Localizable", "auth.signup.firstName.title", fallback: "First name")
      }
      public enum LastName {
        /// Enter your last name
        public static let placeholder = L10n.tr("Localizable", "auth.signup.lastName.placeholder", fallback: "Enter your last name")
        /// Last name
        public static let title = L10n.tr("Localizable", "auth.signup.lastName.title", fallback: "Last name")
      }
      public enum Password {
        /// *******
        public static let placeholder = L10n.tr("Localizable", "auth.signup.password.placeholder", fallback: "*******")
        /// Password
        public static let title = L10n.tr("Localizable", "auth.signup.password.title", fallback: "Password")
      }
      public enum Phone {
        /// +(20) 112 201 201
        public static let placeholder = L10n.tr("Localizable", "auth.signup.phone.placeholder", fallback: "+(20) 112 201 201")
        /// Phone Number
        public static let title = L10n.tr("Localizable", "auth.signup.phone.title", fallback: "Phone Number")
      }
      public enum Username {
        /// Enter your name here
        public static let placeholder = L10n.tr("Localizable", "auth.signup.username.placeholder", fallback: "Enter your name here")
        /// User Name
        public static let title = L10n.tr("Localizable", "auth.signup.username.title", fallback: "User Name")
      }
    }
    public enum Success {
      /// You have successfully registered in
      /// our app and start working in it.
      public static let message = L10n.tr("Localizable", "auth.success.message", fallback: "You have successfully registered in\nour app and start working in it.")
      /// Start Shopping
      public static let startShopping = L10n.tr("Localizable", "auth.success.startShopping", fallback: "Start Shopping")
      /// Successful!
      public static let title = L10n.tr("Localizable", "auth.success.title", fallback: "Successful!")
    }
  }
  public enum Cart {
    /// Added To Order
    public static let addedToOrder = L10n.tr("Localizable", "cart.addedToOrder", fallback: "Added To Order")
    /// Added To Wishlist
    public static let addedToWishlist = L10n.tr("Localizable", "cart.addedToWishlist", fallback: "Added To Wishlist")
    /// Deleted From Order
    public static let deletedFromOrder = L10n.tr("Localizable", "cart.deletedFromOrder", fallback: "Deleted From Order")
    /// Deleted From Wishlist
    public static let deletedFromWishlist = L10n.tr("Localizable", "cart.deletedFromWishlist", fallback: "Deleted From Wishlist")
    /// Procced to Payment
    public static let proceedToPayment = L10n.tr("Localizable", "cart.proceedToPayment", fallback: "Procced to Payment")
    public enum Error {
      /// Order is empty, please add some products
      public static let emptyOrder = L10n.tr("Localizable", "cart.error.emptyOrder", fallback: "Order is empty, please add some products")
    }
  }
  public enum Categories {
    /// Browse by category
    public static let subtitle = L10n.tr("Localizable", "categories.subtitle", fallback: "Browse by category")
    /// Categories
    public static let title = L10n.tr("Localizable", "categories.title", fallback: "Categories")
  }
  public enum DailyEssentials {
    /// Essential
    public static let subtitle = L10n.tr("Localizable", "dailyEssentials.subtitle", fallback: "Essential")
    /// Daily
    public static let title = L10n.tr("Localizable", "dailyEssentials.title", fallback: "Daily")
  }
  public enum Error {
    /// Client ID not found
    public static let clientIdNotFound = L10n.tr("Localizable", "error.clientIdNotFound", fallback: "Client ID not found")
    /// Failed to retrieve Google ID token.
    public static let googleTokenFailed = L10n.tr("Localizable", "error.googleTokenFailed", fallback: "Failed to retrieve Google ID token.")
    /// Invalid email or password
    public static let invalidCredentials = L10n.tr("Localizable", "error.invalidCredentials", fallback: "Invalid email or password")
    /// Please enter both email and password
    public static let missingEmailPassword = L10n.tr("Localizable", "error.missingEmailPassword", fallback: "Please enter both email and password")
    /// No access token
    public static let noAccessToken = L10n.tr("Localizable", "error.noAccessToken", fallback: "No access token")
    /// Passwords do not match
    public static let passwordsMismatch = L10n.tr("Localizable", "error.passwordsMismatch", fallback: "Passwords do not match")
    /// Registration failed: Please check your input
    public static let registrationFailed = L10n.tr("Localizable", "error.registrationFailed", fallback: "Registration failed: Please check your input")
  }
  public enum Form {
    public enum Address {
      /// Enter your address
      public static let placeholder = L10n.tr("Localizable", "form.address.placeholder", fallback: "Enter your address")
    }
    public enum Comment {
      /// Enter your Comment
      public static let placeholder = L10n.tr("Localizable", "form.comment.placeholder", fallback: "Enter your Comment")
    }
    public enum Name {
      /// Enter your name
      public static let placeholder = L10n.tr("Localizable", "form.name.placeholder", fallback: "Enter your name")
    }
    public enum Phone {
      /// Enter your phone
      public static let placeholder = L10n.tr("Localizable", "form.phone.placeholder", fallback: "Enter your phone")
    }
    public enum Rating {
      /// Rating (1-5)
      public static let placeholder = L10n.tr("Localizable", "form.rating.placeholder", fallback: "Rating (1-5)")
    }
  }
  public enum General {
    /// Add
    public static let add = L10n.tr("Localizable", "general.add", fallback: "Add")
    /// Cancel
    public static let cancel = L10n.tr("Localizable", "general.cancel", fallback: "Cancel")
    /// Confirm
    public static let confirm = L10n.tr("Localizable", "general.confirm", fallback: "Confirm")
    /// Delete
    public static let delete = L10n.tr("Localizable", "general.delete", fallback: "Delete")
    /// Edit
    public static let edit = L10n.tr("Localizable", "general.edit", fallback: "Edit")
    /// Female
    public static let female = L10n.tr("Localizable", "general.female", fallback: "Female")
    /// Gender
    public static let gender = L10n.tr("Localizable", "general.gender", fallback: "Gender")
    /// Male
    public static let male = L10n.tr("Localizable", "general.male", fallback: "Male")
    /// OK
    public static let ok = L10n.tr("Localizable", "general.ok", fallback: "OK")
    /// Save
    public static let save = L10n.tr("Localizable", "general.save", fallback: "Save")
    /// Setting
    public static let setting = L10n.tr("Localizable", "general.setting", fallback: "Setting")
    /// Update
    public static let update = L10n.tr("Localizable", "general.update", fallback: "Update")
  }
  public enum Home {
    public enum BestDeal {
      /// Jewelry & Accessories
      public static let subtitle = L10n.tr("Localizable", "home.bestDeal.subtitle", fallback: "Jewelry & Accessories")
      /// the best deal on
      public static let title = L10n.tr("Localizable", "home.bestDeal.title", fallback: "the best deal on")
    }
    public enum Brands {
      /// Handmade
      public static let handmade = L10n.tr("Localizable", "home.brands.handmade", fallback: "Handmade")
      /// Leath
      public static let leath = L10n.tr("Localizable", "home.brands.leath", fallback: "Leath")
      /// Organ
      public static let organ = L10n.tr("Localizable", "home.brands.organ", fallback: "Organ")
      /// Rhine
      public static let rhine = L10n.tr("Localizable", "home.brands.rhine", fallback: "Rhine")
    }
    public enum DailyEssentials {
      /// Art & Collectibles
      public static let artCollectibles = L10n.tr("Localizable", "home.dailyEssentials.artCollectibles", fallback: "Art & Collectibles")
      /// Handmade Materials: crepe
      public static let handmadeMaterials = L10n.tr("Localizable", "home.dailyEssentials.handmadeMaterials", fallback: "Handmade Materials: crepe")
      /// Home Décor
      public static let homeDecor = L10n.tr("Localizable", "home.dailyEssentials.homeDecor", fallback: "Home Décor")
      /// Kids' Crafts & Toys
      public static let kidsCrafts = L10n.tr("Localizable", "home.dailyEssentials.kidsCrafts", fallback: "Kids' Crafts & Toys")
    }
    public enum Recommended {
      /// Recommended for you
      public static let title = L10n.tr("Localizable", "home.recommended.title", fallback: "Recommended for you")
    }
    public enum Slider {
      /// Discover Unique Handmade Treasures for Your Journey!
      public static let description = L10n.tr("Localizable", "home.slider.description", fallback: "Discover Unique Handmade Treasures for Your Journey!")
      /// Wear Art, Wear You
      public static let title1 = L10n.tr("Localizable", "home.slider.title1", fallback: "Wear Art, Wear You")
      /// Own Style, Own Story
      public static let title2 = L10n.tr("Localizable", "home.slider.title2", fallback: "Own Style, Own Story")
      /// Dress Bold, Live True
      public static let title3 = L10n.tr("Localizable", "home.slider.title3", fallback: "Dress Bold, Live True")
      /// Be Unique, Be You
      public static let title4 = L10n.tr("Localizable", "home.slider.title4", fallback: "Be Unique, Be You")
    }
  }
  public enum Info {
    public enum Error {
      /// Info is empty, please add at least one piece of information.
      public static let empty = L10n.tr("Localizable", "info.error.empty", fallback: "Info is empty, please add at least one piece of information.")
      /// One of the text fields is empty
      public static let textFieldEmpty = L10n.tr("Localizable", "info.error.textFieldEmpty", fallback: "One of the text fields is empty")
    }
  }
  public enum Nav {
    /// Add Address
    public static let addAddress = L10n.tr("Localizable", "nav.addAddress", fallback: "Add Address")
    /// Add Information
    public static let addInformation = L10n.tr("Localizable", "nav.addInformation", fallback: "Add Information")
    /// Add Review
    public static let addReview = L10n.tr("Localizable", "nav.addReview", fallback: "Add Review")
    /// Info
    public static let info = L10n.tr("Localizable", "nav.info", fallback: "Info")
    /// Payment
    public static let payment = L10n.tr("Localizable", "nav.payment", fallback: "Payment")
  }
  public enum Offers {
    /// UP to 10% OFF
    public static func upTo10(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo10", p1, fallback: "UP to 10% OFF")
    }
    /// UP to 20% OFF
    public static func upTo20(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo20", p1, fallback: "UP to 20% OFF")
    }
    /// UP to 30% OFF
    public static func upTo30(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo30", p1, fallback: "UP to 30% OFF")
    }
    /// UP to 40% OFF
    public static func upTo40(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo40", p1, fallback: "UP to 40% OFF")
    }
    /// UP to 50% OFF
    public static func upTo50(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo50", p1, fallback: "UP to 50% OFF")
    }
    /// UP to 60% OFF
    public static func upTo60(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo60", p1, fallback: "UP to 60% OFF")
    }
    /// UP to 70% OFF
    public static func upTo70(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo70", p1, fallback: "UP to 70% OFF")
    }
    /// UP to 80% OFF
    public static func upTo80(_ p1: Int) -> String {
      return L10n.tr("Localizable", "offers.upTo80", p1, fallback: "UP to 80% OFF")
    }
  }
  public enum Payment {
    /// Add New Card
    public static let addNewCard = L10n.tr("Localizable", "payment.addNewCard", fallback: "Add New Card")
    /// Payment Canceled
    public static let canceled = L10n.tr("Localizable", "payment.canceled", fallback: "Payment Canceled")
    /// Card Details
    public static let cardDetails = L10n.tr("Localizable", "payment.cardDetails", fallback: "Card Details")
    /// Card holder Name
    public static let cardHolderName = L10n.tr("Localizable", "payment.cardHolderName", fallback: "Card holder Name")
    /// Card Number
    public static let cardNumber = L10n.tr("Localizable", "payment.cardNumber", fallback: "Card Number")
    /// Checkout
    public static let checkout = L10n.tr("Localizable", "payment.checkout", fallback: "Checkout")
    /// Payment Completed
    public static let completed = L10n.tr("Localizable", "payment.completed", fallback: "Payment Completed")
    /// CVV
    public static let cvv = L10n.tr("Localizable", "payment.cvv", fallback: "CVV")
    /// Exp Date
    public static let expDate = L10n.tr("Localizable", "payment.expDate", fallback: "Exp Date")
    /// Failed to create payment element
    public static let failed = L10n.tr("Localizable", "payment.failed", fallback: "Failed to create payment element")
    /// Payment Failed: %@
    public static func failedWithError(_ p1: Any) -> String {
      return L10n.tr("Localizable", "payment.failedWithError", String(describing: p1), fallback: "Payment Failed: %@")
    }
    /// Payment Method
    public static let method = L10n.tr("Localizable", "payment.method", fallback: "Payment Method")
    /// Failed to place order: %@
    public static func orderFailed(_ p1: Any) -> String {
      return L10n.tr("Localizable", "payment.orderFailed", String(describing: p1), fallback: "Failed to place order: %@")
    }
    /// Proceed to payment
    public static let proceedToPayment = L10n.tr("Localizable", "payment.proceedToPayment", fallback: "Proceed to payment")
    /// Please select a payment method
    public static let select = L10n.tr("Localizable", "payment.select", fallback: "Please select a payment method")
    /// Payment
    public static let title = L10n.tr("Localizable", "payment.title", fallback: "Payment")
  }
  public enum Product {
    public enum Details {
      /// Available in stock
      public static let available = L10n.tr("Localizable", "product.details.available", fallback: "Available in stock")
      /// Description
      public static let description = L10n.tr("Localizable", "product.details.description", fallback: "Description")
      /// %@/%@
      public static func indexFormat(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "product.details.indexFormat", String(describing: p1), String(describing: p2), fallback: "%@/%@")
      }
      /// Not Available
      public static let notAvailable = L10n.tr("Localizable", "product.details.notAvailable", fallback: "Not Available")
      /// $%@
      public static func priceFormat(_ p1: Any) -> String {
        return L10n.tr("Localizable", "product.details.priceFormat", String(describing: p1), fallback: "$%@")
      }
    }
  }
  public enum Products {
    /// $%@
    public static func currency(_ p1: Any) -> String {
      return L10n.tr("Localizable", "products.currency", String(describing: p1), fallback: "$%@")
    }
    /// %@%%
    /// OFF
    public static func discountFormat(_ p1: Any) -> String {
      return L10n.tr("Localizable", "products.discountFormat", String(describing: p1), fallback: "%@%%\nOFF")
    }
    /// Save $%@
    public static func saveFormat(_ p1: Any) -> String {
      return L10n.tr("Localizable", "products.saveFormat", String(describing: p1), fallback: "Save $%@")
    }
  }
  public enum Profile {
    /// FAQs
    public static let faqs = L10n.tr("Localizable", "profile.faqs", fallback: "FAQs")
    /// Logout
    public static let logout = L10n.tr("Localizable", "profile.logout", fallback: "Logout")
    /// My Card
    public static let myCard = L10n.tr("Localizable", "profile.myCard", fallback: "My Card")
    /// My Favourites
    public static let myFavourites = L10n.tr("Localizable", "profile.myFavourites", fallback: "My Favourites")
    /// My Order
    public static let myOrder = L10n.tr("Localizable", "profile.myOrder", fallback: "My Order")
    /// Privacy Policy
    public static let privacyPolicy = L10n.tr("Localizable", "profile.privacyPolicy", fallback: "Privacy Policy")
    /// Setting
    public static let setting = L10n.tr("Localizable", "profile.setting", fallback: "Setting")
    /// Shipping Address
    public static let shippingAddress = L10n.tr("Localizable", "profile.shippingAddress", fallback: "Shipping Address")
  }
  public enum Reviews {
    /// Add To Cart
    public static let addToCart = L10n.tr("Localizable", "reviews.addToCart", fallback: "Add To Cart")
    /// Reviews Client
    public static let clientTitle = L10n.tr("Localizable", "reviews.clientTitle", fallback: "Reviews Client")
    /// Show All Reviews
    public static let showAll = L10n.tr("Localizable", "reviews.showAll", fallback: "Show All Reviews")
    /// Reviews
    public static let title = L10n.tr("Localizable", "reviews.title", fallback: "Reviews")
    public enum Edit {
      /// Update your comment below.
      public static let message = L10n.tr("Localizable", "reviews.edit.message", fallback: "Update your comment below.")
      /// Edit Review
      public static let title = L10n.tr("Localizable", "reviews.edit.title", fallback: "Edit Review")
    }
    public enum Error {
      /// Failed to add review. Please try again.
      public static let failed = L10n.tr("Localizable", "reviews.error.failed", fallback: "Failed to add review. Please try again.")
      /// Invalid Input
      public static let invalidInput = L10n.tr("Localizable", "reviews.error.invalidInput", fallback: "Invalid Input")
      /// Please enter:
      public static let pleaseEnter = L10n.tr("Localizable", "reviews.error.pleaseEnter", fallback: "Please enter:")
      /// Rating between 1-5
      public static let ratingRange = L10n.tr("Localizable", "reviews.error.ratingRange", fallback: "Rating between 1-5")
      /// Review text
      public static let reviewText = L10n.tr("Localizable", "reviews.error.reviewText", fallback: "Review text")
    }
    public enum Success {
      /// Your review has been added
      public static let added = L10n.tr("Localizable", "reviews.success.added", fallback: "Your review has been added")
    }
  }
  public enum Settings {
    /// Age
    public static let age = L10n.tr("Localizable", "settings.age", fallback: "Age")
    /// Email
    public static let email = L10n.tr("Localizable", "settings.email", fallback: "Email")
    /// Help Center
    public static let helpCenter = L10n.tr("Localizable", "settings.helpCenter", fallback: "Help Center")
    /// Language
    public static let language = L10n.tr("Localizable", "settings.language", fallback: "Language")
    /// Name
    public static let name = L10n.tr("Localizable", "settings.name", fallback: "Name")
    /// Notification
    public static let notification = L10n.tr("Localizable", "settings.notification", fallback: "Notification")
    /// Upload Image
    public static let uploadImage = L10n.tr("Localizable", "settings.uploadImage", fallback: "Upload Image")
  }
  public enum TopBrands {
    /// Brands
    public static let subtitle = L10n.tr("Localizable", "topBrands.subtitle", fallback: "Brands")
    /// Top
    public static let title = L10n.tr("Localizable", "topBrands.title", fallback: "Top")
  }
  public enum Wishlist {
    /// Added to Wishlist
    public static let added = L10n.tr("Localizable", "wishlist.added", fallback: "Added to Wishlist")
    /// Your wishlist is empty
    public static let empty = L10n.tr("Localizable", "wishlist.empty", fallback: "Your wishlist is empty")
    /// Removed from Wishlist
    public static let removed = L10n.tr("Localizable", "wishlist.removed", fallback: "Removed from Wishlist")
    /// Wishlist
    public static let title = L10n.tr("Localizable", "wishlist.title", fallback: "Wishlist")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
