//
//  CDStoreKitController.m
//  InAppPurchaseExample
//



#import "CDStoreKitController.h"

@implementation CDStoreKitController

// Make this a singleton (only one for the entire app)
+ (CDStoreKitController *)sharedInstance
{
    static CDStoreKitController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CDStoreKitController alloc] init];
        
        // Do any other initialisation stuff here
        
        // add an observer to the payment queue, so that we can catch any payment
        // changes
        [[SKPaymentQueue defaultQueue] addTransactionObserver:sharedInstance];
    
    });
    return sharedInstance;
}

- (void) updateOurProductCatalog
{
    // create a product request to get information about the in app purchase products
    self.theProductRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:@"INAPPONE", @"INAPPPRODUCTTWOID",@"PURCHASETHREE", nil]];
    
    [self.theProductRequest setDelegate:self];    
    
    // and start the request, async
    [self.theProductRequest start];

}


- (void)purchaseThisProduct: (SKProduct *) theProductToPurchase
{
    
    // create the payment
    SKPayment *thePayment = [SKPayment paymentWithProduct:theProductToPurchase];
    
    // and add it to the purchase queue
    [[SKPaymentQueue defaultQueue] addPayment:thePayment];
    
    // and that's it - Apple starts the payment process, and our delegate gets notified as things happen.
    
}





#pragma mark - Product Request Delegate Methods

// when the app store request is finished, this method gets called
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    // check to see if we got any invalid products
    if ([response.invalidProductIdentifiers count] > 0)
    {
        NSLog(@"We got some invalid product identifers: %@", response.invalidProductIdentifiers);
    }
    
    if (response.products)
    {
        // this is our list of products from the app store, class SKProduct
        
        // let's save them off for displaying later
        self.products = response.products;
    }
    
    [self.delegate productUpdateRequestFinished];
    
}

#pragma mark - Payment Transaction Queue Observer Delgate Methods


// SKPaymentQueue calls this when a transaction has been updated. It's up to us
// to figure out what one and handle it appropriately. 
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *currentTransaction in transactions) {
        // loop through any transactions and see what their status is
        switch (currentTransaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Transaction: %@ state is purchasing", currentTransaction);
                break;
                
            case SKPaymentTransactionStatePurchased:
                NSLog(@"Transaction: %@ state is purchased", currentTransaction);
                // now that the transaction is purchased,
                
                // you need to provide the content or feature that the user just
                // payed for
                
                // and then we need to remove it from the purchase queue
                [[SKPaymentQueue defaultQueue] finishTransaction: currentTransaction];
                
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"Transaction: %@ state is failed", currentTransaction);
                break;
                
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction: %@ state is restored", currentTransaction);
                break;
                
            default:
                break;
        }
    }
}



@end
