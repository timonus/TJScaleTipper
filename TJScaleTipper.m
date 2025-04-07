//
//  TJScaleTipper.m
//  Close-up
//
//  Created by Tim Johnsen on 8/8/24.
//

#import "TJScaleTipper.h"
#import <UIKit/UIKit.h>

NSString *const kTJVoterRegistrationURLString = @"https://vote.gov";

@interface TJScaleTipper ()

@property (nonatomic, readwrite) NSDate *endOfElectionDay;
@property (nonatomic, readwrite) NSDate *oneWeekBeforeElectionDay;
@property (nonatomic, readwrite) NSDate *oneMonthBeforeElectionDay;
@property (nonatomic, readwrite) NSDate *threeMonthsBeforeElectionDay;

@end

__attribute__((objc_direct_members))
@implementation TJScaleTipper {
    NSInteger _closestElectionYear;
}

+ (instancetype)shared
{
    static TJScaleTipper *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [TJScaleTipper new];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationSignificantTimeChangeNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification * _Nonnull notification) {
            [shared _tryUpdateDates];
        }];
        [shared _tryUpdateDates];
    });
    return shared;
}

static NSInteger _computeClosestElectionYear(void) {
    NSDate *const date = [NSDate date];
    const NSInteger year = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:date];
    
    const NSInteger lastElectionYear = (year / 4) * 4;
    
    if (year - lastElectionYear < 2) {
        return lastElectionYear;
    }
    return ceil(year / 4.0) * 4; // Next election year
}

static NSDate *_computeElectionDayInYear(const NSInteger year) {
    NSDateComponents *components = [NSDateComponents new];
    components.year = year;
    components.month = 11;
    components.weekday = 3;
    components.weekdayOrdinal = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

static NSDate *_floorDate(NSDate *const date)
{
    // Floor the input date to the very beginning of the specified day.
    NSCalendar *const calendar = [NSCalendar currentCalendar];
    NSDateComponents *const dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:date];
    return [calendar dateFromComponents:dateComponents];
}

static NSDate *_ceilDate(NSDate *const date)
{
    return _floorDate([NSDate dateWithTimeIntervalSinceNow:86400]);
}

- (void)_tryUpdateDates
{
    const NSInteger closestElectionYear = _computeClosestElectionYear();
    
    if (closestElectionYear != _closestElectionYear) {
        _closestElectionYear = closestElectionYear;
        
        NSDate *const electionDay = _computeElectionDayInYear(closestElectionYear);
        self.endOfElectionDay = _ceilDate(electionDay);
        self.oneWeekBeforeElectionDay = _floorDate([electionDay dateByAddingTimeInterval:-604800]);
        self.oneMonthBeforeElectionDay = _floorDate([electionDay dateByAddingTimeInterval:-2592000]);
        self.threeMonthsBeforeElectionDay = _floorDate([electionDay dateByAddingTimeInterval:-7776000]);
    }
}

- (BOOL)isGoodCandidateToEncourageVoting
{
    // US-based.
    if (![[[NSLocale currentLocale] countryCode] isEqual:@"US"]) {
        return NO;
    }
    
    // After deadline
    if ([[NSDate date] compare:self.endOfElectionDay] == NSOrderedDescending) { // todo: double check this
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
