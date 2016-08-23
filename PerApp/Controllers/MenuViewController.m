//
//  MenuViewController.m
//  PerApp
//
//  Created by Varun Kumar on 09/03/16.
//  Copyright © 2016 Varun. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "SideMenuCell.h"
#import "Utility.h"
#import "Constants.h"

static NSString *const jobsImg = @"icon_menu_jobs";
static NSString *const companiesImg = @"icon_menu_companies";
static NSString *const interviewImg = @"icon_menu_interview";
static NSString *const connectionImg = @"icon_menu_connection";
static NSString *const settingsImg = @"icon_menu_seetings";

static NSInteger const tableViewHeaderHeight = 160;


@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *imagesArray;
    NSArray *titleArray;
}

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *jobTitleLabel;
@property (nonatomic, strong) UILabel *companyNameLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Menu", @"Menu");
    [self commonSetup];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[[self mm_drawerController] centerViewController] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navC = (UINavigationController *)[[self mm_drawerController] centerViewController];
        NSLog(@"%@",[navC visibleViewController]);
        [[navC visibleViewController] viewWillAppear:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Private Methods

-(void)commonSetup{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.mm_drawerController setShouldStretchDrawer:NO];
    [[self navigationController] setNavigationBarHidden:YES];
    imagesArray = @[jobsImg,companiesImg,interviewImg,connectionImg,settingsImg,settingsImg];
    titleArray = @[NSLocalizedString(@"Applied Jobs", @"Applied Jobs"),NSLocalizedString(@"Companies", @"Companies"),NSLocalizedString(@"Interview", @"Interview"),NSLocalizedString(@"My Connections", @"My Connections"),NSLocalizedString(@"Settings", @"Settings"),NSLocalizedString(@"Logout", @"Logout")];
    
    
    
    // Register SideMenu Cell
    [_menuTableView registerNib:[UINib nibWithNibName:@"SideMenuCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([SideMenuCell class])];
}

-(void)configureTableHeaderView{
    
}

#pragma mark- UITableView Data Source Methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableViewHeaderHeight;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//   // return [self configureTableViewSectionHeaderView];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SideMenuCell class])];
    [cell.iconImageView setImage:[UIImage imageNamed:imagesArray[indexPath.row]]];
    [cell.titleLabel setText:titleArray[indexPath.row]];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    cell.layoutMargins = UIEdgeInsetsZero;
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
}

#pragma mark- UITableView Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    switch (indexPath.row) {
//        case 0:
//            
//            break;
//        case 1:
//            [self companyList];
//            break;
//        case 2:
//            break;
//        case 3:
//            break;
//        case 4:
//            [self settings];
//            break;
//        case 5:
//            [self logout];
//            break;
//        default:
//            break;
//    }
}

#pragma mark - Private Methods

-(UIView *)configureTableViewSectionHeaderView{
    
  //  UserModel *user = [UserModel sharedInstance];

    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), tableViewHeaderHeight)];
    //Configure header top view
    UIView *topHeaderView = [UIView new];
    [headerView addSubview:topHeaderView];
    [topHeaderView setFrame:CGRectMake(0, 0, 50, 64)];
    topHeaderView.backgroundColor = EPColor(231, 231, 231);
    [topHeaderView setTag:1000];
    
    
    // Configuring Mail notification view
    UIImageView *mailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_top_msg"]] ;
    [mailImageView  setFrame:CGRectMake(0, 25, 20, 15)];
    [topHeaderView addSubview:mailImageView];
    
    
    UIButton *notificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notificationBtn setFrame:CGRectMake(11,11, 20, 20)];
    [notificationBtn setBackgroundImage:[UIImage imageNamed:@"notifyIcon.png"] forState:UIControlStateNormal];
    [[notificationBtn titleLabel] setFont:[UIFont fontWithName:kLatoRegularFont size:14]];
    
    [topHeaderView addSubview:notificationBtn];
    [notificationBtn setHidden:NO];
    
//    [notificationBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[SharedManager sharedInstance].globalCounter] forState:UIControlStateNormal];
//    
//    if([SharedManager sharedInstance].globalCounter >0){
//        [notificationBtn setHidden:NO];
//        [notificationBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[SharedManager sharedInstance].globalCounter] forState:UIControlStateNormal];
//    }
    
    [notificationBtn setTag:500];
    
    
    //configuring seperator image view
    
    UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), tableViewHeaderHeight/(10-1.75))];
    [seperatorView setBackgroundColor:[UIColor grayColor]];
    [topHeaderView addSubview:seperatorView];
    
    // configuring friends notification view
    
    UIImageView *friendImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_top_connection"]] ;
    [friendImageView  setFrame:CGRectMake(0, 25, 20, 15)];
    [topHeaderView addSubview:friendImageView];
    
    
    UIButton *friendsNotificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendsNotificationBtn setFrame:CGRectMake(11,11, 20, 20)];
    [friendsNotificationBtn setBackgroundImage:[UIImage imageNamed:@"notifyIcon.png"] forState:UIControlStateNormal];
    [[friendsNotificationBtn titleLabel] setFont:[UIFont fontWithName:kLatoRegularFont size:14]];
    
    [topHeaderView addSubview:friendsNotificationBtn];
    [friendsNotificationBtn setHidden:NO];
//    [friendsNotificationBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[SharedManager sharedInstance].globalCounter] forState:UIControlStateNormal];
//    
//    if([SharedManager sharedInstance].globalCounter >0){
//        [friendsNotificationBtn setHidden:NO];
//        [friendsNotificationBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[SharedManager sharedInstance].globalCounter] forState:UIControlStateNormal];
//    }
    
    [notificationBtn setTag:500];
    
    
    //Configure header bottom view
    
    UIView *bottomHeaderView = [UIView new];
    [headerView addSubview:bottomHeaderView];
    bottomHeaderView.backgroundColor = EPColor(249, 249, 249);
    _profileImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//
//    __weak UIImageView *profileImageView = _profileImageView;
//    [_profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:user.photoUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0]
//                             placeholderImage:[UIImage imageNamed:@"profile_placeholder"]
//                                      success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
//                                          [profileImageView setImage:image];
//                                          
//                                      }
//                                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                          
//                                      }
//     ];
//    
//    [_profileImageView setContentMode:UIViewContentModeScaleAspectFill];
//    _profileImageView.clipsToBounds = YES;
//    
//    [bottomHeaderView addSubview:_profileImageView];
//    
//    
//    // Job Title Label
//    _jobTitleLabel = [UILabel new];
//    _jobTitleLabel.font = [UIFont fontWithName:kLatoRegularFont size:14];
//    _jobTitleLabel.textColor = EPColor(172, 172, 172);
//    _jobTitleLabel.text = @"";
//    [bottomHeaderView addSubview:_jobTitleLabel];
    
    
//    // Company name label
//    _companyNameLabel = [UILabel new];
//    _companyNameLabel.text = @"";
//    _companyNameLabel.font = [UIFont fontWithName:kLatoRegularFont size:14];
//    _companyNameLabel.textColor = EPColor(172, 172, 172);
//    [bottomHeaderView addSubview:_companyNameLabel];
//    
//    
//    if(user.jobs.count){
//        JobModel *jobModel = [user.jobs firstObject];
//        _jobTitleLabel.text = jobModel.jobTitle;
//        _companyNameLabel.text = jobModel.companyName;
//    }
    
//    // Name Label
//    NSString *userName = @"";
//    _nameLabel = [[UILabel alloc] init];
//    if(isNonEmptyString(user.firstName)){
//        userName = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
//    }
//    _nameLabel.text = [userName uppercaseString];
//    _nameLabel.font = [UIFont fontWithName:kLatoBoldFont size:14];
//    _nameLabel.textColor = [UIColor blackColor];
//    
//    [bottomHeaderView addSubview:_nameLabel];
    
    
    //Configure bottom header view transparent button
    
    UIButton *transparentBottomHeaderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomHeaderView addSubview:transparentBottomHeaderBtn];
    [transparentBottomHeaderBtn addTarget:self action:@selector(transparentProfileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //Adding Constraints
    PREPCONSTRAINTS(bottomHeaderView);
    PREPCONSTRAINTS(_profileImageView);
    PREPCONSTRAINTS(_jobTitleLabel);
    PREPCONSTRAINTS(_companyNameLabel);
    PREPCONSTRAINTS(_nameLabel);
    PREPCONSTRAINTS(topHeaderView);
    PREPCONSTRAINTS(seperatorView);
    PREPCONSTRAINTS(mailImageView);
    PREPCONSTRAINTS(friendImageView);
    PREPCONSTRAINTS(transparentBottomHeaderBtn);
    PREPCONSTRAINTS(notificationBtn);
    PREPCONSTRAINTS(friendsNotificationBtn);
    
    //Configuring top header view constraints
    ALIGN_VIEW_LEFT(headerView, topHeaderView);
    ALIGN_VIEW_RIGHT(headerView, topHeaderView);
    ALIGN_VIEW_TOP(headerView, topHeaderView);
    CONSTRAIN_HEIGHT(topHeaderView, 64);
    
    
//    //Configuring mailImageView constraints
//    ALIGN_VIEW_RIGHT_TO_VIEW_LEFT_CONSTANT(topHeaderView, mailImageView, seperatorView, -30);
//    ALIGN_VIEW_BOTTOM_CONSTANT(topHeaderView, mailImageView, -15);
//    
//    //Configuring notificationBtn constraints
//    ALIGN_VIEW_RIGHT_TO_VIEW_LEFT_CONSTANT(topHeaderView, notificationBtn, seperatorView, -20);
//    ALIGN_VIEW_BOTTOM_CONSTANT(topHeaderView, notificationBtn, -27);
//    
//    
//    //Configuring connection constraints
//    ALIGN_VIEW_LEFT_TO_VIEW_RIGHT_CONSTANT(topHeaderView, friendImageView, seperatorView, 30);
//    ALIGN_VIEW_BOTTOM_CONSTANT(topHeaderView, friendImageView, -15);
//    
//    //Configuring friendsNotificationBtn constraints
//    ALIGN_VIEW_LEFT_TO_VIEW_RIGHT_CONSTANT(topHeaderView, friendsNotificationBtn, seperatorView, 45);
//    ALIGN_VIEW_BOTTOM_CONSTANT(topHeaderView, friendsNotificationBtn, -27);
    
    
    
    //Configuring seperator image view constraints
    CENTER_VIEW_H(topHeaderView, seperatorView);
    CONSTRAIN_WIDTH(seperatorView, 1);
    ALIGN_VIEW_TOP_CONSTANT(topHeaderView, seperatorView, 24);
    ALIGN_VIEW_BOTTOM_CONSTANT(topHeaderView, seperatorView, -8);
    
    // Configure bottom Header View constraints
    ALIGN_VIEW_LEFT(headerView, bottomHeaderView);
    ALIGN_VIEW_RIGHT(headerView, bottomHeaderView);
    ALIGN_VIEW_BOTTOM(headerView, bottomHeaderView);
    ALIGN_VIEW_TOP_TO_VIEW_BOTTOM_CONSTANT(headerView, bottomHeaderView, topHeaderView, 0);
    
    
    //Bottom transparent button constraints
    ALIGN_VIEW_LEFT(headerView, transparentBottomHeaderBtn);
    ALIGN_VIEW_RIGHT(headerView, transparentBottomHeaderBtn);
    ALIGN_VIEW_BOTTOM(headerView, transparentBottomHeaderBtn);
    ALIGN_VIEW_TOP_TO_VIEW_BOTTOM_CONSTANT(headerView, transparentBottomHeaderBtn, topHeaderView, 0);
    
    
    //Profile ImageView constraints
    CONSTRAIN_SIZE(_profileImageView, 70, 70);
    CENTER_VIEW_V(bottomHeaderView, _profileImageView);
    ALIGN_VIEW_LEFT_CONSTANT(bottomHeaderView, _profileImageView, 10);
    
    //user name constraints
    ALIGN_VIEW_RIGHT_TO_VIEW_CONSTANT(bottomHeaderView, _nameLabel, _profileImageView, 10);
    ALIGN_VIEW_RIGHT_CONSTANT(bottomHeaderView, _nameLabel, -10);
//    ALIGN_VIEW_BOTTOM_TO_VIEW_TOP_CONSTANT(bottomHeaderView, _nameLabel, _jobTitleLabel, -5);
    
    //JobTitle constraints
    ALIGN_VIEW_RIGHT_TO_VIEW_CONSTANT(bottomHeaderView, _jobTitleLabel, _profileImageView, 10);
    CENTER_VIEW_V(bottomHeaderView, _jobTitleLabel);
    ALIGN_VIEW_RIGHT_CONSTANT(bottomHeaderView, _jobTitleLabel, -10);
    
    //Company name constraints
    ALIGN_VIEW_RIGHT_TO_VIEW_CONSTANT(bottomHeaderView, _companyNameLabel, _profileImageView, 10);
    ALIGN_VIEW_TOP_TO_VIEW_BOTTOM_CONSTANT(bottomHeaderView, _companyNameLabel, _jobTitleLabel, 5);
    ALIGN_VIEW_RIGHT_CONSTANT(bottomHeaderView, _companyNameLabel, -10);
    
    
    return headerView;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
