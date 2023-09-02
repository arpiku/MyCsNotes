## Search in Roted SubArray
- Interesting approach but doens't work need to fix
- The idea 
	- Find k
	- Find the element in the aray.
```cpp
class Solution {
public:
    int binarySearch(vector<int>& nums, int target, bool pivoted) {
        int l = 0;
        int r = nums.size() -1;
        int mid = 0;
        while(r>=l) {
            if(nums[mid] == target) 
                return mid;
            else if  ((nums[mid] > target)^pivoted) {
                l = mid + 1;
            }
            else {
                r = mid - 1;
            }
            mid = l + (r-l)/2;

        }
        return  -1;
    }

    int getPivotPoint(vector<int>& nums, int l, int r) {
        if(r < l)
            return -1;
        int mid = l + (r-l)/2;
        if(mid == nums.size()-1 || nums[mid+1] < nums[mid]) {
            return mid;
        };
        if(nums[l] < nums[mid])
            return getPivotPoint(nums,mid,r);
        else
            return getPivotPoint(nums,l,mid);
    }



    int search(vector<int>& nums, int target) {
        const int n = nums.size()-1;
        bool pivoted = false;
        int k = -1;
        if(nums[0] >= nums[n])
            pivoted = true;
        if(!pivoted)
            return binarySearch(nums,target,false);
        k = getPivotPoint(nums,0,n);
        if(nums[k] == target)
            return k;
        if(k == n)
            return binarySearch(nums,target,pivoted);
        else if(nums[k] > target) {
            std::vector<int> temp = {nums.begin()+k+1,nums.end()};
            for(auto& i:temp)
                std::cout << i << " ";
            return k + 1 + binarySearch(temp,target,false);
        }
        std::vector<int> temp = {nums.begin(),nums.begin()+k+1};
            for(auto& i:temp)
                std::cout << i << " ";
        return binarySearch(temp,target,false);
        
        
    }
};
```
- If I had to do it quickly and cheekly
```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        auto iter = std::find(nums.begin(),nums.end(),target);
        auto idx = std::distance(nums.begin(),iter);
        if(idx == nums.size())
            return -1;
        return idx;        
    }
};
```


## Permutations
- [[backTracking]] [[array]]
```cpp
class Solution {
public:
    int binarySearch(vector<int>& nums, int target, bool pivoted) {
        int l = 0;
        int r = nums.size() -1;
        int mid = 0;
        while(r>=l) {
            if(nums[mid] == target) 
                return mid;
            else if  ((nums[mid] > target)^pivoted) {
                l = mid + 1;
            }
            else {
                r = mid - 1;
            }
            mid = l + (r-l)/2;

        }
        return  -1;
    }

    int getPivotPoint(vector<int>& nums, int l, int r) {
        if(r < l)
            return -1;
        int mid = l + (r-l)/2;
        if(mid == nums.size()-1 || nums[mid+1] < nums[mid]) {
            return mid;
        };
        if(nums[l] < nums[mid])
            return getPivotPoint(nums,mid,r);
        else
            return getPivotPoint(nums,l,mid);
    }



    int search(vector<int>& nums, int target) {
        const int n = nums.size()-1;
        bool pivoted = false;
        int k = -1;
        if(nums[0] >= nums[n])
            pivoted = true;
        if(!pivoted)
            return binarySearch(nums,target,false);
        k = getPivotPoint(nums,0,n);
        if(nums[k] == target)
            return k;
        if(k == n)
            return binarySearch(nums,target,pivoted);
        else if(nums[k] > target) {
            std::vector<int> temp = {nums.begin()+k+1,nums.end()};
            for(auto& i:temp)
                std::cout << i << " ";
            return k + 1 + binarySearch(temp,target,false);
        }
        std::vector<int> temp = {nums.begin(),nums.begin()+k+1};
            for(auto& i:temp)
                std::cout << i << " ";
        return binarySearch(temp,target,false);
        
        
    }
};
```