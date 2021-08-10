//
//  FriendListView.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "FriendListView.h"


@interface FriendListView() <UITableViewDelegate, UITableViewDataSource, FriendViewCellDelegate, UITextFieldDelegate>

@end

@implementation FriendListView {
    UIRefreshControl *refreshControl;
}

-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"FriendListView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)initView {
    NSTextAttachment *icon = [NSTextAttachment new];
    
    UIFont *font = self.searchField.font;
    UIImage *image = [UIImage imageNamed:@"icSearchBarSearchGray"];
    [icon setBounds:CGRectMake(0, roundf(font.capHeight - image.size.height)/2.f, image.size.width, image.size.height)];
    [icon setImage:image];

    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:icon];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithAttributedString:imgStr];
    NSAttributedString *sStr = [[NSAttributedString alloc] initWithString:@"  想轉一筆給誰呢？"];
    [aStr appendAttributedString:sStr];
    self.searchField.attributedPlaceholder = aStr;
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendViewCell" bundle:nil] forCellReuseIdentifier:@"friendCell"];
    [self.tableView setTableFooterView:[UIView new]];
    
    [self setupRefreshController];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAddClick)];
    [self.searchAddBtn setUserInteractionEnabled:YES];
    [self.searchAddBtn addGestureRecognizer:tap];
    
    self.searchField.delegate = self;
}

-(void)setItems:(NSArray *)friendItems {
    self.friendItems = friendItems;
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"friendCell";
    
    FriendViewCell *cell = (FriendViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[FriendViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    FriendData *data = (FriendData *)[self.friendItems objectAtIndex:indexPath.row];
    [cell setView:data];
    
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)setupRefreshController
{
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor clearColor];
    [refreshControl addTarget:self action:@selector(retrieveFriendList) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

-(void)refreshStart {
    if(![refreshControl isRefreshing]) {
        [refreshControl beginRefreshing];
    }
}

-(void)refreshEnd {
    if([refreshControl isRefreshing]) {
        [refreshControl endRefreshing];
    }
}

-(void)retrieveFriendList {
    if(self.delegate != nil) {
        [self.delegate refreshFriendList];
    }
}

-(void)friendClick:(ActionType)actionType withData:(FriendData *)data {
    if(self.delegate != nil) {
        [self.delegate friendClick:actionType withData:data];
    }
}

-(void)searchAddClick {
    if(self.delegate != nil) {
        [self.delegate searchAddClick];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(self.delegate != nil) {
        [self.delegate searchShouldBeginEdit];
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(self.delegate != nil) {
        [self.delegate searchDidEndEdit];
    }
}


@end
