- Always take care of indexing do not mess simple stuff up
```cpp
class Solution
{
public:
    vector<int> getTable(int N)
    {
        vector<int> ans(10,0);
        for(int i =1; i<=10; i++) 
            ans[i-1] = i*N;
        return ans;
            
    }
};
```

- Wow
```cpp
class Solution{
public:	
	vector<int> getMoreAndLess(int arr[], int n, int x) {
	    int lesser =0;
	    int greater=0;
	    for(int i = 0; i<n; i++) {
	        if(arr[i] >= x)
	            greater++;
	        if(arr[i] <= x)
	            lesser++;
	    }
	    return {lesser,greater};
	}
};
```

- Simple stuff
```cpp
void capitalize (string &s)
{
    bool cap = true;

    for(unsigned int i = 0; i <= s.length(); i++)
    {
        if (isalpha(s[i]) && cap == true)
        {
            s[i] = toupper(s[i]);
            cap = false;
        }
        else if (isspace(s[i]))
        {  
            cap = true;
        }
    }
```
- Focus on the problem statement
```cpp
class Solution{
public:
	
	bool fascinating(int n) {
	    if(n < 100)
	        return false;
	    std::string fas = std::to_string(n) + std::to_string(2*n)  + std::to_string(3*n);
	    std::unordered_map<char,int> m;
	    std::cout << fas;
	    for(auto& ch:fas) {
	        m[ch]++;
	        if(m[ch] > 1 || m[ch] == 0)
	            return false;
	    }
	    return true;
	}
};
```