# CS3219-Assignment-D

## Things to take note

1. Do note that the leader ID shown (101, 102, 103) are refer to broker1, broker2 and broker3 respectively.

1. The procedure is tested on Windows only, hence the instructions are based on windows.

1. We will have 3 terminals running together for this assignment, let call them as the following:

   1. setup-terminal
   1. producer-terminal
   1. consumer-terminal

1. Do not include the **""** when you run the code, it is to highlight the code to differentiate them from the rest.

## Pre-requisite

You are required to have the following installed in order to run successfully.

1. [Docker Desktop](https://docs.docker.com/docker-for-windows/install/)

2. [Docker-compose](https://docs.docker.com/compose/install/)

3. [Git](https://gitforwindows.org/)

4. [WSL](https://www.windowscentral.com/install-windows-subsystem-linux-windows-10)

## Instructions

### Setup

1.  Install the pre-requisite required for this assignment.

1.  Clone the git repository.

1.  Change directory to the folder which contains the **docker-compose.yml** file.

1.  Run **"docker-compose up -d"** in your terminal, **setup-terminal**.

1.  Make sure that the 3 brokers and 1 zookeeper containers are up.

    - You could verify using Docker Desktop.

    ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/docker-compose.png?raw=true)

1.  Open a new terminal, **producer-terminal**, and run **"bash producer<span/>.sh"**

    - This will create a new container called producer.

1.  Open another terminal, **consumer-terminal**, and run **"bash consumer<span/>.sh"**

    - This will create a new container called consumer.

1.  We need to connect both containers to the network bridge by using **"bash connect_network<span/>.sh"** on the setup-terminal.

1.  Run **"kafka-topics<span/>.sh --bootstrap-server broker1:9092 --create --topic first-topic --replication-factor 3 --partitions 1"** in the **producer-terminal**.

    - This will create a new topic called first-topic with only one partition.

    ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/create-topic.png?raw=true)

1.  Run **"kafka-topics<span/>.sh --bootstrap-server broker1:9092 --describe --topic first-topic"** in the **producer-terminal**.

    - This will shows the details of the topic as shown below
    - Do note that the leader broker for the partition could be different, it depends on which broker the zookeeper choose.
    - For the current case, broker3 (broker ID: 103) has been choosen as leader broker.

    ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/describe-topic.png?raw=true)

1.  Run **"kafka-topics<span/>.sh --bootstrap-server broker1:9092 --list"** in the same terminal, **producer-terminal**. \
    You should see only one topic which called **first-topic** \
     ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/list-topic.png?raw=true)

### Normal operation

1.  Run **"kafka-console-consumer<span/>.sh --bootstrap-server broker1:9092,broker2:9092,broker3:9092 --topic first-topic --from-beginning"** in the **consumer-terminal** to create a consumer.

1.  Run **"kafka-console-producer<span/>.sh --broker-list broker1:9092,broker2:9092,broker3:9092 --topic first-topic"** in the **producer-terminal** to create a producer.

1.  You could start typing any words in the **producer-terminal**. \
    Take note that your **consumer-terminal** should print the message which you have type inside your **producer-terminal**.

### Simulate when leader broker down

1.  Let stimulate when the leader broker has broken by running **"docker-compose stop kafka-X"** in the **setup-terminal**.

    - Do take note that the kafka-X is based on which broker being selected as leader broker.
    - For the current case is kafka-3, as our broker 3 is being selected as the leader broker for the partition.
    - Do take note that the zookeeper might take some time to notice that the leader broker is not available.

1.  You could still type words in the **producer-terminal**. \
    Take note that your **consumer-terminal** should print the message which you have type inside your **producer-terminal**.

1.  Let stop our producer by running **"Ctrl + C"** in the **producer-terminal**.

1.  Run **"kafka-topics<span/>.sh --bootstrap-server brokerX:9092 --describe --topic first-topic"** in the setup portion, you should see the leader broker has been changed.

    - Take note that you need to change the brokerX to any broker cotainer which is running.
    - In current case, we could only use broker1 or broker2, as broker3 is already down.
    - You could see that our leader broker has change to broker1 (broker ID: 101). \
      ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/leader-change.png?raw=true)

## Credits

For this assignment, I will be using the images from [wurstmeister/kafka](https://hub.docker.com/r/wurstmeister/kafka) and [wurstmeister/zookeeper](https://hub.docker.com/r/wurstmeister/zookeeper) for my
brokers and zookeeper.
