//
//  TJScaleTipper.m
//  Close-up
//
//  Created by Tim Johnsen on 8/8/24.
//

#import "TJScaleTipper.h"
#import <UIKit/UIKit.h>

const NSTimeInterval kTJEndOfElectionDayUnixTimestamp = 1730880000;
const NSTimeInterval kTJOneWeekBeforeElectionDayUnixTimestamp = 1730185200;
const NSTimeInterval kTJOneMonthBeforeElectionDayUnixTimestamp = 1728111600;

NSString *const kTJVoterRegistrationURLString = @"https://vote.gov";

__attribute__((objc_direct_members))
@implementation TJScaleTipper

+ (BOOL)isGoodCandidateToEncourageVoting
{
    // US-based.
    if (![[[NSLocale currentLocale] countryCode] isEqual:@"US"]) {
        return NO;
    }
    
    // After deadline (Nov 5, 2024)
    if ([[NSDate date] timeIntervalSince1970] > kTJEndOfElectionDayUnixTimestamp ) {
        return NO;
    }
    
    // Not if they have conservative-heavy apps installed
    // https://chatgpt.com/share/c975b304-b81c-4322-97f9-43d80c89b49f
    
    for (NSString *scheme in @[
        @"com.rumble.battles",
        @"dailywire",
        @"com.cappital.prageru",
        @"mindsapp",
        @"mewe",
        @"adbe.LI0uai0cRquGimk1SKNvDg",
        @"rsbn",
        @"myapp",
        @"second1st",
        @"conservativenews",
        @"talkradio",
        @"foxnews",
        @"breitbartapp",
    ]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", scheme]]]) {
            return NO;
        }
    }
    
    return YES;
}

@end
