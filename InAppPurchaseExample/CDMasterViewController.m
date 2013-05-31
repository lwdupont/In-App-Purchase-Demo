//
//  CDMasterViewController.m
//  InAppPurchaseExample
//

#import "CDMasterViewController.h"

#import "CDDetailViewController.h"



@interface CDMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation CDMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *storeKitButton = [[UIBarButtonItem alloc] initWithTitle:@"Start Request" style:UIBarButtonItemStylePlain target:self action:@selector(startProductUpdateRequest)];
    
    self.navigationItem.leftBarButtonItem = storeKitButton;

    // UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    // self.navigationItem.rightBarButtonItem = addButton;
}


- (void) startProductUpdateRequest
{
    NSLog(@"Start the store kit product update request");
    
    [[CDStoreKitController sharedInstance] setDelegate:self];
    
    [[CDStoreKitController sharedInstance] updateOurProductCatalog];
    
}



- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SKProduct *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailProduct:object];
    }
}

#pragma mark - CDStoreKitController delegate messages

- (void)productUpdateRequestFinished
{
    NSLog(@"The product update request finished, the products are: %@", [[CDStoreKitController sharedInstance] products]);
    
    _objects = [NSMutableArray arrayWithArray:[[CDStoreKitController sharedInstance] products]];
    
    [self.tableView reloadData];
}

@end
