//
//  GithoodAppDelegate.m
//  Githood
//
//  Created by Jon on 1/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GithoodAppDelegate.h"

@implementation GithoodAppDelegate


@synthesize window;

@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	// Override point for customization after application launch.
	// Add the navigation controller's view to the window and display.
	[window addSubview:navigationController.view];
	[window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

	// Save data if appropriate.
}

- (void)dealloc {

	[window release];
	[navigationController release];
    [super dealloc];
}

@end
