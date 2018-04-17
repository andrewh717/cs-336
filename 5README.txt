CS 336 - Final Project Auction Bidding Site

Group #5
Andrew Hernandez, Daniel Chrostowski, Roslan Arslanouk

Project URL: http://ec2-34-201-110-238.compute-1.amazonaws.com:8080/buyMe

Amazon EC2 and Apache Tomcat credentials:

336ProjectKey.pem file:

-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArFWgdPtC9vt3mgFlGT4Ovmc+6KXbRXmF+CDMMQZZM4W1ArqyH5qpwehx2vtW
7oC4GV8RvSDcusVr8JeCvdk/Jj9egk+lj4i8zhbpuMROCZ1GhGJhfzwLKpk4SIz+a1y0/GpqG7vG
QkDwBavD48TyvVqEVwLgjKVARHUbYH/csPctDTcWuGH0gZSOXkGi+AjG9AR4BVhpe/mlTRYUwXfh
wkapgkk0cRsCSi9QwJ39dO0Oell3zrQ67VcBbvKCzmLxyyq/23Th0JgW/0i8zbK73MHNbukm/DgB
qM/J3Uz5o0JslT5E9QS2AV1TBKsOaQXoUK9Vy868SdaVBqf+EZUmqwIDAQABAoIBAHdsv01R8g4G
JdPrs4vSnZUFJ2tBxLpYhKZ21AoFRDuYJOBHULjmDU37Lyt5kbymJu4uG7Tc2Rn1Rd/snwXBTynK
MExNtYXKVEzdRApuv0WaYAvNwZLSoUpb880TKBxuml1xwSaG8dVn+u1zIsTs7uqZl6xUqhfNTMQk
A1zUPrPC83+5ByOwODaybazFM/tlvg9pkMkuTOasR1ntlyVr98GVTHtKhiHosvrqnHbB0yJpnrl4
i0igdEPOZP2Rzs8SK6YK0YfZDVyY4PInrjnbGKyl5DCxzkJxB4m02oVyam0RIS2ERdpJBT8TySR1
rJ/aEFoalgw8gBFWClsgD8tZnYECgYEA2bzH+2CWEr5gZIGpfB0Oh5tl6OLCRF+Is/v/57l66fgZ
tM+EvCjylY3aqWB+7ZYffAA/Au3sHXzKM+2TdL5CRkwCkGYMVtexqu50UpJ5+MVdyXA02pbuEuJa
jdPT6uGvpK2SU0aLkvut444A3umcX8Q/1ziS75t2YAxMPYW9SDkCgYEAyp5U0sJ+NSXa5bqTunII
lEZQLyi5du3aKJzFoaxLRHa5B4tcVteQbfpZTVCHQ51YL3pJsEK0j8ZN5Ez6g+Oov74pimYP0Cj6
/7t2e0SvHsT3bIgHDWAES8oKbXKDvuWsfpbgjNBYZqm7eW2P+svmQ04wXJSpiN8iIu8GsBzbvgMC
gYEAz3b2IcpFFHT7SajWQeE5z/I8pysxKY7RpZUun6/2supoLAUzF0n44pE4UP0V0/Gf7Dob0AG9
Yddenx32y1zhrzOLmeTySujYa+MrSOYye9wq4d4dLk5zZ+DvoYW9vWbvQfz0mI52PUW7yT+sCroS
+pj2r25DazT5FMmC93fwA9kCgYAipSwP1Z3K7KwfN+XmrXT2FYfEaIw937G73AKXAGTmUf6VYajq
WHWjuHjolWprj03y4FAVSXKiWuAat2bmgljqYFOuDIGLsFYqwB0kOrxO4JMGBcRe7xoM84EQ8dHB
JHh4NMg0i7Nx6nfZ7Xf/BDpdK9NtISZT9wNZQdG871JLjQKBgFkL/qfBunEGpQchjSfmeqFEgltt
2yr5hzM+t9OwW9DGdahCUQzXUuqHksyLdnhTHgvzhReNuMGXbswO1ZfGkUJH1gTdXNNap/iIa7vJ
hFwxn9qGNgag589Oa30RYKqO1nTf1NnVsInblg/zO+Y9/Gx/DFEfUO9GOcDbaLJXGWit
-----END RSA PRIVATE KEY-----

Apache Tomcat credentials:
user: admin
password: cs336

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