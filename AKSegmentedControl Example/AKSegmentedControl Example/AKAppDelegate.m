//
//  AKAppDelegate.m
//  AKSegmentedControl Example
//
//  Created by Ali Karagoz on 24/01/13.
//  Copyright (c) 2013 Ali Karagoz. All rights reserved.
//

#import "AKAppDelegate.h"

@implementation AKAppDelegate
{
    UIViewController *viewController;
    AKSegmentedControl *segmentedControl1, *segmentedControl2, *segmentedControl3;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Init the viewController containing the segmentedControls
    viewController = [[UIViewController alloc] init];
    
    // Segmented Control #1
    UILabel *segmentedControl1Label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 20.0, 300.0, 20.0)];
    [segmentedControl1Label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [segmentedControl1Label setText:@"Sticky Mode"];
    [segmentedControl1Label setTextAlignment:NSTextAlignmentCenter];
    [segmentedControl1Label setBackgroundColor:[UIColor clearColor]];
    [segmentedControl1Label setTextColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0]];
    [segmentedControl1Label setShadowColor:[UIColor whiteColor]];
    [segmentedControl1Label setShadowOffset:CGSizeMake(0.0, 1.0)];
    [segmentedControl1Label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    
    [viewController.view addSubview:segmentedControl1Label];
    segmentedControl1 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0, CGRectGetMaxY(segmentedControl1Label.frame) + 10.0, 300.0, 37.0)];
    [segmentedControl1 addTarget:self action:@selector(segmentedViewController:) forControlEvents:UIControlEventValueChanged];
    
    // Segmented Control #2
    UILabel *segmentedControl2Label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, CGRectGetMaxY(segmentedControl1.frame) + 20.0, 300.0, 20.0)];
    [segmentedControl2Label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [segmentedControl2Label setText:@"Button Mode"];
    [segmentedControl2Label setTextAlignment:NSTextAlignmentCenter];
    [segmentedControl2Label setBackgroundColor:[UIColor clearColor]];
    [segmentedControl2Label setTextColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0]];
    [segmentedControl2Label setShadowColor:[UIColor whiteColor]];
    [segmentedControl2Label setShadowOffset:CGSizeMake(0.0, 1.0)];
    [segmentedControl2Label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    
    [viewController.view addSubview:segmentedControl2Label];
    segmentedControl2 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0, CGRectGetMaxY(segmentedControl2Label.frame) + 10.0, 300.0, 37.0)];
    [segmentedControl2 addTarget:self action:@selector(segmentedViewController:) forControlEvents:UIControlEventValueChanged];
    
    // Segmented Control #3
    UILabel *segmentedControl3Label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, CGRectGetMaxY(segmentedControl2.frame) + 20.0, 300.0, 20.0)];
    [segmentedControl3Label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [segmentedControl3Label setText:@"Icon + Text + Multiple selection"];
    [segmentedControl3Label setTextAlignment:NSTextAlignmentCenter];
    [segmentedControl3Label setBackgroundColor:[UIColor clearColor]];
    [segmentedControl3Label setTextColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0]];
    [segmentedControl3Label setShadowColor:[UIColor whiteColor]];
    [segmentedControl3Label setShadowOffset:CGSizeMake(0.0, 1.0)];
    [segmentedControl3Label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    
    [viewController.view addSubview:segmentedControl3Label];
    segmentedControl3 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0, CGRectGetMaxY(segmentedControl3Label.frame) + 10.0, 300.0, 37.0)];
    [segmentedControl3 addTarget:self action:@selector(segmentedViewController:) forControlEvents:UIControlEventValueChanged];
    segmentedControl3.segmentedControlMode = AKSegmentedControlModeMultipleSelectionable;
    
    [self.window setRootViewController:viewController];
    self.window.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0];
    
    [self setupSegmentedControl1];
    [self setupSegmentedControl2];
    [self setupSegmentedControl3];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Segmented Control Examples

- (void)setupSegmentedControl1
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl1 setBackgroundImage:backgroundImage];
    [segmentedControl1 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl1 setSegmentedControlMode:AKSegmentedControlModeSticky];
    [segmentedControl1 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl1 setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"segmented-bg-pressed-right.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
    
    [buttonSocial setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
    
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
    [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [segmentedControl1 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
    [viewController.view addSubview:segmentedControl1];
}

- (void)setupSegmentedControl2
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl2 setBackgroundImage:backgroundImage];
    [segmentedControl2 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl2 setSegmentedControlMode:AKSegmentedControlModeButton];
    [segmentedControl2 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl2 setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"segmented-bg-pressed-right.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
    
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
    
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
    [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [segmentedControl2 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
    [viewController.view addSubview:segmentedControl2];
}


- (void)setupSegmentedControl3
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl3 setBackgroundImage:backgroundImage];
    [segmentedControl3 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl3 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl3 setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"segmented-bg-pressed-right.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    [buttonSocial setTitle:@"Social" forState:UIControlStateNormal];
    [buttonSocial setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSocial setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSocial.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
    [buttonStar setTitle:@"Favorite" forState:UIControlStateNormal];
    [buttonStar setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
    
    [buttonSettings setTitle:@"Settings" forState:UIControlStateNormal];
    [buttonSettings setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSettings setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSettings.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSettings.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSettings setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
    [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [segmentedControl3 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
    [viewController.view addSubview:segmentedControl3];
}


#pragma mark -
#pragma mark AKSegmentedControlDelegate

- (void)segmentedViewController:(AKSegmentedControl *)segmentedControl
{
    if (segmentedControl == segmentedControl1)
        NSLog(@"SegmentedControl #1 : Selected Index %@", segmentedControl.selectedIndeces);
    else if (segmentedControl == segmentedControl2)
        NSLog(@"SegmentedControl #2 : Selected Index %@", segmentedControl.selectedIndeces);
    else if (segmentedControl == segmentedControl3)
        NSLog(@"SegmentedControl #3 : Selected Index %@", segmentedControl.selectedIndeces);
}

@end
