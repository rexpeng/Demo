//
//  ViewController.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "ViewController.h"
#import "MainTabViewController.h"
#import "AppDelegate.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController {
    NSArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    items = [NSArray arrayWithObjects: @"無好友與邀請好友", @"有好友無邀請資料", @"同時有好友與邀請", nil];
    
    [self initTableView];
}

-(void)initTableView {
    self.tableView = [UITableView new];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];

    [[[self.tableView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]] setActive:YES];
    [[[self.tableView topAnchor] constraintEqualToAnchor:[self.view topAnchor]] setActive:YES];
    [[[self.tableView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]] setActive:YES];
    [[[self.tableView bottomAnchor] constraintEqualToAnchor:[self.view bottomAnchor]] setActive:YES];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"defCell"];
    [self.tableView setTableFooterView:[UIView new]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"defCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ITEMTYPE itemType;
    switch(indexPath.row) {
        case 0:
            itemType = NOFRIEND;
            break;
        case 1:
            itemType = FRIENDLIST;
            break;
        case 2:
            itemType = FRIENDLISTWITHADD;
            break;
        default:
            itemType = NOFRIEND;
            break;
    }
    MainTabViewController *tabbar = [[MainTabViewController alloc] initWithType:itemType];
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    appDelegate.window.rootViewController = tabbar;
    [appDelegate.window makeKeyAndVisible];
}

@end
