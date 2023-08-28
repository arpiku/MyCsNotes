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

## Best Time to Buy and Sell Stocks
- Well only if I could figure that out!
- [[twoPointers]] [[array]] [[dynamicProgramming]]
- Let's see analyse the problem:
	- The order matters in this problem, we can use two variables one of which is always lower than the other one, making sure we can't sell even before buying.
	- We store the maxProfit in a variable, and update it if the profit for a particular pair of days is greater.
	- In case the profit for a pair of days is -ve, that implies there is price lower than current price using which more profit can be made potentially.
- The following approach uses two variables to find the max profit
```cpp
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        if(prices.empty())
            return 0;
        int maxProfit = 0;
        int currProfit = 0;
        int buyDay = 0;
        int sellDay = 1;
        while(sellDay < prices.size()) {
            currProfit = prices[sellDay] - prices[buyDay];
            if(currProfit > maxProfit) 
                maxProfit = currProfit;
            if(currProfit < 0) 
                buyDay = sellDay;
            sellDay++;
        }
        return maxProfit;
    }
};
```
- TO(n), SO(1)
- One can also solve this problem by finding the minimum price, and calculating the relative profit w.r.t minimum price and return the maximum, but we do not need to make sure that the order is maintained.
- The order thing can be taken care easily by the very nature of iteration itself.
```cpp
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        if(prices.empty())
            return true;
        int minPrice = prices[0];
        int maxProfit = 0;
        for(auto& price: prices) {
            minPrice = std::min(minPrice,price);
            int currProfit = price - minPrice;
            maxProfit = std::max(maxProfit, currProfit);
        }
        return maxProfit;
    }
};
```
- TO(n), SO(1)

## Invert a Binary Tree
- [[binaryTree]] [[recursion]] [[bfs]] [[dfs]] 
- Binary Trees in general lend themselves well to recursion, imagine
	- Being a node, if its null return
	- swap the children otherwise
	- call the function on it's children then just simply return the root that was given
```cpp
class Solution {
public:
    TreeNode* invertTree(TreeNode* root) {
        if(!root)
            return root;
        std::swap(root->left, root->right);
        invertTree(root->left);
        invertTree(root->right);
        return root;
    }
};
```
- TO(n), SO(h)->SO(logn) if tree balanced
- Notice the order, we go to left revert everything then we go to the right and revert everything.
- Since the reversal of both sides is independent these steps can be parallelised?
- This solution was an implementation of [[dfs]] algorithm
- We can also solve it using [[bfs]]
- Let's see that solution:
```cpp
class Solution {
public:
    TreeNode* invertTree(TreeNode* root) {
        if(!root) 
            return root;
        std::queue<TreeNode*> q;
        q.push(root);
        while(!q.empty()) {
            TreeNode* currNode = q.front();
            q.pop();
            if(currNode->left)
                q.push(currNode->left);
            if(currNode->right)
                q.push(currNode->right);
            std::swap(currNode->left, currNode->right);
        }
        return root; 
    }
};
```
- TO(n), SO(w) -> (O(logn),O(n))
- Interesting thing to notice is the **swap statement**, one can put it just below the pop() statement too.

## Valid Anagram
- [[hashMap]] [[sorting]] [[String]]
- We have two string is they are anagrams ,then their sorted version will be have to be equal (always?)
```cpp
class Solution {
public:
    bool isAnagram(string s, string t) {
        std::sort(s.begin(),s.end());
        std::sort(t.begin(),t.end());
        return s == t;
    }
};
```
- TO(nlong),SO(1)
- The above solution is rather straight forward and easy, but what if we are not allowed to reverse the lists?
```cpp
class Solution {
public:
    bool isAnagram(string s, string t) {
        unordered_map<char,int> ms;
        unordered_map<char,int> mt;
        for(auto& ch:s) {
            ms[ch]++;
        }
        for(auto& ch:t) {
            mt[ch]++;
        }
        for(auto& z:ms) {
            if(z.second != mt[z.first])
                return false;
        }
        return true;
    }
};
```
- TO(n), SO(n)

## Binary Search
- [[binarySearch]] [[searching]] [[array]]
- This solution requires a simple implementation of binary search.
```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int l = 0;
        int r = nums.size() -1;
        int mid = 0;
        while(r>=l) {
            mid = l + (r-l)/2;
            if(nums[mid] < target) {
                l = mid + 1;
            }
            else if (nums[mid] > target) {
                r = mid - 1;
            }
            else {
                return mid;
            }
        }
        return  -1;
    }
};
```
- TO(logn), SO(1)
- One important thing to notice is the positioning of 'if else statement', i.e the following code
```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int l = 0;
        int r = nums.size() -1;
        int mid = 0;
        while(r>=l) {
            mid = l + (r-l)/2;
            if(nums[mid] < target) {
                l = mid + 1;
            }
            if (nums[mid] > target) {
                r = mid - 1;
            }
            else {
                return mid;
            }
        }
        return  -1;
    }
};
```
- Will not work, as the target may not exist in the array.

## Flood Fill
- [[dfs]] [[bfs]] [[array]] [[matrix]]
- We can do a dfs, i.e we will go the first element, check whether it does or does not have the correct color, if it does then we simply return.
- If not we change it and call the function on all the neighbours that are valid.
```cpp
class Solution {
public:
    void _floodFill(vector<vector<int>>& image, int sr, int sc, int color, int org) {
        if(sr >=image.size() || sr < 0 || sc < 0 || sc >=image[0].size())
            return;

        if(image[sr][sc] == org) {
            image[sr][sc] = color;
        _floodFill(image,sr+1,sc,color,org);
        _floodFill(image,sr-1,sc,color,org);
        _floodFill(image,sr,sc+1,color,org);
        _floodFill(image,sr,sc-1,color,org);
        }
    }
vector<vector<int>> floodFill(vector<vector<int>>& image, int sr, int sc, int color)  { 
        if(image.empty())   
            return {};
        if(image[sr][sc] == color)
            return image;
        int org = image[sr][sc];
        _floodFill(image,sr,sc,color, org);
        return image;
    }
};
```
- The above code uses [[dfs]], imagine all the image points as a node connected four way with other ndoes.
- We can also use [[bfs]] to do the same.
```cpp
class Solution {
public:
    vector<vector<int>> floodFill(vector<vector<int>>& image, int sr, int sc, int color) {
        if(image.empty())
            return {};
        if(image[sr][sc] == color)
            return image;

        std::queue<std::pair<int,int>> q;
        const int dr[] = {-1,1,0,0};
        const int dc[] = {0,0,-1,1};
        const int R = image.size()-1;
        const int C = image[0].size()-1;
        const int org = image[sr][sc];

        q.push(std::make_pair(sr,sc));


        while(!q.empty()) {
            int r,c;
            std::tie(r,c) = q.front();
            q.pop();
            image[r][c] = color;
            for(int i = 0; i<4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                if(nc <= C && nc >= 0 && nr >= 0 && nr <=R && image[nr][nc] == org)
                    q.push(std::make_pair(nr,nc));
                
            }
        }

        return image;
        
    }
};
```


## Lowest Common Ancestor
- [[dfs]] [[bfs]] [[recursion]] [[binaryTree]]
- Again we have a binary search tree, it's very structure gives us a rather elegant solution.
```cpp
class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if(!root)
            return root;
        if(p->val > root->val && q->val > root->val)
            return lowestCommonAncestor(root->right, p,q);
        if(p->val < root->val && q->val < root->val) 
            return lowestCommonAncestor(root->left,p,q);
        return root;
    }
};
```
- Above is a **dfs**  approach, let's see how a **bfs** approach will look like.
```cpp
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */

class Solution {
public:
   TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
    if (!root) {
        return root;
    }

    // Create a queue for BFS
    std::queue<TreeNode*> bfsQueue;
    bfsQueue.push(root);

    while (!bfsQueue.empty()) {
        TreeNode* current = bfsQueue.front();
        bfsQueue.pop();
        std::cout << current->val << std::endl;

        if ((current->val >= p->val && current->val <= q->val) || (current->val <= p->val && current->val >= q->val)) {
            return current; // Found the LCA
        }

            if(current->right)
                bfsQueue.push(current->right);

            if (current->left) {
                bfsQueue.push(current->left);
        }
    }

    return NULL; // LCA not found
}
};
```
- The **IMPORTANT** thing is the equality check, see it's not just '<>' but '<>='. 
