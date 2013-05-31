//
//  CDStoreKitController.h
//  InAppPurchaseExample
//


#import <StoreKit/StoreKit.h>
#import <Foundation/Foundation.h>

@protocol CDStoreKitControllerDelegate <NSObject>

- (void)productUpdateRequestFinished;

@end

@interface CDStoreKitController : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{

}

@property SKProductsRequest *theProductRequest;
@property NSArray *products;
@property (weak) id <CDStoreKitControllerDelegate> delegate;

- (void) updateOurProductCatalog;

+ (CDStoreKitController *)sharedInstance;

- (void)purchaseThisProduct: (SKProduct *) theProductToPurchase;

@end
