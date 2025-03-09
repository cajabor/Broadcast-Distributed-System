# Broadcast-Distributed-System
**Maelstrom** enabled distributed system for simulating network topologies, partitions, fault tolerance, replication, latencies over client and server nodes.
Maelstrom is a workbench for writing toy implementations of distributed systems. It uses the Jepsen testing library to test toy implementations of distributed systems and lets you learn by writing implementations of distributed systems and test them via its testsuites See [an overview of the Maelstrom workbench](https://github.com/jepsen-io/maelstrom/blob/main/README.md). See [installation instructions](https://github.com/jepsen-io/maelstrom/blob/main/doc/01-getting-ready/index.md) for Maelstrom.

## Motivation, Problem, and Impact
To understand the importance of simulated distributed systems, we can consider why distributed systems are important, especialy for scaling services to millions of users. Distributed systems are essential for scaling because they enable the division of tasks across multiple machines, improving performance and efficiency. They provide fault tolerance by replicating data and processes, ensuring high availability even when some components fail (and components will fail :]). Additionally, distributed systems allow for horizontal scaling, where new nodes can be added to accommodate increased workloads. Users can more easily access a system's a system's components if the component i scloser to them, hence highlighting the need to spread out (or distribute) the system. This architecture enhances responsiveness and reliability, making it ideal for large-scale applications and services! 

A distributed system simulation environment enables testing and analysis of complex, multi-node architectures without deploying actual hardware. It helps identify performance bottlenecks, test fault tolerance, and validate consistency protocols in a controlled setting. Simulation environments like Maelstrom give users easy customizable controls to tailor thier systems to thier needs and monitor performance. This reduces costs and accelerates development for large-scale, reliable systems.

This reduces costs and accelerates development for large-scale, reliable systems. In live streaming for example, a distributed system simulation environment allows testing of content delivery, load balancing, and fault tolerance under varying network conditions. It helps ensure smooth streaming experiences by simulating high traffic and server failures. For Tubi, a free streaming service offering a vast library of movies and TV shows, it could be used to model content distribution across multiple regions, testing how their system handles sudden spikes in viewers during popular shows or events. This enables proactive optimization and ensures uninterrupted streaming quality.
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
