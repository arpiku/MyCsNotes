The Problem Set is Week 1 from[ Grind 169]("https://www.techinterviewhandbook.org/grind75?hours=40&weeks=26")

## Two Sum
- [[array]]  [[hashMap]]
- The problem is rather simple when going with a naive solution, using a O(n^2) solution by lopping through all the possible combinations and returning the one that is meets our requirement.
- TO(n^2), SO(1)
```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        if(nums.empty()) 
            return {};
        for(int i = 0; i<nums.size(); i++) 
            for(int j = i+1; j<nums.size(); j++)
                if(nums[i]+nums[j]==target)
                    return {i,j};
        return {};
        
    }
};
```
- The solution is rather slow when n >> 1.
- We consider the fact that if the solution exist in the array, then the two numbers get related by being complement of each other, as only one unique solution leads to the correct sum.
- I.E if a + b = T, then a = T - b, and b = T - a.
- Now while iterating we can store the positions against these complements
- I.E fn(T-b) = pos(a), fn(T-a) = pos(b).
- We build this [[hashMap]] to store the relevant information and we build it while iterating through the array itself.
```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        if(nums.size() ==  0) 
            return {};
        std::unordered_map<int,int> m;
        for(int i = 0; i<nums.size(); i++) {
            if(m.find(target - nums[i]) != m.end())
                return {i, m[target-nums[i]]};
            m[nums[i]] = i;
        }

        return {};
    }
};
```
- Notice how the time and space complexity has changes, we iterate through the array at most in n steps, however it may require us to construct a map that can increase in size as much as the array. Hence
- TO(n), SO(n);

## Valid Parentheses
- [[string]] [[stack]]
- Let's first see an interesting solution to this problem that uses counting a single variable to find the solution.
- It doesn't work for all the cases, but does provide an insight into the idea of using a single variable to keep more information just than the count of something, but may relate to the structure and values provide powerful solutions.
- **The solution below is wrong**
```cpp
class Solution {
public:
    bool isValid(string s) {
        int balance = 0; // To keep track of parentheses balance

    for (char c : s) {
        if (c == '(') {
            balance++;
        } else if (c == ')') {
            balance--;
        } else if (c == '[') {
            balance++;
        } else if (c == ']') {
            balance--;
        } else if (c == '{') {
            balance++;
        } else if (c == '}') {
            balance--;
        }
    }

    return balance == 0;
        
    }
};
```
- It will face in case two different types of bracket close each other.
- TO(n), SO(1)
- Let's see a valid solution in python
```python
class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        memo = {'}':'{', ')':'(', ']':'['}
        for ch in s:
            if(len(stack) == 0 and ch in memo):
                return False
            if(len(stack) != 0 and ch in memo):
                if(stack.pop() != memo[ch]):
                    return False
            else:
                stack.append(ch)
        return len(stack) == 0
```


- TO(n), SO(n)
- We introduce the concept of stack, but why?
- In this problem we are concerned with how things are ordered, and we know if a bracket is opened than it must be closed too in order, which is what the stack helps us with.
- Cpp Solution
```cpp
class Solution {
public:
    char topAndPop(std::stack<char>& s) {
        const char ch = s.top();
        s.pop();
        return ch;
    }
    bool isValid(string s) {
        std::unordered_map<char,char> hmap = {{'(',')'},{'{','}'},{'[',']'}};
        std::stack<char> ch_stack;
        for(auto& ch:s) {
            if(hmap.find(ch) != hmap.end())
                ch_stack.push(hmap[ch]);
            else if(ch_stack.empty() || ch != topAndPop(ch_stack))
                return false;
        }
        return ch_stack.empty();
    }
};
```
- Notice how in cpp stack.pop() does not return a value, so we wrap that functionality using another function.
- TO(n), SO(n)


## Merge Two Lists
- [[recursion]] [[linkedList]]
- This problem requires merge two lists, think of a function that takes the top front nodes and compares them and then properly links them in order and them moves to next comparison step.
- The iterative solution will be:
```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        ListNode dummy(0);
        ListNode* curr = &dummy;
        while(l1 && l2) {
            if(l1->val > l2->val)  {
                curr->next = l2;
                l2 = l2->next;
            } else {
                curr->next = l1;
                l1 = l1->next;
            }
            curr = curr->next;
        }

        if(l1 != NULL) {
            curr->next = l1;
        } else {
            curr->next = l2;
        }

        return dummy.next;
        
    }
};
```
- TO(n), SO(1)
- Thing to notice are the two variables we created, the problem that they solve is interesting.
- When iterating through a linked list, if you have an iterator node, that gets modified continuously, we cannot return that, so we need to store the value of original head somewhere.
- But since the head of the returned list maybe from either of the LLs we cannot not know before hand which to choose.
- So we create a dummy variable that exists before either of the linked list and then return the next node of dummy which will be the sorted head of our answer.
- We use another variable curr to iterate and correctly join our lists.
- Things to notice:
	- See we only use a single if statement and do not do and explicit comparison on the else statement as '>' not being true implies '<=' being true for the variable, one can miss this and write code like this.
```cpp
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        if(!list1)
            return list2;
        if(!list2)
            return list1;
        ListNode dummy(0);
        ListNode* curr = &dummy;

        while(list1&&list2) {
            if(list1->val > list2->val) {
                curr->next = list2;
                list2 = list2->next;
            }
            if(list2->val > list1->val)  {
                curr->next = list1;
                list1 = list1->next;
            } curr = curr->next;
        }
        if(list1)
            curr->next = list1;
        if(list2)
            curr->next = list2;

        return dummy.next;
        
    }
};
```
- This code fails because both statements can fail and result in an access attempt on null pointer ('curr->next')

- **Is there a way to remove the dummy variable?**
- What about recursion, each recursive step is function waiting for the function within to pass it the results, the very structure of recursion can be used to replace the need of a dummy variable.
- Let's see.
```cpp

class Solution {
public:
    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        if(!list1)
            return list2;
        if(!list2)
            return list1;
        if(list1->val > list2->val) {
            list2->next = mergeTwoLists(list1,list2->next);
            return list2;
        }
        else  {
            list1->next = mergeTwoLists(list1->next,list2);
            return list1;
        }
    }
};
```
- TO(m+n) SO(m+n)




