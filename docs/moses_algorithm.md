# This is description of how Moses Algorithm works

Moses Algorithm use DistanceSampler and DefaultRecognizer. Patterns for Moses Algorithm can be found in MosesPatterns.as.

Moses pattern is represented by PointsPattern and it is simple series of points exacly as if they were sampled. Example:
If we need a pattern that represents line drawed from left to right it could be represented by series of points:
	
    (0, 0), (10, 0), (20, 0), (30, 0), (40, 0), (50, 0)
	
Scale has no matter for moses so the same pattern could be represented also as:

    (0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0)

Pattern recognition algorithm is placed in DefaultMosesAlgorithm. There are also some variations: ShiftPoints and Reversed algorithm.

## DefaultMosesAlgorithm

input data: pattern points (PP), sampling points (SP)

algorithm:
	
1. Perform a "moses fit" that will reduce PP (if its longer than SP) or SP (otherwise) - see mosesFit method in DefaultMosesAlgorithm.as
2. Change representation of SP and PP to simplified directions (there are 8 directions: "up, "right-up", "right", "right-down", "down", "left-down", "left", "left-up"). There must be at least 2 points in SP and PP to perform this action
3. Calculate how much simplified list of directions of SP and PP are similar - give 1 point if directions on same index are the same and give 0.5 points if they are differ by one step (example: up and left-up, down and right-down, and so on). Matching value is calculated by dividing points to length od reduced SP/PP (they have same lenght). The best matching value is 1.0, the lower value is 0.0
	
### Example:

Pattern 1: (0,0), (1,0), (2,0) - horizontal line
Pattern 2: (0,0), (1, 1), (2,2), (3,3), (4,4), (5,5) - diagonal line
Sample data from user: (50, 50), (75, 50), (100, 50), (150, 100)

Pattern 1:
	
1. Moses fit will reduce sampled data (because is longer):
	
    Pattern 1: (0,0), (1,0), (2,0)
    Reduces sampled data: (50, 50), (75, 50), (150, 100) (first and last element always remain unchanged)
	
2. Change representation to simplified directions:

    Pattern 1: right, right
    Sampled data: right, right-down
	
3. Caclulate matching value:

    right - right (1 point)
    right - right-down (0.5 points)
    1.5 points / 2 = 0.75 (matching value)
	
Pattern 2:
	
1. Moses fit will reduce pattern data:
	
    Reduced pattern 2: (0,0), (2,2), (3,3), (5,5)
    Sampled data: (50, 50), (75, 50), (100, 50), (150, 100)
	
2. Simplified directions:
	
    Pattern 2: right, right, right
    Sampled data: right, right, right-down

3. Calculate matching value:
	
    right - right (1 point)
    right - right (1 point)
    right - right-down( 0.5 points)
    2.5 / 3 = 0.83 (matching value)
	
Better matching value has pattern 2 and this pattern will be treated as best matching.
