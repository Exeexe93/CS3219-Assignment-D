# CS3219-Assignment-D

Do note that the leader ID shown (101, 102, 103) are refer to broker1, broker2 and broker3 respectively.

## Pre-requisite

You are required to have the following installed in order to run successfully.

1. Docker Desktop ([Windows](https://docs.docker.com/docker-for-windows/install/), [Mac](https://docs.docker.com/docker-for-mac/))

2. [Docker-compose](https://docs.docker.com/compose/install/)

3. Git ([Windows](https://gitforwindows.org/), [Mac](https://git-scm.com/download/mac))

## Instructions

1.  Install the pre-requisite required for this assignment.

1.  Clone the git repository.

1.  Change directory to the folder which contains the **docker-compose.yml** file.

1.  Run **docker-compose up -d** in your terminal.

1.  Make sure that the 3 brokers and 1 zookeeper containers are up.

    - You could verify using Docker Desktop.

    ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/docker-compose.png?raw=true)

1.  Open another terminal and run **docker exec -ti broker1 /bin/sh**

1.  Run **kafka-topics<span/>.sh --bootstrap-server :9092 --create --topic first-topic --replication-factor 3** in the same terminal \
    This will create a new topic called first-topic.

1.  Run **kafka-topics<span/>.sh --bootstrap-server :9092 --describe --topic first-topic** in the same terminal.

    - This will shows the details of the topic as shown below
    - Do note that the leader broker for the partition could be different, it depends on which broker the zookeeper choose.
    - For the current case, broker2 (broker ID: 102) has been choosen as leader broker.

    ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/describe-topic.png?raw=true)

1.  Run **kafka-topics<span/>.sh --bootstrap-server :9092 --list** in the same terminal. \
    You should see only one topic which called **first-topic** \
     ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/list-topic.png?raw=true)

1.  Run **kafka-console-consumer<span/>.sh --bootstrap-server :9092 --topic first-topic --from-beginning** in the same terminal to create a consumer.

1.  Open another new terminal, run **docker exec -ti broker1 /bin/sh** \
    Do note that you can use either broker 2 or broker3 instead of broker1.

1.  Run **kafka-console-producer<span/>.sh --broker-list :9092 --topic first-topic** to create a producer.

1.  You could start typing any words in the producer terminal. \
    Take note that your consumer terminal should print the message which you have type inside your producer terminal.

1.  Let stimulate when the leader broker has broken by running **docker-compose stop kafka-X**

    - Do take note that the kafka-X is based on which broker being selected as leader broker.
    - For the current case is kafka-2, as our broker 2 is being selected as the leader broker for the partition.
    - Do take note that the zookeeper will take some time to notice that the leader broker is not available.

1.  If your consumer or producer terminals run via the container of the leader broker, it should be down. Do run them again using the command in step 11.

    - Do take note that you should not use the broker which has been stopped.
    - For the current case, we should use either broker1 or broker3.

1.  Start running the consumer or producer by using the command in step 10 or step 12 respectively.

1.  Open another new terminal and run the command in step 11.

    - Do take note that you should not use the broker which has been stopped.

1.  Run the command in step 8 in the same terminal, you should see the leader broker has been changed.

    - You could see that our leader broker has change to broker1 (broker ID: 101). \
      ![.travis.yml](https://github.com/Exeexe93/CS3219-Assignment-D/blob/master/images/leader-change.png?raw=true)

1.  You could continue type the messages in your producer terminal and your consumer terminal should print out the same messages.

## Credits

For this assignment, I will be using the images from [wurstmeister/kafka](https://hub.docker.com/r/wurstmeister/kafka) and [wurstmeister/zookeeper](https://hub.docker.com/r/wurstmeister/zookeeper) for my
brokers and zookeeper.
