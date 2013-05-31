//
//  CDDetailViewController.h
//  InAppPurchaseExample
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface CDDetailViewController : UIViewController


@property (strong, nonatomic) SKProduct *detailProduct;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (IBAction)purchaseProduct:(id)sender;


@end
