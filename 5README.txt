CS 336 - Final Project Auction Bidding Site

Group #5
Andrew Hernandez, Daniel Chrostowski, Roslan Arslanouk

Project URL: http://ec2-34-201-110-238.compute-1.amazonaws.com:8080/buyMe

Credit Per User: All did equal amount of work for this project


***************************NOTES ABOUT THE PROJECT***************************
1) Auto bidding works only if one person has the auto bid on the product. If
two users place auto bidding on the same item, each one would increment once,
then the auto bidding would stop for both and neither of the users could place
a bid on that item anymore. 
2) We have created a wish list that each user could add items to and if an
auction for that item gets created, then the user recieves a notification.
3) Outbid notifications also work.
4) We have created an event that runs every minute to check if an item has
reached its end time, then if the current bid on it is higher then the reserve
bid that owner placed, the item gets sold. Otherwise, the item gets removed 
from the auction and the owner would have to start a new auction for it.