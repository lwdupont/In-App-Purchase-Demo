//
//  CDDetailViewController.m
//  InAppPurchaseExample
//

#import "CDDetailViewController.h"

#import "CDStoreKitController.h"

@interface CDDetailViewController ()
- (void)configureView;
@end

@implementation CDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailProduct:(SKProduct *)detailProduct 
{
    if (_detailProduct != detailProduct) {
        _detailProduct = detailProduct;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailProduct) {
        self.titleLabel.text = [self.detailProduct localizedTitle];
        self.detailDescriptionLabel.text = [self.detailProduct localizedDescription];
        
        self.priceLabel.text = [[self.detailProduct price] stringValue];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)purchaseProduct:(id)sender {
    
    [[CDStoreKitController sharedInstance] purchaseThisProduct:self.detailProduct];
}
@end
