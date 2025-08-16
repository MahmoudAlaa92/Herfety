//
//  images.stencil
//  Mega-Mall
//
//  Created by Mahmoud Alaa on 28/01/2025.
//

import UIKit

extension UIImage {
    static func named(_ name: String) -> UIImage {
        let img = UIImage(named: name)!
        img.accessibilityIdentifier = name
        return img
    }
}

// MARK: - Images
public enum Images {
    public static var sliderImage1: UIImage { .named("SliderImage1") }
    public static var chain: UIImage { .named("Chain") }
    public static var imageOfArt: UIImage { .named("ImageOfArt") }
    public static var jewelry: UIImage { .named("Jewelry") }
    
    public static var accentColor: UIImage { .named("AccentColor") }
    public static var art: UIImage { .named("Art") }
    public static var artLogo: UIImage { .named("ArtLogo") }
    public static var cartIcon: UIImage { .named("Cart Icon") }
    public static var cartSelected: UIImage { .named("Cart Selected") }
    public static var craft: UIImage { .named("Craft") }
    public static var fashion: UIImage { .named("Fashion") }
    public static var heartIcon: UIImage { .named("Heart Icon") }
    public static var homeIcon: UIImage { .named("Home Icon") }
    public static var homeSelected: UIImage { .named("Home Selected") }
    public static var homeDecore: UIImage { .named("HomeDecore") }
    public static var imageOfArt2: UIImage { .named("ImageOfArt2") }
    public static var jewelry2: UIImage { .named("Jewelry2") }
    public static var logo: UIImage { .named("Logo") }
    public static var offers: UIImage { .named("Offers") }
    public static var profileIcon: UIImage { .named("Profile Icon") }
    public static var profileSelected: UIImage { .named("Profile Selected") }
    public static var profilePhoto: UIImage { .named("ProfilePhoto") }
    public static var rectangleBeige: UIImage { .named("Rectangle Beige") }
    public static var rectangleBlack: UIImage { .named("Rectangle Black") }
    public static var search: UIImage { .named("Search") }
    public static var tradeLogo: UIImage { .named("TradeLogo") }
    public static var wishlistSelected: UIImage { .named("Wishlist Selected") }
    public static var alertAddToCart: UIImage { .named("alert-addToCart") }
    public static var alertError: UIImage { .named("alert-error") }
    public static var alertWarning: UIImage { .named("alert-warning") }
    public static var chevronForward: UIImage { .named("chevron.forward") }
    public static var creditAmeri: UIImage { .named("credit-ameri") }
    public static var creditCredit1: UIImage { .named("credit-credit1") }
    public static var creditCredit2: UIImage { .named("credit-credit2") }
    public static var creditCredit3: UIImage { .named("credit-credit3") }
    public static var creditCredit4: UIImage { .named("credit-credit4") }
    public static var creditMastercard: UIImage { .named("credit-mastercard") }
    public static var creditPaypal: UIImage { .named("credit-paypal") }
    public static var creditVisa: UIImage { .named("credit-visa") }
    public static var iconCommunity: UIImage { .named("icon-Community") }
    public static var iconFAQs: UIImage { .named("icon-FAQs") }
    public static var iconMyCard: UIImage { .named("icon-My Card") }
    public static var iconMyFavourites: UIImage { .named("icon-My Favourites") }
    public static var iconPersonalDetails: UIImage { .named("icon-Personal Details") }
    public static var iconPrivacyPolicy: UIImage { .named("icon-Privacy Policy") }
    public static var iconSettings: UIImage { .named("icon-Settings") }
    public static var iconShippingAddress: UIImage { .named("icon-Shipping Address") }
    public static var iconApple: UIImage { .named("icon-apple") }
    public static var iconArrow: UIImage { .named("icon-arrow") }
    public static var iconBack: UIImage { .named("icon-back") }
    public static var iconCart: UIImage { .named("icon-cart") }
    public static var iconDelete: UIImage { .named("icon-delete") }
    public static var iconEdit: UIImage { .named("icon-edit") }
    public static var iconFacebook: UIImage { .named("icon-facebook") }
    public static var iconGoogle: UIImage { .named("icon-google") }
    public static var iconLocation: UIImage { .named("icon-location") }
    public static var iconLove: UIImage { .named("icon-love") }
    public static var iconMenu: UIImage { .named("icon-menu") }
    public static var iconProductDelete: UIImage { .named("icon-product-delete") }
    public static var iconProfileArrow: UIImage { .named("icon-profile-arrow") }
    public static var iconRatingEmpty: UIImage { .named("icon-rating-empty") }
    public static var iconRating: UIImage { .named("icon-rating") }
    public static var iconScan: UIImage { .named("icon-scan") }
    public static var iconScaner: UIImage { .named("icon-scaner") }
    public static var iconSuccess: UIImage { .named("icon-success") }
    public static var loading: UIImage { .named("loading") }
    public static var logout: UIImage { .named("logout") }
    public static var notification: UIImage { .named("notification") }
    public static var redHeart: UIImage { .named("red Heart") }
}

//
//public enum Images {
//    public static var accentColor: UIImage {
//        UIImage(named: "AccentColor")!
//    }
//    public static var art: UIImage {
//        UIImage(named: "Art")!
//    }
//    public static var artLogo: UIImage {
//        UIImage(named: "ArtLogo")!
//    }
//    public static var cartIcon: UIImage {
//        UIImage(named: "Cart Icon")!
//    }
//    public static var cartSelected: UIImage {
//        UIImage(named: "Cart Selected")!
//    }
//    public static var chain: UIImage {
//        UIImage(named: "Chain")!
//    }
//    public static var craft: UIImage {
//        UIImage(named: "Craft")!
//    }
//    public static var fashion: UIImage {
//        UIImage(named: "Fashion")!
//    }
//    public static var heartIcon: UIImage {
//        UIImage(named: "Heart Icon")!
//    }
//    public static var homeIcon: UIImage {
//        UIImage(named: "Home Icon")!
//    }
//    public static var homeSelected: UIImage {
//        UIImage(named: "Home Selected")!
//    }
//    public static var homeDecore: UIImage {
//        UIImage(named: "HomeDecore")!
//    }
//    public static var imageOfArt: UIImage {
//        UIImage(named: "ImageOfArt")!
//    }
//    public static var imageOfArt2: UIImage {
//        UIImage(named: "ImageOfArt2")!
//    }
//    public static var jewelry: UIImage {
//        UIImage(named: "Jewelry")!
//    }
//    public static var jewelry2: UIImage {
//        UIImage(named: "Jewelry2")!
//    }
//    public static var logo: UIImage {
//        UIImage(named: "Logo")!
//    }
//    public static var offers: UIImage {
//        UIImage(named: "Offers")!
//    }
//    public static var profileIcon: UIImage {
//        UIImage(named: "Profile Icon")!
//    }
//    public static var profileSelected: UIImage {
//        UIImage(named: "Profile Selected")!
//    }
//    public static var profilePhoto: UIImage {
//        UIImage(named: "ProfilePhoto")!
//    }
//    public static var rectangleBeige: UIImage {
//        UIImage(named: "Rectangle Beige")!
//    }
//    public static var rectangleBlack: UIImage {
//        UIImage(named: "Rectangle Black")!
//    }
//    public static var search: UIImage {
//        UIImage(named: "Search")!
//    }
//    public static var sliderImage1: UIImage {
//        UIImage(named: "SliderImage1")!
//    }
//    public static var tradeLogo: UIImage {
//        UIImage(named: "TradeLogo")!
//    }
//    public static var wishlistSelected: UIImage {
//        UIImage(named: "Wishlist Selected")!
//    }
//    public static var alertAddToCart: UIImage {
//        UIImage(named: "alert-addToCart")!
//    }
//    public static var alertError: UIImage {
//        UIImage(named: "alert-error")!
//    }
//    public static var alertWarning: UIImage {
//        UIImage(named: "alert-warning")!
//    }
//    public static var chevronForward: UIImage {
//        UIImage(named: "chevron.forward")!
//    }
//    public static var creditAmeri: UIImage {
//        UIImage(named: "credit-ameri")!
//    }
//    public static var creditCredit1: UIImage {
//        UIImage(named: "credit-credit1")!
//    }
//    public static var creditCredit2: UIImage {
//        UIImage(named: "credit-credit2")!
//    }
//    public static var creditCredit3: UIImage {
//        UIImage(named: "credit-credit3")!
//    }
//    public static var creditCredit4: UIImage {
//        UIImage(named: "credit-credit4")!
//    }
//    public static var creditMastercard: UIImage {
//        UIImage(named: "credit-mastercard")!
//    }
//    public static var creditPaypal: UIImage {
//        UIImage(named: "credit-paypal")!
//    }
//    public static var creditVisa: UIImage {
//        UIImage(named: "credit-visa")!
//    }
//    public static var iconCommunity: UIImage {
//        UIImage(named: "icon-Community")!
//    }
//    public static var iconFAQs: UIImage {
//        UIImage(named: "icon-FAQs")!
//    }
//    public static var iconMyCard: UIImage {
//        UIImage(named: "icon-My Card")!
//    }
//    public static var iconMyFavourites: UIImage {
//        UIImage(named: "icon-My Favourites")!
//    }
//    public static var iconPersonalDetails: UIImage {
//        UIImage(named: "icon-Personal Details")!
//    }
//    public static var iconPrivacyPolicy: UIImage {
//        UIImage(named: "icon-Privacy Policy")!
//    }
//    public static var iconSettings: UIImage {
//        UIImage(named: "icon-Settings")!
//    }
//    public static var iconShippingAddress: UIImage {
//        UIImage(named: "icon-Shipping Address")!
//    }
//    public static var iconApple: UIImage {
//        UIImage(named: "icon-apple")!
//    }
//    public static var iconArrow: UIImage {
//        UIImage(named: "icon-arrow")!
//    }
//    public static var iconBack: UIImage {
//        UIImage(named: "icon-back")!
//    }
//    public static var iconCart: UIImage {
//        UIImage(named: "icon-cart")!
//    }
//    public static var iconDelete: UIImage {
//        UIImage(named: "icon-delete")!
//    }
//    public static var iconEdit: UIImage {
//        UIImage(named: "icon-edit")!
//    }
//    public static var iconFacebook: UIImage {
//        UIImage(named: "icon-facebook")!
//    }
//    public static var iconGoogle: UIImage {
//        UIImage(named: "icon-google")!
//    }
//    public static var iconLocation: UIImage {
//        UIImage(named: "icon-location")!
//    }
//    public static var iconLove: UIImage {
//        UIImage(named: "icon-love")!
//    }
//    public static var iconMenu: UIImage {
//        UIImage(named: "icon-menu")!
//    }
//    public static var iconProductDelete: UIImage {
//        UIImage(named: "icon-product-delete")!
//    }
//    public static var iconProfileArrow: UIImage {
//        UIImage(named: "icon-profile-arrow")!
//    }
//    public static var iconRatingEmpty: UIImage {
//        UIImage(named: "icon-rating-empty")!
//    }
//    public static var iconRating: UIImage {
//        UIImage(named: "icon-rating")!
//    }
//    public static var iconScan: UIImage {
//        UIImage(named: "icon-scan")!
//    }
//    public static var iconScaner: UIImage {
//        UIImage(named: "icon-scaner")!
//    }
//    public static var iconSuccess: UIImage {
//        UIImage(named: "icon-success")!
//    }
//    public static var loading: UIImage {
//        UIImage(named: "loading")!
//    }
//    public static var logout: UIImage {
//        UIImage(named: "logout")!
//    }
//    public static var notification: UIImage {
//        UIImage(named: "notification")!
//    }
//    public static var redHeart: UIImage {
//        UIImage(named: "red Heart")!
//    }
//}
