# Broadcast-Distributed-System
**Maelstrom** enabled distributed system for simulating network topologies, partitions, fault tolerance, replication, latencies over client and server nodes.


## Watch a Demo
[Demo](https://drive.google.com/file/d/1Q3Gedt20aR_huC5kicpyT4cZyLEQci2Q/view?usp=sharing)  

## Files
- **node.rb**: Standard functions for every node server, eg send a message
- **echo.rb**: Simple node to just echo commands to STDOUT
- **broadcast.rb**: Broadcast node to broadcast a message to all neighbors except sender, send acknoledgments for recieved messages, implement retry loops forunacknowledged messages, maintain neighbors list...
- **g_set.rb**: Using set based conflict free replication datatypes to send a payload across a network instead of sending individual units of a payload via gossip.
-**maelstrom**: Simulation suite provided to set up workers and drive functionality of servers written in above files.

## Technical Challenges Solved
- **Message Broadcast**:  allows one to share a message with all nodes in the cluster by gossiping to neighbors
- **Reliable Transmission**: Implements a message reply system that allows nodes to acknowledge messages recieved 
- **Fault Tolerance**: Allows all nodes to still recieve the broadcast even if several network partitions persist. By using Comflict Free Replication Datatypes CRDTS, in this case a set, we retransmit a set of all messages ensuring totoal payload capture on all nodes
- **Concurrency**: Allows messages sent between nodes to spawn threads allowing multiple messages to be sent concurrently. Uses locks to protect IO operations and for assigning messages.
## Maelstrom Features
- **Time Bouneded simulations**: Use --time-limit n to run simulations for a maximum of n seconds
- **Simulated Network Partitions**: Use --nemesis partition to add arbitrary network partitions to simulation
- **Network Topology**: Use  --topology tree4 to specify a network topology of a spanning tree with each node having at most 4 children. Other topologies include grid, tree2, tree3, star, line
- **Simulation speed**: Use --rate to specify how fast the messages should be sent.
- **Induced Latency**: use --latency induce delay between messages, simulating latency
- **Network Size**: Use --node-count to specify how manyn nodes are present in the network

## Sample usage
```
./maelstrom test -w broadcast --bin broadcast.rb --time-limit 20 --rate 100 --node-count 25 --topology line --latency 10
```
