//
//  Student+CoreDataProperties.h
//  
//
//  Created by 李梦珂 on 2019/1/22.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nonatomic) float height;

@end

NS_ASSUME_NONNULL_END
