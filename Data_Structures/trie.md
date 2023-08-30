A Trie (pronounced "try") is a tree-like data structure used for efficient retrieval of a set of keys, usually strings. It is a fundamental data structure for tasks that involve searching for, inserting, and deleting words or strings, such as autocomplete and spell checking.

In a Trie:

- Each node of the Trie represents a single character.
- The root node is typically empty or represents an empty string.
-  Each edge of the Trie represents a character transition.
- Paths from the root node to leaf nodes represent valid words in the Trie.

Trie Operations:

- **Insertion**: To insert a string into a Trie, you start at the root and follow the path that corresponds to the characters of the string. If the path doesn't exist, you create new nodes along the way.
-  **Search**: To search for a string in a Trie, you start at the root and follow the path corresponding to the characters of the string. If you reach a leaf node, the string exists in the Trie.
-  **Deletion**: To delete a string from a Trie, you mark the leaf node of that string as non-existent. If it doesn't affect the representation of other words, you can also remove nodes that have no children.

### Following is an implementation of Trie in cpp
```cpp
#include <iostream>
#include <unordered_map>

class TrieNode {
public:
    std::unordered_map<char, TrieNode*> children;
    bool isEndOfWord;

    TrieNode() {
        isEndOfWord = false;
    }
};

class Trie {
private:
    TrieNode* root;

public:
    Trie() {
        root = new TrieNode();
    }

    // Insert a word into the Trie
    void insert(std::string word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
        }
        node->isEndOfWord = true;
    }

    // Search for a word in the Trie
    bool search(std::string word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c]) {
                return false;
            }
            node = node->children[c];
        }
        return node->isEndOfWord;
    }

    // Check if a word prefix exists in the Trie
    bool startsWith(std::string prefix) {
        TrieNode* node = root;
        for (char c : prefix) {
            if (!node->children[c]) {
                return false;
            }
            node = node->children[c];
        }
        return true;
    }
};

int main() {
    Trie trie;
    trie.insert("apple");
    std::cout << trie.search("apple") << std::endl;   // Output: true
    std::cout << trie.search("app") << std::endl;     // Output: false
    std::cout << trie.startsWith("app") << std::endl; // Output: true
    return 0;
}

```

### Longest Common Prefix using Trie
```cpp
#include <iostream>
#include <vector>
#include <string>

class TrieNode {
public:
    std::vector<TrieNode*> children;
    bool isEndOfWord;

    TrieNode() {
        children = std::vector<TrieNode*>(26, nullptr); // 26 possible characters (a-z)
        isEndOfWord = false;
    }
};

class Trie {
public:
    TrieNode* root;

    Trie() {
        root = new TrieNode();
    }

    // Insert a string into the Trie
    void insert(std::string word) {
        TrieNode* node = root;
        for (char c : word) {
            int index = c - 'a';
            if (!node->children[index]) {
                node->children[index] = new TrieNode();
            }
            node = node->children[index];
        }
        node->isEndOfWord = true;
    }

    // Find the longest common prefix in the Trie
    std::string findLongestCommonPrefix() {
        std::string commonPrefix = "";
        TrieNode* node = root;

        while (node && !node->isEndOfWord && countChildren(node) == 1) {
            for (int i = 0; i < 26; i++) {
                if (node->children[i]) {
                    commonPrefix += static_cast<char>('a' + i);
                    node = node->children[i];
                    break;
                }
            }
        }

        return commonPrefix;
    }

    // Count the number of non-null child nodes
    int countChildren(TrieNode* node) {
        int count = 0;
        for (TrieNode* child : node->children) {
            if (child) {
                count++;
            }
        }
        return count;
    }
};

std::string longestCommonPrefix(std::vector<std::string>& strs) {
    Trie trie;

    // Build the Trie from the given strings
    for (std::string word : strs) {
        trie.insert(word);
    }

    // Find the longest common prefix in the Trie
    return trie.findLongestCommonPrefix();
}

int main() {
    std::vector<std::string> strs = {"flower", "flour", "flourish"};
    std::string commonPrefix = longestCommonPrefix(strs);

    std::cout << "Longest Common Prefix: " << commonPrefix << std::endl; // Output: "flo"

    return 0;
}

```

