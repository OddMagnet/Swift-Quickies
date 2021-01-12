# Why...

## Stack?
To practice extending types and adding conformances through extensions.

## LinkedList?
To see how using the `indirect` keyword makes it possible to have a LinkedList as a Struct instead of a class, with an Enum for the nodes

## Queue and Deque?
To experiment with constrained extensions, @inlinable and prioritization

## OrderedSet
To see how an ordered set combined the best of both arrays (fast random access and retaining of their order) and sets (instant access to specific elements, no duplicates),
without the downsides of either of them (checking for specific items runs in linear time - O(n) - for arrays and sets loosing their order)
