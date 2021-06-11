# BackbaseTask

## Architecture:

I followed the View-Interactor-Presenter-Entity-Router (VIPER) design pattern and I used modern app development practices including xib and Auto Layout. 

Also I made unit testing for Cities Module.

Note: I used no third party libraries.


## How I solved the challenge:


### I used operation queues and operations to optimize the peformace and responsiveness of the app in:

1- Loading Json and decoding using Codable.

2- Building a tree, I used tree data structure to optimize the search operation sothat the time complexity for searching algorithms would be **log(n)** which is the 

height of the tree.

3- Searching to optimize the multi threading while searching.


### What happens after we opened the app:

Firstly we load the citis.json file and after everything is loaded correctly I pass the data to presenter to show the cities in tableview, at the same time I 

the operation queue is building the tree operation without blocking the ui and when it finishes **the search is ready**.

On the other hand if the user did type in search bar then we checked if the tree is ready if not then we wait for the tree to be finished and afterwards we will 

see the search take action and now the tableView is filtered by the search word the user types. ** Note that building tree happens only once after the app opened**


### Algorithm for searhing:

I tried to make searching's performance good as possible. First I build prfix tree with keyword for the city in a tree node which contains the cities for this word,

then I made searching which works with **DFS** take advantage of this and returning the cities for the node.


### Unit testing:

I made testing for Cities Module including the search algorithm.






